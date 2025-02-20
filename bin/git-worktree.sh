# Git Worktrees are awesome but a little clunky to setup.

OWNER=$1 # e.g. jaystile
REPO=$2  # e.g. preferences

mkdir ${REPO}
pushd ${REPO}
git clone --bare git@github.com:${OWNER}/${REPO}.git .git
git worktree add main
popd

