" tab/indentation options
set tabstop=2 softtabstop=2
set expandtab
set shiftwidth=2
set autoindent " auto indent newline just as much as previous line
filetype plugin indent on " allows auto indenting depending on type of file

" line numbers
set number " add line numbers
set relativenumber
set showmatch 
" search 
set nohlsearch " no higlighting for search
set incsearch

" scrolling
set scrolloff=12
set ttyfast " speed up scrolling

set signcolumn=yes
set colorcolumn=80

set hidden " keep buffers open
set noerrorbells

set completeopt=menu,menuone,noselect

" apparently this is required for rust.vim
syntax enable

" changes some color settings or something idk but it looks awful without it
set termguicolors

" disable mouse
set mouse=

call plug#begin()
  " Editor plugins
  Plug 'numToStr/Comment.nvim'
  Plug 'preservim/nerdtree'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'f-person/git-blame.nvim'
  Plug 'mbbill/undotree'
  Plug 'stevearc/aerial.nvim'
 
  " Plug 'github/copilot.vim'
  Plug 'lewis6991/gitsigns.nvim'

  " This is for lazy loading plugins? ngl idk
  Plug 'nvim-lua/plenary.nvim'

  " Language specific plugins
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'hashivim/vim-terraform'

  " Rust
  Plug 'rust-lang/rust.vim'
  Plug 'alx741/vim-rustfmt' " did some magic to make this always use nightly
  " Plug 'simrat39/rust-tools.nvim'

  Plug 'yuezk/vim-js'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'maxmellon/vim-jsx-pretty'

  " Themes
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
  Plug 'gruvbox-community/gruvbox'
  Plug 'whatyouhide/vim-gotham'
  Plug 'arcticicestudio/nord-vim'
  "
  " For Lsp Installation
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'

  " COC
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Debugging
  Plug 'mfussenegger/nvim-dap'
  Plug 'leoluz/nvim-dap-go'
  Plug 'rcarriga/nvim-dap-ui'
  Plug 'theHamsta/nvim-dap-virtual-text'
  Plug 'nvim-telescope/telescope-dap.nvim'

  " signature help
  Plug 'ray-x/lsp_signature.nvim'

  " for eww
  Plug 'elkowar/yuck.vim'
call plug#end()

colorscheme dracula

" Keybinds
let mapleader="\<SPACE>"

" Global Keybinds
nnoremap <leader>e <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap [d <cmd>lua vim.diagnostic.goto_prev()<CR> 
nnoremap ]d <cmd>lua vim.diagnostic.goto_next()<CR> 
nnoremap <leader>q <cmd>lua vim.diagnostic.setloclist()<CR> 
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>E :Telescope diagnostics<CR>

nnoremap gr :Telescope lsp_references<CR>
nnoremap gi :Telescope lsp_implementations<CR>
nnoremap gd :Telescope lsp_definitions<CR>

" NERDTree keybinds
nnoremap <leader>l :NERDTreeToggle<CR>
nnoremap <leader>d :NERDTreeFind<CR>

" Telescope keybinds
nnoremap <leader>ff :Telescope git_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>

" DAP keybinds
nnoremap <leader>dc <cmd>DapContinue<CR>
nnoremap <leader>db <cmd>DapToggleBreakpoint<CR>
nnoremap <leader>dn <cmd>DapStepOver<CR>
nnoremap <leader>ds <cmd>DapStepInto<CR>
nnoremap <leader>du <cmd>lua require("dapui").toggle()<CR>

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

runtime coc.vim

lua require('init')
