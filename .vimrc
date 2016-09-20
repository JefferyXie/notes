
" 5/15/2015 jeffery: below codes are system default config
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

" 5/14/2015: added by Jeffery
let &termencoding=&encoding " to support chinese
set fileencodings=utf-8,ucs-bom,gbk18030,gbk,gbk2312,cp936 " to support chinese
set ignorecase
set wildmenu " vi command auto complete
set number
set autoindent
color desert
set laststatus=2
set cursorline " highlight current row
"set cursorcolumn " highlight current column
set hlsearch " highlight search result
highlight Search guibg=Yellow guifg=Black ctermbg=Yellow ctermfg=Black

highlight Comment ctermfg=lightblue 
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE 

" Disable highlight when <leader><cr> is pressed, <silent> tells vi to show no message
map <silent> <leader><cr> :noh<cr> 
" Remove the Windows ^M when encodings get messed up
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" Search all files in current folder/project and show the occurrences
nnoremap <leader>vv :grep -ir <cword> --exclude='tags' --exclude='*.o' --exclude='*.so' --exclude='*.a' */** <cr>:cwindow<cr>
" Search all inherited classes
nnoremap <leader>cc :grep -r :.*<cword> --exclude='tags' --exclude='*.o' --exclude='*.so' --exclude='*.cpp' --exclude='*.a' */** <cr>:cwindow<cr>

set clipboard=unnamedplus " enable copy/paste between different vi instances
"source $VIMRUNTIME/ftplugin/man.vim " launch man command inside vi
" let g:Powerline_colorscheme='solarized256' " set status bar style
" avoid writing #includes and macros every time you open a cpp file
autocmd BufNewFile *.cpp r /path/to/file.cpp
set foldmethod=indent " fold based on indent
"set foldmethod=syntax " fold based on syntax
set nofoldenable " turn off fold when launch vi
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
" set mouse=a " this sets vi into visual mode whenever you select something
" with the mouse. With this, one is not allowed to copy in visual mode. You
" can get around it by holding down shift when selecting text not to go into
" visual mode allowing you to use the copy menu.
set mouse=v " with this, copy menu works again
" don't need below mapping keys to make vi different from windows
"map <C-a> GVgg
"map <C-n> :enew
"map <C-o> :e . <Enter>
"map <C-s> :w <Enter>
"map <C-c> y
"map <C-v> p
"map <C-x> d
"map <C-z> u
"map <C-t> :tabnew <Enter>
"map <C-i> >>
"map <C-w> :close <Enter>
"map <C-W> :q! <Enter>
"map <C-f> /
"map <F3> n
"map <C-h> :%s/
map <Tab> :bn <Enter>
" shortcurt for switch among split windows
"map <C-j> <C-W>j " Ctrl+j = Ctrl+W+j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l


" 5/18/2015: added by Jeffery for Vundle
set nocompatible              " be iMproved, required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe' " cannot use YCM since it requires glibc2.14+
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline' " lean & mean status/tabline for vim that is light as air
Plugin 'SirVer/ultisnips' " ultimate solution for snippet
"Plugin 'edsono/vim-matchit'
Plugin 'elzr/vim-json' " distinct highlighting of keywords vs values, json
"Plugin 'ludovicchabant/vim-lawrencium'
Plugin 'majutsushi/tagbar' " browse tags of current file and create a sidebar that displays the ctags-generated tags of current file
"Plugin 'mhinz/vim-signify'
"Plugin 'plasticboy/vim-markdown'
"Plugin 'tpope/vim-fugitive'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree' " explore filesystem and open file and directory
Plugin 'Xuyuanp/nerdtree-git-plugin' " plugin of NERDTree showing git status flags
Plugin 'geordanr/pylint' " python syntax check
Plugin 'Valloric/ListToggle' " toggle the display of quickfix list and location-list
"Plugin 'vim-scripts/taglist.vim' " source code browser
Plugin 'octol/vim-cpp-enhanced-highlight' " highlighting for c++11/14
Plugin 'Mizuchi/STL-Syntax' " improved c++11/14 STL highlighting
Plugin 'Yggdroot/indentLine' " display the indention levels with thin vertical line
Plugin 'sukima/xmledit' " auto add tag when editing xml
Plugin 'kien/ctrlp.vim' " CtrlP to search files
Plugin 'vim-scripts/mru.vim' " manage Most Recently Used files, command :MRU 
"Plugin 'vim-scripts/cscope.vim' "create cscope database and connect to existing proper database automatically
Plugin 'craigemery/vim-autotag' " automatically discover and properly update ctags files on save
Plugin 'vim-scripts/BufOnly.vim' " Delete all the buffers except the current/named buffer
":BufOnly without an argument will unload all buffers but the current one.
":BufOnly with an argument will close all buffers but the supplied buffer name/number.
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/a.vim' " switch between .h/.c
Plugin 'klen/python-mode' " python plugin bundle
Plugin 'davidhalter/jedi-vim' " python auto complete
Plugin 'ruediger/Boost-Pretty-Printer' " GDB Pretty Printers for Boost
Plugin 'kshenoy/vim-signature' " toggle, display and navigate marks
Plugin 'vim-scripts/BOOKMARKS--Mark-and-Highlight-Full-Lines' " Easily Highlight Lines with Marks, and Add/Remove Marks 

