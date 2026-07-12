#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"

bash "$(dirname "$0")/package_linux_tarball.sh" "$ROOT"
bash "$(dirname "$0")/package_deb.sh" "$ROOT"
