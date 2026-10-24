#!/bin/sh
# Gera docs/index.html (PWA instalável) a partir de src/app.html
cd "$(dirname "$0")"
{
cat <<'HEAD'
<!doctype html><html lang="pt"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">
<meta name="theme-color" content="#0a0e13">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<link rel="manifest" href="manifest.webmanifest">
<link rel="icon" href="icon.svg" type="image/svg+xml">
<link rel="apple-touch-icon" href="icon-512.png">
<meta name="apple-mobile-web-app-title" content="HXN - Tesla">
<style>:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px);box-sizing:border-box;height:100%}*{box-sizing:border-box}[hidden]{display:none!important}</style>
</head><body>
HEAD
cat src/app.html
cat <<'TAIL'
<script>if("serviceWorker" in navigator)navigator.serviceWorker.register("sw.js").catch(()=>{});</script>
</body></html>
TAIL
} > docs/index.html
echo "docs/index.html gerado"

