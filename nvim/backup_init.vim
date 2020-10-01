call plug#begin(expand('~/.config/nvim/plugged'))
	Plug 'jeffkreeftmeijer/vim-numbertoggle'
	Plug 'machakann/vim-highlightedyank'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'morhetz/gruvbox'
	Plug 'airblade/vim-gitgutter'
	Plug 'itchyny/lightline.vim'
	Plug 'vimwiki/vimwiki'
	Plug 'tommcdo/vim-exchange'
	Plug 'justinmk/vim-dirvish'
	Plug 'takac/vim-hardtime'
	Plug 'neovim/nvim-lspconfig'
call plug#end()

" dirvish
let g:dirvish_mode = ':sort ,^.*[\/],'
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" hardtime
let g:hardtime_default_on = 1
let g:hardtime_maxcount = 2
let g:hardtime_allow_different_key = 1

" lightline
let g:lightline = {'colorscheme': 'wombat',}

" other
let g:gruvbox_contrast_dark = 'soft'
let g:netrw_banner = 0

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
" turn hybrid line numbers on
set number relativenumber
" absolute line number on
" set number
set title
set updatetime=500
colorscheme gruvbox
nohlsearch

" lsp
lua << EOF
require'nvim_lsp'.rome.setup{}
require'nvim_lsp'.vimls.setup{}
EOF

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
