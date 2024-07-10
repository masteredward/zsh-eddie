if [[ "$(uname -r)" == *"microsoft-standard-WSL2" ]]; then
    BROWSER="$(which librewolf.exe)"; export BROWSER
fi