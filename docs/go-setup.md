# Go Development Setup

Go is installed via **Mise** and configured automatically. This doc covers the manual post-install steps.

## 1. Install Go Tools

After `mise install`, install the language server and linter:

```bash
go install golang.org/x/tools/gopls@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

These binaries install to `~/go/bin`, which is already in your PATH.

## 2. Verify Setup

```bash
go version          # Should show the installed version
which gopls         # Should point to ~/go/bin/gopls
which golangci-lint # Should point to ~/go/bin/golangci-lint
```

## 3. Editor Integration

### VS Code
The `golang.go` extension is installed via Brewfile. On first open of a `.go` file, it will prompt to install additional tools - accept all.

### Zed
Zed has built-in Go support via `gopls`. No additional configuration needed.

## 4. Fish Abbreviations

These are configured in `config.fish`:

| Abbr | Command |
|------|---------|
| `gr` | `go run .` |
| `gb` | `go build` |
| `gt` | `go test ./...` |
| `gmt` | `go mod tidy` |

## 5. New Project Quick Start

```bash
mkdir myproject && cd myproject
go mod init github.com/yourusername/myproject
```