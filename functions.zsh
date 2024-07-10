pipup() {
  if ! command -v "pip" > /dev/null; then
    echo "No pip command found. Are you in a virtualenv?"
    return 1
  fi
  if [[ -f "requirements.txt" ]]; then
    echo "requirements.txt found. Installing/Updating."
    pip install --upgrade -r requirements.txt
  else
    echo "No requirements.txt file found. Skipping..."
  fi
  if [[ -f "requirements-dev.txt" ]]; then
    echo "requirements-dev.txt found. Installing/Updating."
    pip install --upgrade -r requirements-dev.txt
  else
    echo "No requirements-dev.txt file found. Skipping..."
  fi
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

update_nvm() {
  # Check if nvm is installed
  if type nvm > /dev/null 2>&1; then
    echo "Updating NVM..."

    # Fetch the latest version of nvm from GitHub and update
    (
      cd "$NVM_DIR"
      git fetch --tags origin
      git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
    ) && . "$NVM_DIR/nvm.sh"
    echo "NVM has been updated to the latest version."
    echo "NVM binary version: $(nvm --version)"
  else
    echo "NVM is not installed. Please install it first."
  fi
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

kube_test_sa() {
  local SA="$1"
  local NAMESPACE="$2"
  kubectl run --rm -it \
      testaccess-"$SA" \
      -n "$NAMESPACE" \
      --image=public.ecr.aws/aws-cli/aws-cli:latest \
      --overrides='{"spec": {"serviceAccountName": "'$SA'"}}' --command /bin/bash
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
