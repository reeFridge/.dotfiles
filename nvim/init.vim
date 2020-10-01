call plug#begin(expand('~/.config/nvim/plugged'))
	Plug 'norcalli/nvim-colorizer.lua'
	Plug 'airblade/vim-gitgutter'
	Plug 'nvim-lua/diagnostic-nvim'
	Plug 'jeffkreeftmeijer/vim-numbertoggle'
	Plug 'machakann/vim-highlightedyank'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'lifepillar/vim-gruvbox8'
	Plug 'habamax/vim-gruvbit'
	Plug 'itchyny/lightline.vim'
	Plug 'vimwiki/vimwiki'
	Plug 'tommcdo/vim-exchange'
	Plug 'justinmk/vim-dirvish'
	Plug 'takac/vim-hardtime'
	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()

" dirvish
let g:dirvish_mode = ':sort ,^.*[\/],'
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" diagnostic
let g:diagnostic_insert_delay = 1

"fzf
let g:fzf_layout = {'down': '40%',}

" hardtime
let g:hardtime_default_on = 1
let g:hardtime_maxcount = 2
let g:hardtime_allow_different_key = 1

" lightline
let g:lightline = {'colorscheme': 'gruvbit',}

" other
let g:netrw_banner = 0

" Use persistent history.
if !isdirectory("/tmp/.vim-undo-dir")
    call mkdir("/tmp/.vim-undo-dir", "", 0700)
endif
set undodir=/tmp/.vim-undo-dir
set undofile

filetype plugin on
set termguicolors
set background=dark
colorscheme gruvbox8_soft
set noshowmode
set cursorline
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
set list
set updatetime=500
nohlsearch

" lsp
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
	disable = {"typescript"},
  },
}
local lsp = require('nvim_lsp')
local diagnostic = require('diagnostic')
local colorizer = require('colorizer')

local on_attach = function(client)
	diagnostic.on_attach(client);
end
lsp.tsserver.setup{on_attach=on_attach}
lsp.vimls.setup{on_attach=on_attach}
colorizer.setup()
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
nnoremap <A-d> :lua vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <A-h> :PrevDiagnosticCycle<CR>
nnoremap <A-l> :NextDiagnosticCycle<CR>
nnoremap <A-D> :OpenDiagnostic<CR>
nnoremap <A--> :Dirvish %<CR>
