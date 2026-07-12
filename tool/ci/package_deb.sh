#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
cd "$ROOT"

BUNDLE="build/linux/x64/release/bundle"
if [[ ! -d "$BUNDLE" ]]; then
  echo "Linux bundle not found: $BUNDLE" >&2
  exit 1
fi

VERSION=$(grep -E '^version:' pubspec.yaml | head -1 | awk '{print $2}' | cut -d+ -f1)
mkdir -p dist

NFPM_VERSION="v2.47.0"
NFPM_DIR="${RUNNER_TEMP:-/tmp}/nfpm-bin"
NFPM_BIN="${NFPM_DIR}/nfpm"

if [[ ! -x "$NFPM_BIN" ]]; then
  mkdir -p "$NFPM_DIR"
  curl -sL \
    "https://github.com/goreleaser/nfpm/releases/download/${NFPM_VERSION}/nfpm_${NFPM_VERSION#v}_Linux_x86_64.tar.gz" \
    | tar xz -C "$NFPM_DIR" nfpm
  chmod +x "$NFPM_BIN"
fi

TMP_CONFIG="$(mktemp)"
sed "s/^version: .*/version: \"${VERSION}\"/" packaging/linux/nfpm.yaml > "$TMP_CONFIG"

"$NFPM_BIN" package \
  -f "$TMP_CONFIG" \
  --packager deb \
  --target dist/

deb=$(find dist -maxdepth 1 -name 'logoi_*.deb' -print -quit)
if [[ -z "$deb" ]]; then
  echo "nfpm did not produce a .deb package" >&2
  exit 1
fi

mv "$deb" dist/logoi-linux-amd64.deb

validate_tmpdir="$(mktemp -d)"
trap 'rm -f "$TMP_CONFIG"; rm -rf "$validate_tmpdir"' EXIT
dpkg-deb -x dist/logoi-linux-amd64.deb "$validate_tmpdir"
test -f "$validate_tmpdir/opt/logoi/logoi"
test -f "$validate_tmpdir/opt/logoi/lib/libpdfium.so"
test -d "$validate_tmpdir/opt/logoi/data"

if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
  echo "deb=${ROOT}/dist/logoi-linux-amd64.deb" >> "$GITHUB_OUTPUT"
fi
