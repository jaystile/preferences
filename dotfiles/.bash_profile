# If a login instead of a interactive session was started, source the bashrc
if [ -n "$BASH_VERSION" -a -n "$PS1" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# Enable vim navigation on the command line. The command line starts in edit mode.
set -o vi

# Change the default editor
export EDITOR=nvim

# Fuzzy search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Include local bin directory for custom scripts
LOCAL_BIN=/home/$USER/bin
export PATH="$LOCAL_BIN:$PATH"

# Load application specific profiles
for profile in ~/.bash_profile.d/*; do
    . "$profile"
done
. "$HOME/.cargo/env"

. "$HOME/.local/bin/env"
