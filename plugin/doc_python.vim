"
"                          _______
"    ____________ _______ _\__   /_________        ___  _____
"   |    _   _   \   _   |   ____\   _    /       |   |/  _  \
"   |    /   /   /   /   |  |     |  /___/    _   |   |   /  /
"   |___/___/   /___/____|________|___   |   |_|  |___|_____/
"           \__/                     |___|    
"
" Copyright (C) 2012 Wijnand Modderman-Lenstra <maze@pyth0n.org>
"
" Permission is hereby granted, free of charge, to any person obtaining a copy of
" this software and associated documentation files (the "Software"), to deal in
" the Software without restriction, including without limitation the rights to
" use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
" of the Software, and to permit persons to whom the Software is furnished to do
" so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in all
" copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
" SOFTWARE.

" Version check
if v:version < 700
    finish
endif

" Load once
if exists("g:loaded_python_doc")
    finish
else
    let g:loaded_python_doc = 1
endif

" Variables
if !exists("g:python_doc_split")
    let g:python_doc_split = "vertical belowright split"
end
if !exists("g:python_doc_command")
    let g:python_doc_command = "pydoc"
end

function! ShowPyDoc()
    let s:current = expand("<cfile>")
    let s:bufname = s:current . ".pydoc"
    if bufexists(s:bufname)
        let winnr = bufwinnr(s:bufname)
        if winnr != -1
            " switch to already active buffer
            execute winnr . "wincmd w"
        else
            " open split buffer
            execute "sbuffer " . s:bufname
        endif
    else
        " split window
        execute g:python_doc_split . " " . s:bufname
        setlocal buftype=nofile
        setlocal bufhidden=wipe
        setlocal nobuflisted
        setlocal noswapfile
        setlocal nowrap
        setlocal filetype=man
        " run pydoc
        execute '$read !' . g:python_doc_command . ' ' . s:current . " | sed -e 's/[ ]*$//g'"
        setlocal nomodifiable
        setlocal readonly
    endif
    " jump to top"
    1
endfunction

map <F2> :call ShowPyDoc()<CR><CR>
