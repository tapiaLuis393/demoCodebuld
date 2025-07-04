#!/bin/bash
set -e

echo "Descargando JSON de versiones..."
curl -s https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json -o versions.json

echo "Estructura JSON (claves top-level):"
jq 'keys' versions.json

echo "Intentando extraer URL chromedriver linux64..."
CHROMEDRIVER_URL=$(jq -r '.channels.stable.downloads.chromedriver[] | select(.platform=="linux64") | .url' versions.json || echo "No se pudo extraer URL")

echo "URL extraída: $CHROMEDRIVER_URL"

if [[ "$CHROMEDRIVER_URL" == "No se pudo extraer URL" || -z "$CHROMEDRIVER_URL" ]]; then
  echo "❌ No se pudo obtener la URL de ChromeDriver"
  exit 1
fi

curl -Lo chromedriver.zip "$CHROMEDRIVER_URL"
unzip chromedriver.zip
mv chromedriver-linux64/chromedriver /usr/local/bin/
chmod +x /usr/local/bin/chromedriver
