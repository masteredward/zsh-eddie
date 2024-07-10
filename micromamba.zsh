alias mminst="zsh <(curl -L micro.mamba.pm/install.sh)"
alias mm='micromamba'
alias mmu='micromamba update'
alias mmsu='micromamba self-update'
alias mma='micromamba activate'
alias mmc='micromamba create'
alias mmls='ls $MAMBA_ROOT_PREFIX/envs'

mmrm() {
  if [[ "$1" != "" ]]; then
    echo "Deleting environment $1"
    rm -rf "$MAMBA_ROOT_PREFIX"/envs/"$1"
  else
    echo "Environment name parameter needed!"
  fi
}