KUBE_EDITOR="code --wait"; export KUBE_EDITOR

alias k='kubectl --insecure-skip-tls-verify'
alias argocdbaseinst='helm upgrade --install argocd --repo https://argoproj.github.io/argo-helm argo-cd --namespace argocd --create-namespace'
alias argocdpasswd='kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo'
alias argocdpf='kubectl port-forward -n argocd service/argocd-server 8080:443'

kube_awstest_sa() {
  local SA="$1"
  local NAMESPACE="$2"
  kubectl run --rm -it \
      testaccess-"$SA" \
      -n "$NAMESPACE" \
      --image=public.ecr.aws/aws-cli/aws-cli:latest \
      --overrides='{"spec": {"serviceAccountName": "'$SA'"}}' --command /bin/bash
}

kube_run_sa() {
  local IMAGE="$1"
  local NAMESPACE="$2"
  local SA="$3"
  kubectl run --rm -it \
      run-"$SA" \
      -n "$NAMESPACE" \
      --image="$IMAGE" \
      --overrides='{"spec": {"serviceAccountName": "'$SA'"}}'
}

kube_install() {
  local VERSION="$1"
  if [ -z "$VERSION" ]; then
    echo "Usage: kube_install <version> (e.g. 1.31)"
    return 1
  fi
  local ARCH=$(uname -m)
  local KUBE_ARCH
  case $ARCH in
    x86_64)
      KUBE_ARCH="amd64"
      ;;
    aarch64)
      KUBE_ARCH="arm64"
      ;;
    *)
      echo "Unsupported architecture: $ARCH"
      return 1
      ;;
  esac
  local FULL_VERSION=$(curl -s https://api.github.com/repos/kubernetes/kubernetes/releases | \
    grep -o 'v'"${VERSION}"'\.[0-9]*' | \
    sort -V | \
    tail -n1)
  if [ -z "$FULL_VERSION" ]; then
    echo "No matching version found for ${VERSION}"
    return 1
  fi
  echo "Installing kubectl ${FULL_VERSION} for ${ARCH}..."
  sudo curl -Lo /usr/local/bin/kubectl "https://dl.k8s.io/release/${FULL_VERSION}/bin/linux/${KUBE_ARCH}/kubectl" && \
  sudo chmod +x /usr/local/bin/kubectl && \
  echo "kubectl ${FULL_VERSION} installed successfully for ${ARCH}"
}