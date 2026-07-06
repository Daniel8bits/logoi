#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
APP="${ROOT}/build/macos/Build/Products/Release/logoi.app"
OUT="${ROOT}/dist/logoi-macos.zip"

if [[ ! -d "$APP" ]]; then
  echo "macOS app not found: $APP" >&2
  exit 1
fi

mkdir -p "${ROOT}/dist"
rm -f "$OUT"
ditto -c -k --sequesterRsrc --keepParent "$APP" "$OUT"
echo "artifact=${OUT}" >> "${GITHUB_OUTPUT:-/dev/stdout}"
