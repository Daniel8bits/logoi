#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
BUNDLE="${ROOT}/build/linux/x64/release/bundle"
OUT="${ROOT}/dist/logoi-linux-x64.tar.gz"

if [[ ! -d "$BUNDLE" ]]; then
  echo "Linux bundle not found: $BUNDLE" >&2
  exit 1
fi

mkdir -p "${ROOT}/dist"
tar -C "$BUNDLE" -czf "$OUT" .
if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
  echo "tarball=${OUT}" >> "$GITHUB_OUTPUT"
fi
