# 🔐 SSH & GPG Signing Setup

This manual step is required to enable **Git Commit Signing** and **GitHub Authentication** if you do not use **1Password**.

*Since private keys are never stored in this repo, they must be generated fresh on each machine.*

## 1. Generate a New SSH Key
We use `ed25519` for modern security.

```bash
# Replace with your actual email
ssh-keygen -t ed25519 -C "jordan.riouxleclair@gmail.com"
```

## 2. Add to macOS Keychain

1. Start Agent:
```bash
eval "$(ssh-agent -s)"
```

2. Configure config:

Ensure `~/.ssh/config` exists and contains:

```
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
```

3. Add key:
```bash
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

## 3. Upload to Github

__For Authentication (Push/Pull):__
```bash
gh ssh-key add ~/.ssh/id_ed25519.pub --title "MacBook $(date +%Y) - Auth" --type authentication
```

__For Signing (Verified Badge):__
```bash
gh ssh-key add ~/.ssh/id_ed25519.pub --title "MacBook $(date +%Y) - Signing" --type signing
```

4. Verify

```bash
ssh -T git@github.com
```

