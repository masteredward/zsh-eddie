ghcr_login() {
  echo "$GHCR_TOKEN" | docker login ghcr.io -u masteredward --password-stdin
}