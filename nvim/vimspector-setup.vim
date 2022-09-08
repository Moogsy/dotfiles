function CheckVimspectorJsonPresence()
    let jsons = split(globpath(".", ".vimspector.json"), "\n")

    if len(jsons) >= 1
        return 1
    endif

    return 0
endfunction

function MakeVimspectorJson()
    if CheckVimspectorJsonPresence() != 1
        let prompt = "Couldn't find .vimspector.json in current folder, copy default one for "
        let prompt .= &filetype . " (y/n/default: y) ? "

        let answer = input(prompt, "y")

        if answer != "y"
            return
        endif

        if &filetype ==# 'c' || &filetype ==# 'cpp'
            call system("cp ~/GitHub/dotfiles/nvim/vimspector_jsons/c_cpp_vimspector.json .vimspector.json")

        elseif &filetype ==# "python"
            call system("cp ~/GitHub/dotfiles/nvim/vimspector_jsons/python_vimspector.json .vimspector.json")
        endif
    endif

    call vimspector#Continue()

endfunction

"Start debugging
nmap <F5> :call MakeVimspectorJson() <CR>

"Stop debugging
map <F17> :call vimspector#Reset() <CR>

"Step control
nmap <F6>  <Plug>VimspectorStepOver
nmap <F18> <Plug>VimspectorStepInto

"Jump out of current function's scope
nmap <F7> <Plug>VimspectorStepOut

"Breakpoints
nmap <F3> <Plug>VimspectorBreakpoints
nmap <F4> <Plug>VimspectorToggleBreakpoint


