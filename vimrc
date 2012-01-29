set nocompatible  " turn off compatibility with the old vi;

filetype off
call pathogen#runtime_append_all_bundles()

" Use filetype plugins 
filetype on
filetype plugin on
filetype indent on

" turn syntax highlighting on by default
syntax on
syntax enable

if v:version >= 703
    "undo settings
    set undodir=~/.vim/undofiles
    set undofile
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set backspace=indent,eol,start                    " make that backspace key work the way it should;
set binary noeol                                  " do NOT put a carriage return at the end of the last line! if you are programming;
set cmdheight=1
set copyindent                                    " copy the previous indentation on autoindenting
set cursorline
set expandtab
set ffs=unix,dos,mac                              " Default file types;
set fileformat=unix   
set foldenable
set foldlevel=100
set foldmarker={,}
set foldmethod=marker
set formatoptions-=o                              " dont continue comments when pushing o/O
set hidden                                        " allows for files to be loaded into a hidden buffer;
set history=1000                                  " store lots of :cmdline history
set ignorecase
set incsearch
set iskeyword+=_,$,@,%,#
set laststatus=2
set listchars=tab:»\ ,eol:¬                       " Use the same symbols as TextMate for tabstops and EOLs. Useful for
set matchpairs=(:),{:},[:],<:>                    " for use with % key;
set modeline                                      " Allow file inline modelines to provide settings;
set mousehide
set nobackup                                      " do not keep backup files, it's 70's style cluttering;
set nocp
set nolazyredraw                                  " Don't redraw while executing macros ;
set nolist
set noswapfile                                    " do not write annoying intermediate swap files,;
set nowrap
set nowritebackup
set number
set preserveindent                                " save as much indent structure as possible;
set ruler                                         " show nice info in ruler;
set sc
set scrolloff=5                                   " Indicate jump out of the screen when 3 lines before end of the screen;
set scrolljump=5                                  " Jump 5 lines when running out of the screen;
set sidescrolloff=7
set sidescroll=5
set shell=bash\ --login                           " set the shell to use my bash rc;
set shiftround                                    " use multiple of shiftwidth when indenting with '<' and '>'
set shiftwidth=4
set showcmd                                       " show incomplete cmds down the bottom
set showmatch                                     " automatically show matching brackets.;
set showmode                                      " show current mode down the bottom
set smarttab                                      " insert tabs on the start of a line according to shiftwidth, not tabstop
set smartcase
set smartindent                                   " Indents smartly for c-like languages
set so=7
set softtabstop=4                                 " set our tabs to four spaces;
set vb
set wildmenu                                      " make tab completion for files/buffers act like bash;
set wildmode=list:full                            " show a list when pressing tab and complete;

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Maps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"easily escape out of insert mode 
inoremap ;; <Esc>

"Remap VIM 0
map 0 ^

map ,a :Ack 
map ,/ :FufLine <CR> 
map ,f :FufFile<CR>
map ,s :w <CR> 
map ,q :q <CR> 
map ,t <ESC>:NERDTreeToggle \| :silent NERDTreeMirror<RETURN>
map ,h :call cursor(0, len(getline('.'))/2) <CR>
map ,gf <C-w>gf
map ,cc :VCSCommit<CR>
map ,df :VCSVimDiff<CR>
map ,eol :e ++ff=dos<CR>
map ,m :MRU<CR>
"map ,m :MRU<CR>
map ,b :FufBuffer<C-M>
map ,l :FufBookmarkDir<CR>
map ,p :YRShow<CR>
inoremap <D-k> <C-N>

"useful window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"moving lines with enter and shift enter
map <CR> o<Esc>k
map <S-Enter> O<Esc>j

"used to switch buffers
map <C-Tab> :bnext<cr>
map <C-S-Tab> :bprevious<cr>

"useful remapping for plugins
map <down> <ESC>:YRShow <RETURN> 
map <left> <ESC>:NERDTreeToggle \| :silent NERDTreeMirror<RETURN>
map <right> <ESC> :TagbarToggle <CR>
map <up> <ESC>:GundoToggle <RETURN> 

"replace word under cursor
nmap <leader>z :%s#\<<C-r>=expand("<cword>")<CR>\># 

