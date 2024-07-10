alias ls='lsd'
alias argocdpasswd='kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d'
alias l='lsd -lah'
alias z='sudo zypper'
alias nvmup="nvm install --reinstall-packages-from=current --latest-npm 'lts/*'"