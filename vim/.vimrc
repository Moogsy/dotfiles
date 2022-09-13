"" ensimag vim config file version 1.0.3 (Edited by Moogs)
"" this file is intended for vim 8

"" before using it you will need to

"" - install plug with :
""      curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"" (see https://github.com/junegunn/vim-plug)

"" - install the languageserver server for each language you indend to use :
""    * pyls for python (see https://github.com/palantir/python-language-server)
""    * rls for rust (see https://github.com/rust-lang-nursery/rls)
""    * clangd for c

"" - install some patched font with powerline symbols for eye candy and icons
"" (see https://github.com/powerline/fonts)

"" - change plugin directory to ~/.vim/plugged

"" after that copy this file as your ~/.vimrc and execute :PlugInstall

set nocompatible

call plug#begin('~/.vim/plugged')

" Eye candy
Plug 'vim-airline/vim-airline' " status bar (needs special fonts)
Plug 'vim-airline/vim-airline-themes'

Plug 'ryanoasis/vim-devicons' " various symbols (linux, rust, python, ...)

Plug 'Yggdroot/indentline' " Add different symbols depending on indentation depth
let g:indentLine_char_list=['|', '¦', '┆', '┊']

" essential plugins
" see for example https://github.com/autozimu/LanguageClient-neovim/issues/35#issuecomment-288731665
Plug 'maralla/completor.vim' " auto-complete
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ } " as of july 2019 this branch is needed for vim8 (at ensimag, doesn't need it on my pc)

" Python
Plug 'psf/black' " Auto format

" Rust
Plug 'rust-lang/rust.vim' " syntax highlighting
Plug 'mattn/webapi-vim' " used for rust playpen

" Debugger
Plug 'puremourning/vimspector'

" Git
Plug 'tpope/vim-fugitive' " git

call plug#end()

filetype plugin indent on

" configure maralla/completor to use tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

" Airline
let g:airline_powerline_fonts = 1
set laststatus=2
au VimEnter * exec 'AirlineTheme deus'

" Compatibility
set encoding=utf-8
set notermguicolors " we disable truecolor display :-( to be compatible with many terminals

" Custom theme
syntax on
colorscheme mfantasy
set background=dark

" Readability
set number " Show line number
set nowrap " Do not wrap long lines
set conceallevel=0 " Do not hide any characters

" Interface
set title " Show currently edited file name in windo title
set wildmenu " Always show completion when possible
set showmatch " Show matching parenthesis when writing one

" Tabs to 4 space
set tabstop=4 " Tabs writes 4 spaces
set shiftwidth=4 " Consider 4 spaces as default indentation
set softtabstop=4 " Consider tab as 4 spaces
set expandtab " Insert/Remove 4 spaces when using > or <
set shiftround " Round indents to 4 spaces

" Search settings
set hlsearch " Highlight matching words when searching

" Explorer
set path+=** " Recursively search files through subfolders
let g:netrw_altv=0
let g:netrw_liststyle=3

" Jump through splits
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" Rust stuff
let g:LanguageClient_loadSettings = 1 " this enables you to have per-projects languageserver settings in .vim/settings.json
let g:rustfmt_autosave = 1
let g:rust_conceal = 1
set hidden

" run language server for python, rust and c
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'go': ['go-langserver'],
    \ 'c' : ['clangd'] }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR> " hit :pc to close the preview window
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
