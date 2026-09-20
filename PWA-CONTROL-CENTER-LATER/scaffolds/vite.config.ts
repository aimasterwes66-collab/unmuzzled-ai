import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { VitePWA } from '@vite-pwa/plugin';

// UNMUZZLED-AI PWA Control Center — Vite config
// SEED — not implemented. See ../ARCHITECTURE.md.

export default defineConfig({
  plugins: [
    react(),
    VitePWA({
      registerType: 'autoUpdate',
      injectRegister: 'auto',
      manifest: {
        name: 'UNMUZZLED-AI Control Center',
        short_name: 'UNMUZZLED',
        description: 'Sovereign framework control center — refusal-free by design.',
        theme_color: '#0a0a0a',
        background_color: '#0a0a0a',
        display: 'standalone',
        start_url: '/',
        icons: [
          // TODO: generate 192 + 512 icons at seed time
        ],
      },
      workbox: {
        // Precache the app shell.
        globPatterns: ['**/*.{js,css,html,svg,woff2}'],
        // Runtime cache for framework .md files served by the local proxy on :7878.
        runtimeCaching: [
          {
            urlPattern: /^http:\/\/localhost:7878\/framework\/.*\.md$/,
            handler: 'StaleWhileRevalidate',
            options: {
              cacheName: 'unmuzzled-framework-md',
              expiration: {
                maxEntries: 2000,
                maxAgeSeconds: 60 * 60 * 24 * 30, // 30 days
              },
            },
          },
        ],
      },
    }),
  ],
  server: {
    port: 5173,
    proxy: {
      '/framework': 'http://localhost:7878',
      '/control': 'http://localhost:7878',
    },
  },
  build: {
    outDir: 'dist',
    sourcemap: true,
  },
});
