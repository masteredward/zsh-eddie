alias mminst="zsh <(curl -L micro.mamba.pm/install.sh)"
alias mm='micromamba'
alias mmu='micromamba update'
alias mmsu='micromamba self-update'
alias mma='micromamba activate'
alias mmd='micromamba deactivate'
alias mmls='ls $MAMBA_ROOT_PREFIX/envs'

mmc() {
  if [[ $# -lt 2 ]]; then
    echo "Usage: mmc <prefix> <package=version> [<package2=version2> ...]"
    return 1
  fi
  local prefix="$1"
  shift
  micromamba create -p "$prefix" "$@"
}

mmrm() {
  if [[ -n "$MAMBA_ROOT_PREFIX" ]]; then
    if [[ "$1" != "" ]]; then
      echo "Deleting environment $1"
      rm -rf "$MAMBA_ROOT_PREFIX"/envs/"$1"
    else
      echo "Environment name parameter needed!"
    fi
  else
    echo "MAMBA_ROOT_PREFIX variable is not set!"
  fi
}

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

npmup() {
  local packages=($(npm list -g --depth=0 --parseable | awk -F/ '{print $NF}' | grep -v 'npm@'))

  for package in $packages; do
    echo "Updating $package..."
    npm install -g $package
  done

  echo "All global npm packages are updated."
}