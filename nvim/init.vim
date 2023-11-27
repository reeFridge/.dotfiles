call plug#begin(expand('~/.config/nvim/plugged'))
	Plug 'dcampos/nvim-snippy'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'kalvinpearce/ShaderHighlight'
	Plug 'preservim/tagbar'
	Plug 'editorconfig/editorconfig-vim'
	Plug 'tpope/vim-fugitive'
	Plug 'norcalli/nvim-colorizer.lua'
	Plug 'airblade/vim-gitgutter'
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

" vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" tagbar
let g:tagbar_width = 100
let g:tagbar_compact = 1

" dirvish
let g:dirvish_mode = ':sort ,^.*[\/],'
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

"fzf
let g:fzf_layout = {'down': '40%',}

" hardtime
let g:hardtime_default_on = 1
let g:hardtime_maxcount = 2
let g:hardtime_allow_different_key = 1

" lightline
let g:lightline = {'colorscheme': 'gruvbit','component_function': {'filename': 'LightlineFilename',}}

function! LightlineFilename()
	return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
				\ &filetype ==# 'unite' ? unite#get_status_string() :
				\ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
				\ expand('%:~:.') !=# '' ? expand('%:~:.') : '[No Name]'
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

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

set fileencodings=utf-8,cp1251,cp866,koi8-r

" lsp
lua << EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
		signs = false,
		update_in_insert = false,
	}
)
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
local lsp = require('lspconfig')
local colorizer = require('colorizer')

require('lspconfig/quick_lint_js').setup {}
-- lsp.tsserver.setup{}
-- lsp.vimls.setup{}
lsp.clangd.setup{}
-- lsp.eslint.setup()
colorizer.setup()
EOF

" commands
" command! -bang -nargs=* Rgx call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".<q-args>, 1, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* Rgx
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.fzf#shellescape(<q-args>),
  \   fzf#vim#with_preview({'dir': 'www'}), <bang>0)

" key bindings
nnoremap <silent> <A-space> :nohlsearch<CR>
nnoremap <A-b> :Buffers<CR>
nnoremap <A-,> :Files<CR>
nnoremap <A-.> :GFiles<CR>
nnoremap <A-/> :Rg<CR>
nnoremap <A-w> :w<CR>
inoremap <A-j> <Esc>
vnoremap <A-j> <Esc>
nnoremap <A-j> <Esc>
tnoremap <A-j> <C-\><C-N>
nnoremap <A-i> i<CR><Esc>O
nnoremap <A-d> :lua vim.diagnostic.open_float({scope="line"})<CR>
nnoremap <A-h> :lua vim.diagnostic.goto_prev()<CR>
nnoremap <A-l> :lua vim.diagnostic.goto_next()<CR>
nnoremap gd    :lua vim.lsp.buf.declaration()<CR>
nnoremap gD    :lua vim.lsp.buf.implementation()<CR>
nnoremap tg    :lua vim.lsp.buf.definition()<CR>
nnoremap tG    :lua vim.lsp.buf.type_definition()<CR>
nnoremap K     :lua vim.lsp.buf.hover()<CR>
nnoremap <c-k> :lua vim.lsp.buf.signature_help()<CR>
nnoremap g0    :lua vim.lsp.buf.document_symbol()<CR>
nnoremap gr    :lua vim.lsp.buf.references()<CR>
nnoremap <A--> :Dirvish %<CR>
nnoremap <F8>  :TagbarToggle<CR>

imap <expr> <Tab> snippy#can_expand_or_advance() ? '<Plug>(snippy-expand-or-advance)' : '<Tab>'
imap <expr> <S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<S-Tab>'
smap <expr> <Tab> snippy#can_jump(1) ? '<Plug>(snippy-next)' : '<Tab>'
smap <expr> <S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<S-Tab>'
xmap <Tab> <Plug>(snippy-cut-text)
