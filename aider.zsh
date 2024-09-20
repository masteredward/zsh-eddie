AIDER_MODEL="openrouter/deepseek/deepseek-chat"; export AIDER_MODEL
AIDER_DARK_MODE=true; export AIDER_DARK_MODE

alias aid="aider --no-show-model-warnings --cache-prompts --no-stream"

get_or_apikey () {
  echo "Fetching openrouter.ai API key from BitWarden using rbw..."
  rbw sync
  echo "OPENROUTER_API_KEY=""$(rbw get openrouter.ai -f "Aider")""; export OPENROUTER_API_KEY" > $ZSH_CUSTOM/openrouter-key.zsh
  echo "Key saved on '$ZSH_CUSTOM/openrouter-key.zsh'. Reload oh-my-zsh using 'exec zsh'"
}