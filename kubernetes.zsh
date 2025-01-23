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