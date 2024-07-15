source /etc/os-release

case "$ID" in
  opensuse-tumbleweed)
    alias z='sudo zypper'
    alias zup='sudo zypper up -y'
    ;;
  fedora)
    alias d='sudo dnf'
    alias dup='sudo dnf update -y'
    ;;
esac