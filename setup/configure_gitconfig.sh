#!/bin/bash

### The following lines are commented out so that there is no accidental overwriting of other users (like my work account)
#git config --global user.name jaystile
#git config --global user.email 142552281+pico-bolero@users.noreply.github.com

git config --global core.editor vim
git config --global init.defaultBranch vim
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.s  status
git config --global alias.wt worktree
git config --global alias.wtls 'worktree list'
git config --global alias.wtrm 'worktree remove'
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
