#!/bin/sh
# Monta e publica o site em https://expedientegestao.com.br/escolas/ (Cloudflare, projeto "expediente").
# Uso: sh publicar.sh   (precisa de "npx wrangler login" feito uma vez)
set -e
cd "$(dirname "$0")"
npx astro build
rm -rf publicar && mkdir -p publicar/escolas
cp -r dist/. publicar/escolas/
# Enquanto não existe a página da empresa, a raiz leva para /escolas/.
printf '/  /escolas/  302\n/escolas  /escolas/  301\n' > publicar/_redirects
npx wrangler deploy
