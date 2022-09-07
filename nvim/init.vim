"24 bit colors
set t_8f=\e[38;2;%lu;%lu;%lum
set t_8b=\e[48;2;%lu;%lu;%lum

if !empty(glob("~/Programs/node-v18.8.0-linux-x64/bin/node"))
    let g:coc_node_path = "~/Programs/node-v18.8.0-linux-x64/bin/node"
endif

call plug#begin()
Plug 'Yggdroot/indentline'
Plug 'joshdick/onedark.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'norcalli/nvim-colorizer.lua'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'psf/black'
Plug 'puremourning/vimspector'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

syntax on
filetype plugin indent on
set termguicolors

" Indicators for indentation
let g:indentLine_char_list=['|', '¦', '┆', '┊']

" Colorize hex codes
lua require'colorizer'.setup()
autocmd BufEnter * ColorizerAttachToBuffer

" coc-highlight
set nocindent
set conceallevel=0
set emoji
set expandtab
set guicursor=
set hlsearch
set list
set matchtime=1
set number
set path+=**
set pyx=3
set ruler
set shiftround
set shiftwidth=4
set showmatch
set smartcase
set smartindent
set smarttab
set tabstop=4
set termguicolors
set title
set wildmenu
set wrap

" Shortcut to change windows
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" Semshi setup
let g:semshi#excluded_hl_groups = []
let g:semshi#simplify_markup = v:false

" Color theme
source ~/GitHub/dotfiles/nvim/colors/mfantasy.vim

" Autcompletion config
source ~/GitHub/dotfiles/nvim/coc_config.vim

" Airline stuff
source ~/GitHub/dotfiles/nvim/airline-setup.vim

" Netrw setup
source ~/GitHub/dotfiles/nvim/netrw-setup.vim

" Vimspector setup
source ~/GitHub/dotfiles/nvim/vimspector-setup.vim

" Custom commands
source ~/GitHub/dotfiles/nvim/custom_commands.vim

" Have to call that one last to remove a grey bar on the left
set signcolumn=no
set nowrap

