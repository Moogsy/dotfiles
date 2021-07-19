" 24 bit colors
execute "set t_8f=\e[38;2;%lu;%lu;%lum"
execute "set t_8b=\e[48;2;%lu;%lu;%lum"

call plug#begin()

Plug 'joshdick/onedark.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'Yggdroot/indentline'
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'sheerun/vim-polyglot'

call plug#end()

syntax on
filetype plugin indent on
set termguicolors
colorscheme onedark

let g:indentLine_char_list=['|', '¦', '┆', '┊']
let g:tex_conceal=''

set smartcase
set nowrap
set list
set number
set conceallevel=0
set hlsearch
set termguicolors
set cursorcolumn
set cursorline
set title
set ruler
set showmatch
set tabstop=4
set shiftwidth=4
set vartabstop=4
set varsofttabstop=4
set smarttab
set shiftround
set expandtab
set smartindent
set emoji
set pyx=3

" Shortcut to change windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Trim trailing white spaces
nnoremap <silent> <F4> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Airline stuff
let g:airline_powerline_fonts = 1
