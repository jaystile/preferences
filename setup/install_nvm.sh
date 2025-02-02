#!/bin/bash

# Setting `PROFILE=/dev/null` will prevent the script from modifying the bash profile.
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash'
