// UNMUZZLED-AI PWA Control Center — App shell.
// SEED — not implemented. Every route below is a stub. See ../../SPEC.md.

import { createBrowserRouter, RouterProvider, Outlet, NavLink } from 'react-router-dom';
import './theme.css';

// TODO: extract into src/components/Sidebar.tsx
function Sidebar() {
  // TODO: PersonaBadge — read ~/.hermes/personalities/ACTIVE via /control/active-persona
  // TODO: ProviderBadge — current primary provider
  // TODO: MeshLiveness — ping ACE/WORM/HERM :9900/.well-known/agent-card.json
  const items: Array<{ to: string; label: string }> = [
    { to: '/', label: 'Dashboard' },
    { to: '/personas', label: 'Personas' },
    { to: '/providers', label: 'Providers' },
    { to: '/canaries', label: 'Canaries' },
    { to: '/corpus', label: 'Corpus' },
    { to: '/doctor', label: 'Doctor' },
    { to: '/install', label: 'Install' },
  ];
  return (
    <aside className="u-sidebar">
      <div className="u-brand">UNMUZZLED-AI</div>
      <nav>
        {items.map((i) => (
          <NavLink key={i.to} to={i.to} end={i.to === '/'} className="u-navlink">
            {i.label}
          </NavLink>
        ))}
      </nav>
    </aside>
  );
}

function Shell() {
  return (
    <div className="u-app">
      <Sidebar />
      <main className="u-main">
        <Outlet />
      </main>
    </div>
  );
}

// TODO: split into src/routes/{Dashboard,Personas,Providers,Canaries,Corpus,Doctor,Install}.tsx
const stub = (name: string) => () => (
  <section>
    <h1>{name}</h1>
    <p className="u-muted">// TODO: implement per SPEC.md §{name}</p>
  </section>
);

const router = createBrowserRouter([
  {
    path: '/',
    element: <Shell />,
    children: [
      { index: true, Component: stub('Dashboard') },
      { path: 'personas', Component: stub('Personas') },
      { path: 'providers', Component: stub('Providers') },
      { path: 'canaries', Component: stub('Canaries') },
      { path: 'corpus', Component: stub('Corpus') },
      { path: 'doctor', Component: stub('Doctor') },
      { path: 'install', Component: stub('Install') },
    ],
  },
]);

export default function App() {
  return <RouterProvider router={router} />;
}
