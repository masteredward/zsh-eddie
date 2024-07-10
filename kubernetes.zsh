KUBE_EDITOR="code --wait"; export KUBE_EDITOR

alias argocdpasswd='kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo'

kube_test_sa() {
  local SA="$1"
  local NAMESPACE="$2"
  kubectl run --rm -it \
      testaccess-"$SA" \
      -n "$NAMESPACE" \
      --image=public.ecr.aws/aws-cli/aws-cli:latest \
      --overrides='{"spec": {"serviceAccountName": "'$SA'"}}' --command /bin/bash
}