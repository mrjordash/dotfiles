# 🔐 SSH & Git Signing (1Password Method)

We use **1Password** to manage SSH keys. This keeps private keys off the disk and allows Touch ID authorization.

## 1. Enable SSH Agent
1. Open **1Password Settings** > **Developer**.
2. Enable **"Use the SSH agent"**.

## 2. Create Key
1. In 1Password: New Item > **SSH Key**.
2. Title: "GitHub Auth".
3. Save.

## 3. Configure Environment
*This is handled automatically by the Fish config in dotfiles, which sets `SSH_AUTH_SOCK`.*

## 4. Connect to GitHub
1. Open the Key in 1Password.
2. Copy the **Public Key**.
3. Go to [GitHub Keys](https://github.com/settings/keys).
4. Add New Key (Paste the public key).
5. **Important:** Select Key Type "Authentication" (and repeat for "Signing" if needed).

## 5. Verify
Run this in terminal. 1Password should pop up asking for Touch ID.
```bash
ssh -T git@github.com
```