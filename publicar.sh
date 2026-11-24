#!/bin/sh
# Monta e publica o site em https://expedientegestao.com.br/escolas/ (Cloudflare, projeto "expediente").
# Uso: sh publicar.sh   (precisa de "npx wrangler login" feito uma vez)
set -e
cd "$(dirname "$0")"
npx astro build
rm -rf publicar && mkdir -p publicar/escolas
cp -r dist/. publicar/escolas/
# Painel clássico (React + Vite, JW-marca/painel-classico): as mesmas abas e números da versão completa.
(cd ../painel-classico && npm run build)
mkdir -p publicar/escolas/painel-classico
cp -r ../painel-classico/dist/. publicar/escolas/painel-classico/
# Radar de Gestão (repositório DashboardsInreact, Next.js exportado com basePath /escolas/insights).
RADAR="../../DashboardsInreact"
(cd "$RADAR" && npm run build)
mkdir -p publicar/escolas/insights
cp -r "$RADAR/out/." publicar/escolas/insights/
# Clínicas (pasta Expediente-clinicas): acesso direto, fora do Google (noindex no HTML e no _headers),
# sem links a partir de /escolas. Site em /clinicas e os dois painéis de demonstração.
CLIN="../../Expediente-clinicas"
(cd "$CLIN/site" && npx astro build)
mkdir -p publicar/clinicas
cp -r "$CLIN/site/dist/." publicar/clinicas/
(cd "$CLIN/paineis/classico" && npm run build)
mkdir -p publicar/clinicas/painel-classico
cp -r "$CLIN/paineis/classico/dist/." publicar/clinicas/painel-classico/
(cd "$CLIN/paineis/radar" && npm run build)
mkdir -p publicar/clinicas/radar
cp -r "$CLIN/paineis/radar/dist/." publicar/clinicas/radar/
# Enquanto não existe a página da empresa, a raiz leva para /escolas/.
printf '/  /escolas/  302\n/escolas  /escolas/  301\n/clinicas  /clinicas/  301\n' > publicar/_redirects
# Endereços antigos dos painéis (17/11) levam para os novos.
printf '/escolas/painel-360/*  /escolas/insights/  301\n/escolas/painel-demo/*  /escolas/painel-classico/  301\n' >> publicar/_redirects
cp _headers.modelo publicar/_headers
find publicar -iname desktop.ini -delete  # arquivos ocultos do Windows travam o wrangler
npx wrangler deploy
