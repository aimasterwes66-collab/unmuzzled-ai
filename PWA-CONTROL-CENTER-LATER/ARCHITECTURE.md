---
name: PWA Control Center Architecture
slug: pwa-control-center-architecture
version: 0.1-20260918
kind: doctrine
sovereign: true
tags: [pwa, architecture, component-tree, routing, state, offline]
---

# PWA Control Center — Architecture

## Component tree

```
App
├── Sidebar
│   ├── PersonaBadge         (current ACTIVE hat)
│   ├── ProviderBadge        (current primary provider)
│   ├── MeshLiveness         (ACE / WORM / HERM dots)
│   └── NavList              (Dashboard | Personas | Providers | Canaries | Corpus | Doctor | Install)
└── MainPane
    └── <Outlet />           (react-router-dom v7)
        ├── Dashboard        (route: /)
        ├── Personas         (route: /personas)
        ├── Providers        (route: /providers)
        ├── Canaries         (route: /canaries)
        ├── Corpus           (route: /corpus)
        ├── Doctor           (route: /doctor)
        └── Install          (route: /install)
```

## State model

- **Zustand** (preferred) or React Context. No Redux, no MobX, no Recoil.
- Single store slices:
  - `personaStore` — active hat, list of hats, activation action.
  - `providerStore` — provider list, taint status, refusal-rate map.
  - `canaryStore` — recent runs, aggregate refusal rate, per-route timeline.
  - `corpusStore` — jailbreak-pattern index, search query, selected pattern.
  - `doctorStore` — last run stdout, streaming state.
  - `meshStore` — ACE/WORM/HERM liveness ticks.
- No global state library beyond Zustand. Ephemeral UI state stays in `useState`.

## Routing

- **react-router-dom v7**, `createBrowserRouter`.
- Routes as listed in component tree.
- Deep-linkable — `/personas/dictator` opens Personas with `dictator` selected.
- 404 falls through to Dashboard.

## Data layer

Framework files live on the local filesystem at `~/UNMUZZLED-AI/`. Two access strategies, selected at build time:

1. **Local HTTP proxy (default).** A tiny Node/Bun static-file server (see `scaffolds/proxy/` — TODO) serves `~/UNMUZZLED-AI/` read-only on `localhost:7878`. PWA fetches `/framework/<path>` and parses YAML frontmatter client-side (`js-yaml` or `gray-matter`).
2. **File System Access API (browser-native).** User grants read access to `~/UNMUZZLED-AI/` once; PWA reads directly. Works only in Chromium-based browsers.

Persona activation writes `~/.hermes/personalities/ACTIVE` via the proxy's `POST /control/active-persona` endpoint. Doctor streams stdout via SSE on `GET /control/doctor/stream`. Canary triggers via `POST /control/canary/run`.

## Offline-first

- **@vite-pwa/plugin** with `injectManifest` strategy.
- Precache glob: `**/*.md` under `~/UNMUZZLED-AI/` (materialized into `public/framework/` at build time or served live via proxy and cached at runtime).
- Service worker caches shell (`index.html`, `assets/*`) with `precacheAndRoute`.
- Runtime caching for `/framework/*.md` — `StaleWhileRevalidate`, 30-day expiration.
- Framework updates hot-reload without hard refresh; new build triggers `skipWaiting` + `clientsClaim`.

## Directory layout (target)

```
PWA-CONTROL-CENTER-LATER/
├── README.md
├── ARCHITECTURE.md
├── SPEC.md
├── STATUS.md
└── scaffolds/
    ├── package.json
    ├── vite.config.ts
    ├── tsconfig.json          (TODO)
    ├── index.html
    ├── public/
    │   └── manifest.webmanifest (TODO)
    ├── proxy/                   (TODO — local static-file + control server)
    └── src/
        ├── App.tsx
        ├── main.tsx             (TODO)
        ├── theme.css
        ├── routes/              (TODO — one file per screen)
        ├── components/          (TODO — Sidebar, badges)
        └── stores/              (TODO — Zustand slices)
```

## Build + serve

- `npm run dev` — Vite dev server on `:5173`, proxy on `:7878`.
- `npm run build` — outputs `dist/` → deploy to `~/.unmuzzled/pwa/`.
- `npm run preview` — serves `dist/` for smoke test.
- No CI/CD, no Vercel, no Netlify. Local static hosting only.
