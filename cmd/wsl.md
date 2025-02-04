# Copy from WSL vim to Windows clipboard.
Option 1: WSL can execute windows programs. So, the use visual selection and then output that to clip.exe using a vim command.
```
:<,'>w !clip.exe
```
Option 2: Neovim looks for clipboard integration. [See docs](https://neovim.io/doc/user/provider.html#provider-clipboard). If `set clipboard+=unnamedplus` is configured nvim will look for clipboards to use: `xsel` can be installed which you should've done to get tmux-yank to work.
