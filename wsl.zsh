if [[ "$(uname -r)" == *"microsoft-standard-WSL2" ]]; then
    BROWSER="/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"; export BROWSER
fi