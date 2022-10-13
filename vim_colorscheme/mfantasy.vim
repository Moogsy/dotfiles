highlight clear

set termguicolors
set t_Co=256
let g:colors_name = "mfantasy"

" Background color
hi Normal guibg=#2C2638
hi link NormalFloat Normal
hi link NormalNC Normal


" Code highlighting

hi comment guifg=Silver

hi Constant guifg=Salmon
hi String guifg=Pink
hi Character guifg=DeepPink
hi Number guifg=Gold
hi link Boolean Constant
hi Float guifg=Yellow

hi identifier guifg=LightSkyBlue
hi Function guifg=Lime

hi Statement guifg=#ff5f5f
hi link Conditional Statement
hi link Repeat Statement
hi link Label Statement
hi link Operator Statement
hi link Keyword Statement
hi link Exception Statement

hi PreProc guifg=#FF10F0
hi link Include PreProc
hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc

hi Type guifg=Cyan
hi link StorageClass Type
hi link Structure Type
hi link Typedef Type
hi Special guifg=NavajoWhite
hi link SpecialChar Special
hi link Tag Special
hi link Delimiter Special
hi link SpecialComment Special
hi link Debug Special

hi Underlined guifg=DodgerBlue
hi Error guifg=#00ffff
hi Todo guifg=#0000ff

" Pop menus colors
hi Pmenu guifg=White guibg=DarkBlue

" Coc specific colors
hi link CocFloating Pmenu

hi CocErrorFloat guifg=Red

