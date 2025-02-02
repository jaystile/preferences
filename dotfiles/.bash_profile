# Enable vim navigation on the command line. The command line starts in edit mode.
set -o vi

# Change the default editor
export EDITOR=nvim

# Fuzzy search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Include local bin directory for custom scripts
LOCAL_BIN=/home/$USER/bin

# Load application specific profiles
for profile in ~/.bash_profile.d/* ; do
    . $profile
done