"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <D-k> mz:m-2<cr>`z
nmap <D-j> mz:m+<cr>`z
vmap <D-k> :m'<-2<cr>`>my`<mzgv`yo`z
vmap <D-j> :m'>+<cr>`<my`>mzgv`yo`z

cmap w!! %!sudo tee > /dev/null %

noremap R "_d

"Creates nicely spaced and completed brackets. See autoclose.vim plugin for
"other bracket and " closing combinations.
inoremap {<CR>  {<CR>}<Esc>ko
inoremap (<CR>  (<CR>)<Esc>ko

" Map ; to add ; to the end of the line, when missing
noremap <buffer> ; :s/\([^;]\)$/\1;/<cr>

" Yank from the cursor to the end of the line, to be consistent with C and D.
" (default: Y synonym for yy)
nnoremap Y y$

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

if has("gui_running")
    set guifont=Inconsolata:h15
    set t_Co=256
    set background=dark
    colorscheme railscasts2
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set guioptions-=m "menu
    set guioptions-=a
    set guioptions-=t

else
    set background=dark
    set t_Co=256
    colorscheme molokai
endif

set encoding=utf8
try
    lang en_US
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command Sections
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -nargs=1 MKSession :call MakeSession(<f-args>) 
command! -nargs=1 LoadSession :call LDSession(<f-args>) 
"Lets you short code NerdTree to NT
command! -nargs=1 NT NERDTree <args> 

command! EOL %s/\r\+$//e
command! CD cd %:h

""""""""""""""""""""""""""""""
" => file type runs
""""""""""""""""""""""""""""""
autocmd FileType python set omnifunc=pythoncomplete#Complete

autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
autocmd BufRead *.py nmap ,r :!python %<CR>

autocmd BufRead *.rb nmap ,r :!ruby %<CR>
autocmd BufRead *.js nmap ,r :!phantomjs %<CR>

""""""""""""""""""""""""""""""
" => Session 
""""""""""""""""""""""""""""""
let g:my_session_dir = '~/.vim/sessions'
function! MakeSession(sessionName)
    set noautochdir
    exe ':mksession! ' . g:my_session_dir . '/' . a:sessionName
    set autochdir
endfunction

let g:my_session_dir = '~/.vim/sessions'
function! LDSession(sessionName)
    set noautochdir
    exe 'source ' . g:my_session_dir . '/' . a:sessionName
    set autochdir
endfunction

""""""""""""""""""""""""""""""
" => LustyJuggler
""""""""""""""""""""""""""""""
let g:LustyJugglerSuppressRubyWarning = 1

""""""""""""""""""""""""""""""
" => YankRing
""""""""""""""""""""""""""""""
let g:yankring_history_dir='~/.vim/history'
let g:yankring_history_file='history'
let g:yankring_max_history=1000

""""""""""""""""""""""""""""""
" => Tagbar
""""""""""""""""""""""""""""""
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
let g:tagbar_width=26
noremap <silent> ,y :TagbarToggle<CR>

""""""""""""""""""""""""""""""
" => Snipmate plugin
""""""""""""""""""""""""""""""
let g:snips_author = "Justin Whaley"

""""""""""""""""""""""""""""""
" => Syntastic plugin
""""""""""""""""""""""""""""""
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
" edit/reload .vimrc-Configuration
"
nnoremap gce :e $HOME/.vimrc<CR>:echo "Opening vimrc" <CR>
nnoremap gcl :source $HOME/.vimrc<CR>:echo "Configuration reloaded" <CR>

""""""""""""""""""""""""""""""
" => NerdTree plugin
"""""""""""""""""""""""""""""
let NERDTreeWinSize=60

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ \ Line:\ %l/%L:%c
set statusline+=\ %#warningmsg#
set statusline+=\ %{SyntasticStatuslineFlag()}
set statusline+=\ %*

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>


function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

""""""""""""""""""""""""""""""
" => Misc
""""""""""""""""""""""""""""""
" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

function! HandleURI()
    let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
    echo s:uri
    if s:uri != ""
	exec "!open \"" . s:uri . "\""
    else
	echo "No URI found in line."
    endif
endfunction
map ,w :call HandleURI()<CR>

"---------------------------------------------------
"/ ------ FILETYPE SPECIFIC STUFF -----------------
"---------------------------------------------------
"see here for example http://amix.dk/blog/post/19021
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