" All of your Plugins must be added before the following line
call vundle#end()            " required
"filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" YouCompleteMe config
" 配置默认的ycm_extra_conf.py
"let g:ycm_global_ycm_extra_conf = '/home/jexie/jeffery/.ycm_extra_conf.py'   
let g:ycm_global_ycm_extra_conf = '/home/jexie/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" 补全功能在注释中有效
let g:ycm_complete_in_comments=1
" 允许 vim 加载 .ycm_extra_conf.py 文件，需要提示！
let g:ycm_confirm_extra_conf=1
" NEVER load another .ycm_extra_conf.py under debesys folder!
let g:ycm_extra_conf_globlist = ['/home/jexie/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/*','!/home/jexie/work/debesys/*']
"let g:ycm_extra_conf_globlist = ['/home/jexie/jeffery/*','!/home/jexie/work/debesys/*']
" 开启 YCM 标签补全引擎
let g:ycm_collect_identifiers_from_tags_files=1
" 引入 C++ 标准库tags
set tags+=/opt/gcc/include/c++/4.9.1/tags
" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 语法关键字补全         
let g:ycm_seed_identifiers_with_syntax=1
" Goto definition
nnoremap <leader>jc :YcmCompleter GoToDeclaration<CR>
" 只能是 #include 或已打开的文件
nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>

" To avoid YCM conflict with UltiSnips with tab key
" http://www.alexeyshmalko.com/2014/youcompleteme-ultimate-autocomplete-plugin-for-vim/
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

" to config Syntastic, enable c++11 and use libc++ library with gcc
" http://vi.stackexchange.com/questions/3190/syntastic-c14-support
let g:syntastic_cpp_checkers=['gcc']
let g:syntastic_cpp_compiler='gcc'
let g:syntastic_cpp_compiler_options=' -std=c++11 -stdlib=libc++ '
"let g:ycm_show_diagnostics_ui=0
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=0
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

" search first in current directory then file directory for tag file
set tags+=tags,./tags

" airline config: display all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled=1 " enable the list of buffers
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'
" let g:airline#extensions#tabline#fnamemod=':t' " show just the filename
" close current buffer and move to the previous one - to replicate the idea of
" closing a tab
nmap <leader>bq :bp <BAR> bd #<CR> 

" tagbar config
nmap <F8> :TagbarToggle<CR>
"let g:tagbar_left=1
let g:tagbar_right=1
let g:tagbar_width=20
let g:tagbar_indent=1
"let g:tagbar_show_visibility=0 " show/hide visibility symbols (public/private)
"let g:tagbar_autoshowtag=1

" NERDTree config
autocmd vimenter * NERDTree " open NERDTree automatically
autocmd StdinReadPre * let s:std_in=1 " open NERDTree if no file is specified
autocmd VimEnter * if argc()==0&&!exists("s:std_in") | NERDTree | endif
" close vi if only window left open is NERDTree
autocmd bufenter * if (winnr("$")==1&&exists("b:NERDTreeType")&&b:NERDTreeType=="primary") | q | endif
nmap <F9> :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=25
" 设置NERDTree子窗口位置
let NERDTreeWinPos="left"
" 不显示隐藏文件
let NERDTreeShowHidden=0
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1
" hide file types
let NERDTreeIgnore=['\.zip$','\.o$','\.so$','\.a$','\.lib$','\.gz$','\.out$','\.so.*$','\.ui$','\.pro$','\.pro.user$','\.pro.user.*$']

