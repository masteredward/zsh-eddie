nf_list() {
  echo "Available fonts for download on nerd-fonts releases:"
  curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
    | grep -oP '"browser_download_url": "\K[^"]+\.tar\.xz' \
    | awk -F'/' '{print $NF}' \
    | sed 's/\.tar\.xz$//'
  echo "Use nf_install FontName to install the font in your system."
}

nf_install() {
  local NF_NAME="$1"
  echo "Looking in the $NF_NAME font in available in the latest nerd-fonts release..."
  local NF_LIST=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
    | grep -oP '"browser_download_url": "\K[^"]+\.tar\.xz' \
    | awk -F'/' '{print $NF}' \
    | sed 's/\.tar\.xz$//')
  if ! echo "$NF_LIST" | grep -wq "$NF_NAME"; then
    echo "Error: Font '$NF_NAME' is not on the release list."
    return 1
  else
    local NF_TARFILE="$(mktemp)"
    local NF_TARGETDIR="/usr/share/fonts/$NF_NAME-nf"
    echo "Downloading $NF_NAME font..."
    curl -L https://github.com/ryanoasis/nerd-fonts/releases/latest/download/"$NF_NAME".tar.xz -o "$NF_TARFILE"
    echo "Removing old font directory if it exists..."
    sudo rm -rf "$NF_TARGETDIR" || true
    echo "Creating $NF_TARGETDIR directory..."
    sudo mkdir "$NF_TARGETDIR"
    echo "Expanding the font tarfile into the font directory..."
    sudo tar xf "$NF_TARFILE" -C "$NF_TARGETDIR"
    echo "Refreshing "
    sudo fc-cache -v
    rm -f "$NF_TARFILE"
  fi
}