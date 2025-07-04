#!/bin/bash
set -e

echo "Obteniendo URL de ChromeDriver..."

curl -s https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json -o versions.json

# Extraemos la URL usando jq filtrando solo chromedriver-linux64.zip
CHROMEDRIVER_URL=$(jq -r '.channels.stable.downloads.chromedriver[] | select(.platform=="linux64") | .url' versions.json)

if [ -z "$CHROMEDRIVER_URL" ]; then
  echo "❌ No se pudo obtener la URL de ChromeDriver"
  exit 1
fi

echo "URL: $CHROMEDRIVER_URL"
curl -Lo chromedriver.zip "$CHROMEDRIVER_URL"
unzip chromedriver.zip
mv chromedriver-linux64/chromedriver /usr/local/bin/
chmod +x /usr/local/bin/chromedriver
