local PLUGIN_DIR=$(dirname "${(%):-%N}")

for FILE in "$PLUGIN_DIR"/*.zsh; do
    # Skip the main plugin script to avoid circular sourcing
    [[ "$FILE" == "$PLUGIN_DIR/zsh-eddie.plugin.zsh" ]] && continue
    source "$FILE"
done