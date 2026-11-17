import { defineConfig } from 'astro/config';

// Endereço oficial: https://expedientegestao.com.br/escolas/ (Cloudflare Workers com arquivos estáticos, projeto "expediente").
// A publicação monta a pasta "publicar/" com o site dentro de /escolas e o _redirects da raiz.
// O endereço antigo (jwdataconsulting.com.br/jw-escolas, GitHub Pages) só redireciona para cá.
export default defineConfig({
  site: 'https://expedientegestao.com.br',
  base: '/escolas',
  build: { inlineStylesheets: 'auto' },
});