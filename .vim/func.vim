"{{{CloseOnLastTab
function! CloseOnLastTab()
    if tabpagenr('$') == 1
        execute 'windo bd'
        execute 'q'
    elseif tabpagenr('$') > 1
        execute 'windo bd'
    endif
endfunction
"}}}
"{{{HumanSize
fun! HumanSize(bytes) abort
    let l:bytes = a:bytes
    let l:sizes = ['B', 'KiB', 'MiB', 'GiB']
    let l:i = 0
    while l:bytes >= 1024
        let l:bytes = l:bytes / 1024.0
        let l:i += 1
    endwhile
    return printf('%.1f%s', l:bytes, l:sizes[l:i])
endfun
"}}}

""{{{StatuslineGit
"function! GitBranch()
"    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
"endfunction
"function! StatuslineGit()
"    let l:branchname = GitBranch()
"    if strlen(l:branchname) > 0
"        return ' '.l:branchname.' '
"    else
"        return ' clean '
"    endif
"endfunction"}}}
""}}}

"" Statusline{{{
"" :h 'statusline'
"set noshowmode
"set laststatus=2
"set statusline=
"set statusline+=%#TabLineSel#
"set statusline+=%{(mode()=='n')?'\ \ NORMAL\ ':''}
"set statusline+=%{(mode()=='i')?'\ \ INSERT\ ':''}
"set statusline+=%{(mode()=='v')?'\ \ VISUAL\ ':''}
"set statusline+=%{(mode()=='r')?'\ \ REPLACE\ ':''}
"set statusline+=%#StatusLine#
"set statusline+=%r\ 
"set statusline+=%f
"set statusline+=%m\ 
"set statusline+=%#Normal#
"set statusline+=%=
"set statusline+=%#StatusLine#
"set statusline+=\ %y
"set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
"set statusline+=\[%{&fileformat}\]
"set statusline+=\ %p%%
"set statusline+=\ %l:%c\ 
"set statusline+=%#TabLineSel#
"set statusline+=%{StatuslineGit()}
"" }}}
