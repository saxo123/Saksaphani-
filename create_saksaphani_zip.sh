// Saksaphani Vite + React Project
// ملف واحد يحتوي كل الملفات المطلوبة، قم بنسخه إلى مشروعك بنفس الهيكلة

// ============================
// package.json
// ============================
{
  "name": "saksaphani",
  "version": "1.0.0",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^18.3.1",
    "react-dom": "^18.3.1"
  },
  "devDependencies": {
    "vite": "^5.0.0"
  }
}

// ============================
// vite.config.js
// ============================
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
export default defineConfig({ plugins: [react()] })

// ============================
// index.html
// ============================
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Saksaphani</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>

// ============================
// vercel.json
// ============================
{
  "$schema": "https://openapi.vercel.sh/vercel.json",
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "rewrites": [ { "source": "/(.*)", "destination": "/index.html" } ]
}

// ============================
// src/main.jsx
// ============================
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
ReactDOM.createRoot(document.getElementById('root')).render(<App />);

// ============================
// src/App.jsx
// ============================
import React from 'react';
import SellBusinessPage from './SellBusinessPage';
export default function App() { return <SellBusinessPage />; }

// ============================
// src/SellBusinessPage.jsx
// ============================
import React from 'react';
export default function SellBusinessPage() {
  return (
    <div style={{ fontFamily: 'Arial', padding: '20px', maxWidth: '700px', margin: 'auto' }}>
      <h1 style={{ textAlign: 'center', color: '#333' }}>Saksaphani</h1>

      <img
        src="https://via.placeholder.com/700x300.png?text=Saksaphani+Store"
        alt="Store"
        style={{ width: '100%', borderRadius: '10px', marginBottom: '20px' }}
      />

      <h2>بيع نشاط تجاري جاهز</h2>
      <p>
        هذا الموقع مخصص لبيع مشروعك التجاري <strong>Saksaphani</strong>. يمكنك التواصل مباشرة
        للحصول على جميع التفاصيل.
      </p>

      <h3>معلومات الاتصال</h3>
      <ul>
        <li><strong>Email:</strong> almohgirmohcine@gmail.com</li>
        <li><strong>Téléphone:</strong> +212610106321</li>
      </ul>

      <button style={{ padding: '12px 20px', background: 'black', color: 'white', borderRadius: '8px', cursor: 'pointer' }}>
        اتصل الآن
      </button>
    </div>
  );
}
