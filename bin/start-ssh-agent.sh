#!/bin/bash
# The eval will terminate with the shell exits
echo 'eval "$(ssh-agent -s)"'
echo 'ssh-add ~/.ssh/<key>'
