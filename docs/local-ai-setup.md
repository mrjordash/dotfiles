# 🧠 Local AI Setup (Ollama + Qwen)

We use a hybrid approach: **Claude Code** (Paid/Cloud) for architecture and **Qwen 2.5** (Free/Local) for autocomplete and privacy.

## 1. The Engine (Ollama)
Ollama should be installed via Homebrew. Ensure the service is running:

```bash
brew services start ollama
```

## 2. The Model (Qwen 2.5 Coder)

We use `qwen2.5-coder` for its superior coding benchmarks. Choose the size based on your machine's RAM:

```bash
ollama pull qwen2.5-coder:14b
```

| Model | RAM Req | Use Case               | Command                       |
|-------|---------|------------------------|-------------------------------|
| 7B    | 8GB+    | Speed / Autocomplete   | ollama pull qwen2.5-coder:7b  |
| 14B   | 16GB+   | Recommended (Balanced) | ollama pull qwen2.5-coder:14b |
| 32B   | 32GB+   | Deep Logic / Refactoring | ollama pull qwen2.5-coder:32b|

## 3. Zed Editor Integration

Your Zed settings (`settings.json`) are configured to look for Ollama.

To use it:
* Open the Assistant Panel (`Cmd + ?` or `Cmd + R`).
* Select Ollama (`qwen2.5-coder`) from the dropdown.
* Use `Ctrl + Enter` in any file for inline code generation.

## 4. Terminal Usage

Use the alias `q` (defined in `config.fish`) for quick questions:

```bash
q "Explain this regex: ^[a-z0-9]+$"
```

## 5. VS Code Integration (Continue.dev)

We use the **Continue** extension.

1. **Install:** `code --install-extension continue.continue`
2. **Config:** The configuration is managed via dotfiles (`~/.continue/config.json`).
3. **Usage:**
   - **Chat:** `Cmd + L` (Opens sidebar)
   - **Edit:** `Cmd + I` (Inline diff)
   - **Autocomplete:** Just type (uses local Qwen/Starcoder)


## 6. Running Claude Code Locally (Hybrid Mode)

cYou can run the official `claude` CLI with local models to save costs on simpler tasks.

**Usage:**
- Type `c` for the official API (Paid).
- Type `cl` for the local Qwen model (Free).

**Configuration:**
This is managed via a Fish abbreviation that overrides `ANTHROPIC_BASE_URL`.
