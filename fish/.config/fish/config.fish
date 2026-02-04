# Claude Code Configuration
export CLAUDE_CODE_THEME="dark"
export CLAUDE_NO_GREETING="true" # Skip the "Welcome to Claude Code" banner

if status is-interactive
    starship init fish | source
    mise activate fish | source
    zoxide init fish | source
    direnv hook fish | source

    fastfetch
end

# Remap standard commands
alias ls="eza --icons --git -a"
alias cat="bat"

# QOL
abbr reload "source ~/.config/fish/config.fish"

# Git
abbr -a g git
abbr -a gs "git status"
abbr -a ga "git add ."
abbr -a gc "git commit -m"
abbr -a gp "git push"
abbr -a gl "git pull"
abbr -a lg lazygit

# Docker
abbr -a d docker
abbr -a dc "docker compose"
abbr -a lzd lazydocker

# Elixir / Phoenix
abbr -a m mix
abbr -a mps "mix phx.server"
abbr -a iexm "iex -S mix"

# Go
abbr -a gr "go run ."
abbr -a gb "go build"
abbr -a gt "go test ./..."
abbr -a gmt "go mod tidy"

# Navigation
abbr -a .. "cd .."
abbr -a ... "cd ../.."
abbr -a ll "eza -l -g --icons" # Long list with icons
abbr -a la "eza -la -g --icons" # List all (hidden)
abbr -a cc "cd ~/Code"

# Claude Code Shortcuts
# -y = auto-confirm read-only actions (yolo mode)
# -p = print output directly to stdout (good for piping)
abbr c "claude"
abbr cy "claude --dangerously-skip-permissions"

# 1Password SSH Agent
# This points SSH to the 1Password socket
set -gx SSH_AUTH_SOCK "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
fish_add_path -g "$HOME/.local/bin"
fish_add_path -g "$HOME/go/bin" # Go binaries (gopls, etc.)
