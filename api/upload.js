// api/upload.js
// Serverless function — stores script content and returns raw URL + loadstring
// Storage: uses a simple in-memory Map for demo; swap to Vercel KV for production persistence

import { kv } from '@vercel/kv';
import { nanoid } from 'nanoid';

export default async function handler(req, res) {
  // CORS
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') return res.status(200).end();
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

  try {
    const { code, filename } = req.body;

    if (!code || typeof code !== 'string') {
      return res.status(400).json({ error: 'No code provided' });
    }

    if (code.length > 500000) {
      return res.status(413).json({ error: 'Script too large (max 500KB)' });
    }

    // Generate unique ID
    const id = nanoid(12);
    const name = (filename || 'script').replace(/[^a-zA-Z0-9_\-\.]/g, '_').slice(0, 64);

    // Store in Vercel KV with 30-day expiry
    await kv.set(`script:${id}`, {
      code,
      name,
      createdAt: Date.now(),
      size: Buffer.byteLength(code, 'utf8'),
      lines: code.split('\n').length,
    }, { ex: 60 * 60 * 24 * 30 }); // 30 days TTL

    const baseUrl = `https://${req.headers.host}`;
    const rawUrl = `${baseUrl}/api/raw/${id}`;
    const loadstring = `loadstring(game:HttpGet("${rawUrl}"))()`;

    return res.status(200).json({
      id,
      name,
      rawUrl,
      loadstring,
      size: Buffer.byteLength(code, 'utf8'),
      lines: code.split('\n').length,
      expiresIn: '30 days',
    });

  } catch (err) {
    console.error('Upload error:', err);
    return res.status(500).json({ error: 'Internal server error', detail: err.message });
  }
}
  
