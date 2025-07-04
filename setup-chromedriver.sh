#!/bin/bash
set -e

echo "Obteniendo URL de ChromeDriver..."
curl -s https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json > versions.json

CHROMEDRIVER_URL=$(grep -o 'https.*chromedriver-linux64.zip' versions.json | head -1)

if [ -z "$CHROMEDRIVER_URL" ]; then
  echo "❌ No se pudo obtener la URL de ChromeDriver"
  exit 1
fi

echo "URL: $CHROMEDRIVER_URL"
curl -Lo chromedriver.zip "$CHROMEDRIVER_URL"
unzip chromedriver.zip
mv chromedriver-linux64/chromedriver /usr/local/bin/
chmod +x /usr/local/bin/chromedriver
