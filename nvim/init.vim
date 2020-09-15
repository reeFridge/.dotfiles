call plug#begin(expand('~/.config/nvim/plugged'))
	Plug 'machakann/vim-highlightedyank'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'morhetz/gruvbox'
	Plug 'pangloss/vim-javascript'
	Plug 'airblade/vim-gitgutter'
	Plug 'itchyny/lightline.vim'
	Plug 'hdima/python-syntax'
	Plug 'dense-analysis/ale'
call plug#end()

let g:ale_javascript_eslint_executable = 'npx eslint'
let g:javascript_plugin_jsdoc = 1
let g:rainbow_active = 1
let g:gruvbox_contrast_dark = 'soft'
let g:netrw_banner = 0
let g:python_highlight_all = 1
let g:lightline = {
			\ 'colorscheme': 'wombat',
			\ }

" Use persistent history.
if !isdirectory("/tmp/.vim-undo-dir")
    call mkdir("/tmp/.vim-undo-dir", "", 0700)
endif
set undodir=/tmp/.vim-undo-dir
set undofile

filetype plugin on
set noshowmode
set cursorline
set termguicolors
set clipboard+=unnamedplus
set shiftwidth=4
set modeline
set tabstop=4
set incsearch ignorecase smartcase hlsearch
set inccommand=nosplit
set number
set title
set updatetime=500
colorscheme gruvbox

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
tnoremap <A-j> <C-\><C-N>
nnoremap <A-w> :w<CR>
nnoremap <A-i> i<CR><Esc>O