" ListToggle config
let g:lt_location_list_toggle_map='<leader>l' " shortkey to toggle locationlist
let g:lt_quickfix_list_toggle_map='<leader>q' " shortkey to toggle quickfix
let g:lt_height=10

" vim-cpp-enhanced-highlight config
let g:cpp_class_scope_highlight=1
let g:cpp_experimental_template_highlight=1

" indentLine config
let g:indentLine_char='|'
let g:indentLine_enabled=1

" set xml auto formatting, type gg=G after open vi to take effect
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" enable xml fold by using syntax
" za: close/open fold at current cursor
" zM: close all folds recursively
" zR: open all folds recursively
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

" enable js fold by using syntax
let g:javaScript_fold=1
au FileType javascript setlocal foldmethod=syntax

" CtrlP configuration
" 'r' - the nearest ancestor that contains one of these directories or files:
" .git .hg .svn .bzr .darcs
" 'a' - like c, but only if the current working dir outside of CtrlP is not a
" direct ancestor of the dir of the current line
let g:ctrlp_working_path_mode='ra' 
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.a
" :CtrlP to invoke CtrlP in find file mode
" :CtrlPBuffer/:CtrlPMRU to start CtrlP in find buffer or MRU file mode
" :CtrlPMixed to search in files, buffers, and MRU files at the same time

" this part has been moved to auto-tag plugin
function! UpdateTags()
    execute ":!ctags -R --languages=C++ --c++-kinds=+p --fields=+iaS --extra=+q ./ "
    echohl StatusLine | echo "C/C++ tag updated" | echohl None
endfunction
nnoremap <F5> :call UpdateTags()

" a.vim hotkeys
":A switches to the header file corresponding to the current file being edited (or vise versa)
":AS splits and switches
":AV vertical splits and switches
":IH switches to file under cursor
":IHS splits and switches
":IHV vertical splits and switches
"<Leader>ih switches to file under cursor
"<Leader>is switches to the alternate file of file under cursor (e.g. on  <foo.h> switches to foo.cpp)

" python-mode config
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 1 " use davidhalter/jedi-vim instead

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1
" ignore warning when #columns exceeds 80, empty line at the end of file
let g:pymode_lint_ignore="E501,W601,W391"

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

" vim-signature shortcuts
"  m.           If no mark on line, place the next available mark. Otherwise, remove (first) existing mark.
"  m-           Delete all marks from the current line
"  m<Space>     Delete all marks from the current buffer
"  ]`           Jump to next mark
"  [`           Jump to prev mark
"  m/           Open location list and display marks from current buffer

" BOOKMARKS--Mark-and-Highlight-Full-Lines shortcuts
" <F1>            Turn on/update highlighting for all lines with markers
" <F2>            Turn off highlighting for lines with markers
" <SHIFT-F2> Erase all markers [a-z]
" <F5>             Add a mark on the current line (and highlight)
" <SHIFT-F5> Remove the mark on the current line

" compile shortcut, how to make sure compile current file's folder?
nmap <Leader>m :wa<CR>:make<CR>:cw<CR>

function! AutoCompile()
    execute ":wa"
    let pre_dir = getcwd()
    let cur_dir = expand("%:p:h")
    silent execute ":cd " . cur_dir
    silent execute ":make"
    silent execute ":cd " . pre_dir
    silent execute ":cw"
    silent execute ":redraw!"
    "echohl StatusLine | echo "Compiled!" | echohl None
endfunction
nmap <Leader>m :call AutoCompile()

" nerdtree-git-plugin config
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "@",
    \ "Untracked" : "$",
    \ "Renamed"   : ">",
    \ "Unmerged"  : "=",
    \ "Deleted"   : "!",
    \ "Dirty"     : "^",
    \ "Clean"     : "&",
    \ "Unknown"   : "?"
    \ }

