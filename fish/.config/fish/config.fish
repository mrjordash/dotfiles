starship init fish | source
mise activate fish | source

if status is-interactive
    fastfetch
end

# Remap standard commands
alias ls="eza --icons --git -a"
alias cat="bat"

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

# Navigation
abbr -a .. "cd .."
abbr -a ... "cd ../.."
abbr -a ll "eza -l -g --icons" # Long list with icons
abbr -a la "eza -la -g --icons" # List all (hidden)abbr -a c "cd ~/Code"


# 1Password SSH Agent
# This points SSH to the 1Password socket
set -gx SSH_AUTH_SOCK "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
