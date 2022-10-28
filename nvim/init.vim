""" Moogs' neovim config

" This file is intended for neovim 
"
" - Requires vim-plug, see https://github.com/junegunn/vim-plug for details
"

""" Neovim specific setup

" Force the usage of python 3
set pyx=3

" Do not use funky encodings since we'll mostly edit source files
set encoding=utf-8

"" Custom theme
syntax on 
colorscheme mfantasy

"" Readability
set number " Show line number
set nowrap " Do not wrap long lines
set conceallevel=0 " Do not hide any characters

"" Interface
set title " Show currently edited file name in window title
set wildmenu " Always show completion when possible
set termguicolors " Make everything colored, might not work on older terms
set laststatus=2 " Always show status lines, even in splits
set scrolloff=2 " Show atleast 2 lines above and below the cursor
set sidescrolloff=5 " Show atleast 5 chars when scrolling to the side

"" Indentation
set nocindent " do not follow C rules for indentation

"" Insert mode related
set backspace=indent,eol,start " Let us backspace over anything

""" Parenthesises
set showmatch " Show matching parenthesis when writing one
set matchtime=1 " Show matching parenthesis for 0.1 secs

"" Tabs to 4 space
set tabstop=4 " Tabs writes 4 spaces
set shiftwidth=4 " Consider 4 spaces as default indentation
set softtabstop=4 " Consider tab as 4 spaces
set expandtab " Insert/Remove 4 spaces when typing >> / <<
set shiftround " Round indents to 4 spaces

"" Search settings
set hlsearch " Highlight matching words when searching
set is " Search as you type

" When a search is entered without any caps, perform a caseless match.
" Otherwise, make it case dependant
set ignorecase
set smartcase

"" Explorer setup
set path+=** " Recursively search files through subfolders

"" Remaps

" Do not require w to be pressed to jump through splits
nmap <C-H> <C-W><C-H>
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>

" Map caps lock to escape on entry, fix it on exit
au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'


"" Plugin imports
call plug#begin()

" Jump around text quickly
Plug 'phaazon/hop.nvim'

" Fonts that will handle all of those icons
Plug 'ryanoasis/vim-devicons'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Change command bar appearance
Plug 'folke/noice.nvim'
Plug 'MunifTanjim/nui.nvim'

" Notification like system
Plug 'rcarriga/nvim-notify'

" Augmented file explorer
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

" Git
Plug 'tpope/vim-fugitive'

" Readability 
Plug 'frazrepo/vim-rainbow' " Highlights matching parenthesises with same colors
Plug 'Yggdroot/indentLine' " Shows different indicators depending on indentation depth
Plug 'norcalli/nvim-colorizer.lua' " Highlight colors with their values

" General syntax highlighting
Plug 'sheerun/vim-polyglot'

" General language plugins
Plug 'puremourning/vimspector' " Debugger
Plug 'neoclide/coc.nvim' " Autocompletion and more

" Python-specific plugins
Plug 'numirias/semshi' " Better highlighting, run :UpdateRemotePlugins to activate it
Plug 'psf/black' " Automatically format

" Latex-specific plugins
Plug 'lervag/vimtex'

call plug#end()

""" Plugins setup 

""" Colorizer setup
lua require('colorizer').setup()

"" Airline setup
let g:airline_detect_modified=1 
let g:airline_detect_paste=1 
let g:airline_detect_crypt=1
let g:airline_detect_spell=1
let g:airline_detect_spelllang=1
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:airline_theme='badwolf'

"" Coc setup

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"" Hop setup
lua require("hop").setup()

"" Identline setup
let g:indentLine_char_list=['|', '¦', '┆', '┊'] "Indentation indicators

"" Noice setup
lua require("noice").setup()

"" Rainbow setup
let g:rainbow_active = 1 "Always keep it active

" Purple / Green / Blue / Yellow / Red
let g:rainbow_guifgs = ["#E0B0FF", "#90EE90", "#ADD8E6", "#FFFF00", "#FF0000"]
let g:rainbow_ctermfgs = [201, 10, 14, 226, 196] 

"" Semshi setup
let g:semshi#excluded_hl_groups = [] " Highlight all groups differently
let g:semshi#simplify_markup = v:false " Keep distinguishing as many groups as possible

"" Telescope setup
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"" Vimspector setup

" Show / hide the brakpoints window
nmap <F3> <Plug>VimspectorBreakpoints

" Toggle line breakpoint for the current line
nmap <F4> <Plug>VimspectorToggleBreakpoint

" Start debugging
nmap <F5> <Plug>VimspectorContinue

" Stop debugging
nmap <F17> <Plug>VimspectorReset

" Run the next function without debugging it
nmap <F6>  <Plug>VimspectorStepOver

" Run the next function and debug it line by line 
nmap <F18> <Plug>VimspectorStepInto

" Step out of the current function scope
nmap <F7> <Plug>VimspectorStepOut

" Run until it reaches the cursor
nmap <F19> <Plug>VimspectorRunToCursor

"" Vimtex setup
let g:vimtex_view_method='zathura' " Use the zathura pdf viewer
let g:vimtex_syntax_conceal_disable=1 " Do not conceal characters

function! ZathuraHook() abort
  if exists('b:vimtex.viewer.xwin_id') && b:vimtex.viewer.xwin_id <= 0
    silent call system('xdotool windowactivate ' . b:vimtex.viewer.xwin_id . ' --sync')
    silent call system('xdotool windowraise ' . b:vimtex.viewer.xwin_id)
  endif
endfunction

augroup vimrc_vimtex
  autocmd!
  autocmd User VimtexEventView call ZathuraHook()
augroup END
