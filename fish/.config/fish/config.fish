starship init fish | source
mise activate fish | source

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
