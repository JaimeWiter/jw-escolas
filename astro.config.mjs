import { defineConfig } from 'astro/config';

// Versão de teste: https://jwdataconsulting.com.br/jw-escolas/ (GitHub Pages do repositório jw-escolas).
// Ao mudar para o subdomínio escolas.jwdataconsulting.com.br: site = esse endereço e base = '/'.
export default defineConfig({
  site: 'https://jwdataconsulting.com.br',
  base: '/jw-escolas',
  build: { inlineStylesheets: 'auto' },
});
