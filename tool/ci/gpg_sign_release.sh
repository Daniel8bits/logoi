#!/usr/bin/env bash
set -euo pipefail

ARTIFACTS_DIR="${1:?Usage: gpg_sign_release.sh <artifacts-dir>}"

cd "$ARTIFACTS_DIR"

shopt -s nullglob
files=(logoi-*)
if [[ ${#files[@]} -eq 0 ]]; then
  echo "No release artifacts (logoi-*) found in $ARTIFACTS_DIR" >&2
  exit 1
fi

sha256sum logoi-* > SHA256SUMS

if [[ -z "${GPG_PRIVATE_KEY:-}" ]]; then
  echo "GPG_PRIVATE_KEY is not set. Configure repository secrets — see .github/SECRETS.md" >&2
  exit 1
fi

gpgconf --kill gpg-agent 2>/dev/null || true
export GNUPGHOME="${RUNNER_TEMP}/gnupg"
mkdir -p "$GNUPGHOME"
chmod 700 "$GNUPGHOME"

echo "$GPG_PRIVATE_KEY" | gpg --batch --import

KEY_ID=$(gpg --batch --list-secret-keys --with-colons | awk -F: '$1 == "sec" { print $5; exit }')
if [[ -z "$KEY_ID" ]]; then
  echo "Failed to import GPG private key" >&2
  exit 1
fi

FINGERPRINT=$(gpg --batch --list-secret-keys --with-colons "$KEY_ID" | awk -F: '$1 == "fpr" { print $10; exit }')

sign_args=(--batch --yes --local-user "$KEY_ID" --detach-sign --armor -o SHA256SUMS.asc SHA256SUMS)
if [[ -n "${GPG_PASSPHRASE:-}" ]]; then
  sign_args=(--batch --yes --pinentry-mode loopback --passphrase "$GPG_PASSPHRASE" --local-user "$KEY_ID" --detach-sign --armor -o SHA256SUMS.asc SHA256SUMS)
fi

gpg "${sign_args[@]}"

echo "gpg_key_id=$KEY_ID" >> "${GITHUB_OUTPUT:-/dev/stdout}"
echo "gpg_fingerprint=$FINGERPRINT" >> "${GITHUB_OUTPUT:-/dev/stdout}"
