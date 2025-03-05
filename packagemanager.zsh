source /etc/os-release

case "$ID" in
  opensuse-tumbleweed)
    alias z='sudo zypper'
    alias zup='sudo zypper dup -y'
    ;;
  fedora)
    alias d='sudo dnf'
    alias dup='sudo dnf update -y'
    ;;
esac

docker_arm64_install() {
  case "$ID" in
    opensuse-tumbleweed)
      sudo zypper in -y \
        qemu \
        qemu-arm \
        qemu-uefi-aarch64 \
        qemu-linux-user
      ;;
    fedora)
      sudo dnf install -y \
        qemu \
        qemu-arm \
        qemu-uefi-aarch64 \
        qemu-user
      ;;
  esac
}