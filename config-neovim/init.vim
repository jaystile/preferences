"------------------------------------------------------------
" Common settings
"------------------------------------------------------------
" system clipboard yank and put
" Note: this requires vim to be built with the +clipboard feature flag
" run :echo has('clipboard') to see if you have it
" Yank all unnamed into the system buffer
set clipboard=unnamedplus
" Spellcheck :setlocal spell
" z= to see recommendations.
" set spell
set spelllang=en
set spellfile=$HOME/.vim/spell/en.utf-8.add
set nowrapscan

" I really do not like automatically continuing comments to new lines.
"  it messes up my pastes and I'm usually writing one line comments anyway.
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" Select your Leader key
let mapleader = "\<Space>"

"------------------------------------------------------------
" VSCode settings
"------------------------------------------------------------
if exists('g:vscode')
  " VSCode Extensions: A lot of things do not make sense to enable in vscode like syntax highlighters, fzf, and nerdtree
  " https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim 
  function! VSFzfSearch()
      call VSCodeCall('fzf-quick-open.runFzfFile')
  endfunction

  " <leader>o should open fzf for all files
  nnoremap <leader>o <Cmd>call VSFzfSearch()<CR>
"------------------------------------------------------------
" Native NVIM settings
"------------------------------------------------------------
elseif v:progname == 'nvim'
  let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
  if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  "------------------------------------------------------------
  " Plugins 
  "------------------------------------------------------------
  call plug#begin('~/.vim/plugged')

  Plug 'sheerun/vimrc'
  Plug 'sheerun/vim-polyglot'

  " Undo sheerun settings
  " I don't like the mouse to change my cursor position when I click from application to application
  set mouse=""

  " Termdebug - for debugging rust
  let termdebugger="rust-gdb"
  " Open the debugger split vertically instead of horizontally
  let g:termdebug_wide=1

  " Support longer files names when using :Ex to open files
  let g:netrw_maxfilenamelen=66

  " File Commenting
  Plug 'tpope/vim-commentary'

  " Fuzzy file search
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'}
  Plug 'junegunn/fzf.vim'
  let g:fzf_command_prefix = 'Fzf'

  "" Go language support
  "Plug 'fatih/vim-go'
  "" disable all linters as that is taken care of by coc.nvim
  "let g:go_diagnostics_enabled = 0
  "let g:go_metalinter_enabled = []
  "" don't jump to errors after metalinter is invoked
  "let g:go_jump_to_error = 0

  " run go imports on file save
  "let g:go_fmt_command = "goimports"

  " automatically highlight variable your cursor is on
  "let g:go_auto_sameids = 0
  "let g:go_highlight_types = 1
  "let g:go_highlight_fields = 1
  "let g:go_highlight_functions = 1
  "let g:go_highlight_function_calls = 1
  "let g:go_highlight_operators = 1
  "let g:go_highlight_extra_types = 1
  "let g:go_highlight_build_constraints = 1
  "let g:go_highlight_generate_tags = 1

  " Language Server and Formatting Plugins
  Plug 'prettier/vim-prettier', {'do': 'npm install'}

  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  "Plug 'codechips/coc-svelte', {'do': 'npm install'}

  " netwr https://shapeshed.com/vim-netrw/
  let g:netrw_liststyle = 1 "alphabetical list with attributes 

  call plug#end()

  " Install Plugins - End 


  "------------------------------------------------------------
  " Mappings
  "------------------------------------------------------------
  " In Vim, the mapleader or <leader> key is like a namespaced command key for
  " user commands so that you don't accidentally override something important
  " from the base Vim command set.
  "
  " By default it is '\', make it space because we are too lazy to reach that
  " far and we like using both hands.
  "
  " The sheerun/vimrc plugin sets this to space when the plugin loads.
  "
  " Example: <leader>p is <leader> followed by 'p' within 1000ms

  " <leader>g should open fzf for all files tracked by git
  nnoremap <leader>g :FzfGFiles<CR>

  " <leader>o should open fzf for all files
  nnoremap <leader>o :FzfFiles<CR>

  " <leader>f should run fzf with ripgrep for file text search by content
  nnoremap <leader>f :FzfRg<CR>

  " Ctrl-/ comments out lines with Commentary
  noremap <silent> <C-_> :Commentary<CR>

  "------------------------------------------------------------
  " Coc Suggestions Mappings
  " https://github.com/neoclide/coc.nvim#example-vim-configuration
  "------------------------------------------------------------
  " Use tab for trigger completion with characters ahead and navigate
  " NOTE: There's always complete item selected by default, you may want to enable
  " no select by `"suggest.noselect": true` in your configuration file
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config
  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  " Make <CR> to accept selected completion item or notify coc.nvim to format
  " <C-g>u breaks current undo, please make your own choice
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
        \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

else
  " Perhhaps ideavim is running.
  set visualbell
endif


