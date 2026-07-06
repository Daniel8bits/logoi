# GitHub Actions Secrets

Secrets required for automated releases on the `release` branch.

## GPG signing

| Secret | Required | Description |
|---|---|---|
| `GPG_PRIVATE_KEY` | Yes | ASCII-armored private key for release signing |
| `GPG_PASSPHRASE` | If key has passphrase | Passphrase for the private key |

### Generate a release key

```bash
gpg --full-generate-key
# RSA 4096, no expiration (or plan rotation), name: Logoi Releases
```

List keys and copy the key ID / fingerprint:

```bash
gpg --list-secret-keys --keyid-format=long
```

Export the private key for GitHub Actions:

```bash
gpg --armor --export-secret-keys YOUR_KEY_ID > private.key
```

Add the contents of `private.key` as repository secret `GPG_PRIVATE_KEY`.
Add the key passphrase as `GPG_PASSPHRASE` (leave unset if the key has no passphrase).

**Delete `private.key` from disk after configuring secrets.**

### Publish the public key

Export and commit (or publish in README):

```bash
gpg --armor --export YOUR_KEY_ID > .github/gpg/logoi-release.pub
```

Users verify downloads with:

```bash
gpg --import logoi-release.pub
gpg --verify SHA256SUMS.asc SHA256SUMS
sha256sum -c SHA256SUMS
```

### Key rotation

If the private key is compromised:

1. Revoke: `gpg --gen-revoke YOUR_KEY_ID`
2. Generate a new key pair
3. Update `GPG_PRIVATE_KEY`, `GPG_PASSPHRASE`, and `.github/gpg/logoi-release.pub`

## CI pull requests

No secrets are required for PR workflows (`ci.yml`). Builds are unsigned; GPG signing runs only on release.

## Permissions

The release workflow needs `contents: write` to create tags and GitHub Releases. This is configured in `release.yml`.
