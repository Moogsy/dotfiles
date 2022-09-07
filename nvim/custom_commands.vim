" Removes all trailing whitespaces
command TrimTrailingWhitespace %s/\s\+$//e | nohl

function AddBlankLineEndofFileFunc()
    let path = resolve(expand('%:p'))
    let lines = readfile(path, '', -1)

    if len(lines) > 0
        let lastLine = lines[0]
    else
        return
    endif

    if trim(lastLine) != ""
        call feedkeys("Go\<Esc>\<C-O>", 'normal')
    endif
endfunction

" Adds a blank line at the end of the current file if needed
command AddBlankLineEndofFile call AddBlankLineEndofFileFunc()

autocmd BufWritePost * TrimTrailingWhitespace
autocmd BufWritePost * AddBlankLineEndofFile

