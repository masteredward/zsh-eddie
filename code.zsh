# Set EDITOR: prefer code-insiders, then code, fallback to nano
if command -v code-insiders &> /dev/null; then
  EDITOR="code-insiders --wait"
elif command -v code &> /dev/null; then
  EDITOR="code --wait"
else
  EDITOR="nano"
fi
export EDITOR

vscode_settings() {
  if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) is not installed. Please install it first."
    return 1
  fi
  if ! gh auth status &> /dev/null; then
    echo "GitHub CLI (gh) is not authenticated. Please run 'gh auth login' first."
    return 1
  fi
  case "$1" in
    first-backup)
      echo "Backing up VSCode settings to Gist for the first time..."
      gh gist create ~/.config/Code/User/settings.json -d "VSCode Settings Backup" -f settings.json
      ;;
    backup)
      echo "Backing up VSCode settings to Gist..."
      gh gist edit $(gh gist list | grep "VSCode Settings Backup" | awk '{print $1}') -a ~/.config/Code/User/settings.json
      ;;
    restore)
      echo "Restoring VSCode settings from Gist..."
      gh gist view $(gh gist list | grep "VSCode Settings Backup" | awk '{print $1}') -f settings.json > ~/.config/Code/User/settings.json
      ;;
    *)
      echo "Usage: vscode_settings {first-backup|backup|restore}"
      ;;
  esac
}