" Vim settings

" =====[ Mouse ]=====
" Enable mouse
set mouse=a

" =====[ Appearance ]=====
" Color theme
set background=dark
color elflord

" Enable syntax highlighting
syntax on

" Setup line numbers - relative numbering and colors
set number
:highlight LineNr term=NONE cterm=NONE ctermfg=Cyan ctermbg=None
:highlight CursorLineNr term=NONE cterm=NONE ctermfg=Red ctermbg=None

" Highlight current line
set cursorline
:highlight CursorLine term=NONE cterm=Underline

" Don't wrap lines
set nowrap

" Always display status line
set laststatus=2

" =====[ Buffers ]=====
" Allow buffers to be hidden (i.e. background buffers can have unsaved changes)
set hidden

" =====[ Status Line ]=====

" 256-color terminal colors: https://jonasjacek.github.io/colors/
" colors: <mode>: [[<default_color_fg>, <default_color_bg>], [<modified_default_fg>, <bg>], [<bright_color>, <bg>], [<dim_color>, <bg>]]
let s:statusline_options = {
\   'colors': {
\       'n': [['15', '238'], ['15', '89'], ['0', '3'], ['15', '240']],
\       'i': [['15', '18'], ['15', '18'], ['0', '33'], ['15', '240']],
\       'R': [['15', '18'], ['15', '18'], ['0', '33'], ['15', '240']],
\       'v': [['0', '3'], ['0', '3'], ['0', '172'], ['15', '240']],
\       'V': [['0', '3'], ['0', '3'], ['0', '172'], ['15', '240']],
\       '': [['0', '3'], ['0', '3'], ['0', '172'], ['15', '240']],
\       'c': [['15', '238'], ['15', '89'], ['0', '160'], ['15', '240']]
\   },
\
\   'mode_map': {
\       'n'  : 'NORMAL',
\       'i'  : 'INSERT',
\       'R'  : 'REPLACE',
\       'v'  : 'VISUAL',
\       'V'  : 'V-LINE',
\       '' : 'V-BLOCK',
\       'c'  : 'COMMAND',
\   }
\}

function! StatusLine()
    function! SetColors()
        let colors = get(s:statusline_options.colors, mode(), [['15', '1'], ['0', '9'], ['15', '0']])

        if &mod
            exec printf('hi StatusLine_Default ctermfg=%s ctermbg=%s', colors[1][0], colors[1][1])
        else
            exec printf('hi StatusLine_Default ctermfg=%s ctermbg=%s', colors[0][0], colors[0][1])
        endif

        exec printf('hi StatusLine_Bright ctermfg=%s ctermbg=%s', colors[2][0], colors[2][1])
        exec printf('hi StatusLine_Dim ctermfg=%s ctermbg=%s', colors[3][0], colors[3][1])
	    return '%#StatusLine_Default#'
    endfunction

    function! StatusLineMode()
        let editor_mode = mode()
        return '%#StatusLine_Bright# ' . get(s:statusline_options.mode_map, editor_mode, editor_mode) . ' '
    endfunction

    function! StatusLineFile()
        return '%#StatusLine_Default# ' . '%f %r%m%h%w' . ' '
    endfunction

    function! StatusLineFileType()
        return '%#StatusLine_Dim# ' . '%y' . ' '
    endfunction

    function! StatusLineFilePosition()
        return '%#StatusLine_Bright# ' . '%p%% - %l[%c%V]/%L' . ' '
    endfunction

    let status_line = SetColors()
    let status_line .= StatusLineMode()
    let status_line .= StatusLineFile()
    let status_line .= '%='
    let status_line .= StatusLineFileType()
    let status_line .= StatusLineFilePosition()

    return status_line
endfunction

set statusline=%!StatusLine()

" =====[ Misc ]=====
" Setup correct tab behaviour
" 1 tab = 4 spaces, always enter spaces when pressing the tab key
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" Enable cut and paste from x clipboard
function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('xclip -o -selection clipboard')
endfunction

vnoremap <silent> y y:call ClipboardYank()<cr>
vnoremap <silent> d d:call ClipboardYank()<cr>
nnoremap <silent> p :call ClipboardPaste()<cr>p

" =====[ NERDTree ]=====
" Settings
let NERDTreeMinimalUI=1             " Clean UI

" Automatically start NERDTree for directories
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Map Ctrl+n to toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

" Close vim if only NERDTree is left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" =====[ Tagbar ]=====
" Map Ctrl+m to toggle tagbar
map <C-m> :TagbarToggle<CR>

" =====[ Rust ]=====
" Format on save
let g:rustfmt_autosave = 1

" =====[ YouCompleteMe ]=====
let g:ycm_use_clangd = 1
nnoremap <F12> :YcmCompleter GoTo<CR>
