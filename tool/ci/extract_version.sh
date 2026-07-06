#!/usr/bin/env bash
set -euo pipefail

# Reads version from pubspec.yaml: "0.1.0+1" -> version=0.1.0, build=1, tag=v0.1.0
line=$(grep -E '^version:' pubspec.yaml | head -1 | awk '{print $2}')
version="${line%%+*}"
build="${line#*+}"
if [[ "$build" == "$line" ]]; then
  build="0"
fi

echo "version=$version" >> "${GITHUB_OUTPUT:-/dev/stdout}"
echo "build=$build" >> "${GITHUB_OUTPUT:-/dev/stdout}"
echo "tag=v${version}" >> "${GITHUB_OUTPUT:-/dev/stdout}"
