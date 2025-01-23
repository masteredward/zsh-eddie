EDITOR="code --wait"; export EDITOR

zsheddie() {
  local ZSHEDDIE_PATH="$ZSH_CUSTOM"/plugins/zsh-eddie
  case "$1" in
    edit)
       code $ZSHEDDIE_PATH
       ;;
    update)
      git --work-tree=$ZSHEDDIE_PATH --git-dir=$ZSHEDDIE_PATH/.git pull
      echo "Don't forget to reload your shell when pulling changes from git. Use \"exec zsh\"."
      ;;
    cd)
      cd $ZSHEDDIE_PATH
      ;;
    *)
      echo 'Unknown parameter. Allowed: edit|update|cd'
      ;;
  esac
}

convert_time() {
  if [ "$#" -ne 2 ]; then
    echo "Usage: convert_time HH:MM Timezone"
    return 1
  fi

  local input_time="$1"
  local target_tz="$2"

  # Get the current date, but replace the hour and minute with the input time
  local input_date=$(date -d "$input_time" +"%Y-%m-%d %H:%M:%S")

  # Convert the date-time to the target timezone
  TZ="$target_tz" date -d "$input_date" --rfc-3339=seconds
}

update_bun() {
  if ! command -v "bun" > /dev/null; then
    echo "No Bun binary detected. Installing from URL..."
    curl -fsSL https://bun.sh/install | bash
  else
    echo "Bun binary detected. Updating using Bun itself..."
    bun upgrade
  fi
}

update_ohmyzsh() {
  echo "Updating Oh My Zsh..."
  (cd $ZSH && git pull origin master)
  echo "Updating custom plugins..."
  for plugin ($ZSH_CUSTOM/plugins/*); do
    if [[ -d "$plugin/.git" ]]; then
        echo "Updating $plugin..."
        (cd "$plugin" && git pull origin master)
    fi
  done
  echo "Updating custom themes..."
  for theme ($ZSH_CUSTOM/themes/*); do
    if [[ -d "$theme/.git" ]]; then
        echo "Updating $theme..."
        (cd "$theme" && git pull origin master)
    fi
  done
  echo "Update complete."
}
