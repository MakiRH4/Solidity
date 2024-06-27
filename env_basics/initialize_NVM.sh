#!/bin/bash

ZSHRC_PATH=~/.zshrc
NVM_DIR="$HOME/.nvm"

if grep -q "export NVM_DIR=\"$NVM_DIR\"" "$ZSHRC_PATH"; then
    echo "NVM has already been initialized."
else
    {
        echo "export NVM_DIR=\"$NVM_DIR\""
        echo "[ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\""
        echo "[ -s \"\$NVM_DIR/bash_completion\" ] && \. \"\$NVM_DIR/bash_completion\""
    } >> "$ZSHRC_PATH"

    source "$ZSHRC_PATH"
fi