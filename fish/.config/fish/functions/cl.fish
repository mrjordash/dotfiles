function cl --description "Run Claude Code locally with Ollama (Qwen)"
    # 1. Ensure the sandbox directory exists
    set -l local_config_dir "$HOME/.claude_local"
    mkdir -p $local_config_dir

    # 2. Set the environment variables just for this command
    #    - XDG_CONFIG_HOME: Tricks Claude into using the sandbox folder (avoids auth conflict)
    #    - ANTHROPIC_BASE_URL: Points to your local Ollama instance
    #    - ANTHROPIC_API_KEY: Dummy key required by the CLI
    env XDG_CONFIG_HOME="$local_config_dir" \
        ANTHROPIC_BASE_URL="http://localhost:11434" \
        ANTHROPIC_API_KEY="ollama" \
        claude --model qwen2.5-coder:14b $argv
end