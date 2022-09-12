" Removes all trailing whitespaces, and remove trailing newlines
command TrimTrailingWhitespace %s/\s\+$//e | nohl

function LineIsEmpty(line)
    return trim(a:line) == ""
endfunction

function GetEmptyLinecount(lines)
    let empty_lines_count = 0

    for line in reverse(a:lines)
        if LineIsEmpty(line)
            let empty_lines_count += 1
        else
            break
        endif
    endfor

    return empty_lines_count

endfunction

function AddBlankLineEndofFileFunc()
    let path = resolve(expand('%:p'))
    let lines = readfile(path, '')

    if len(lines) <= 0
        return
    endif

    let empty_lines_count = GetEmptyLinecount(lines)

    if empty_lines_count == 0
        call feedkeys("Go\<Esc>\<C-O>", 'normal')
    elseif empty_lines_count > 1
        call feedkeys((len(lines) - empty_lines_count + 1) ."G" . (empty_lines_count - 1) . "dd")
    endif

endfunction

autocmd BufWritePost * call AddBlankLineEndofFileFunc()
autocmd BufWritePost * TrimTrailingWhitespace    

