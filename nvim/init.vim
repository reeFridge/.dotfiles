call plug#begin(expand('~/.config/nvim/plugged'))
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'morhetz/gruvbox'
	Plug 'pangloss/vim-javascript'
	Plug 'airblade/vim-gitgutter'
	Plug 'hdima/python-syntax'
call plug#end()

function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize '
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)

let g:javascript_plugin_jsdoc = 1
let g:rainbow_active = 1
let g:gruvbox_contrast_dark = 'soft'
let g:netrw_banner = 0
let g:python_highlight_all = 1

filetype plugin on
set cursorline
set termguicolors
set clipboard+=unnamedplus
set shiftwidth=4
set modeline
set tabstop=4
set incsearch ignorecase smartcase hlsearch
set number
set title
set updatetime=500
autocmd vimenter * colorscheme gruvbox

" key bindings
nnoremap <silent> <A-space> :nohlsearch<CR>
nnoremap <A-b> :Buffers<CR>
nnoremap <A-,> :Files<CR>
nnoremap <A-.> :GFiles<CR>
nnoremap <A-/> :Rg<CR>
nnoremap <A-w> :w<CR>
nnoremap <A-j> <Esc>
vnoremap <A-j> <Esc>
inoremap <A-j> <Esc>
vnoremap <A-j> <Esc>
nnoremap <A-j> <Esc>
nnoremap <A-w> :w<CR>
