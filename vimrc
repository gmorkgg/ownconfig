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

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"



"set fileencodings=ucs-bom,utf-8,cp936
set fileencodings=utf-8,cp936
" 显示中文帮助
if version >= 603
	set helplang=cn
	set encoding=utf-8
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
"如果文件类型为.sh文件 
if &filetype == 'sh' 
call setline(1,"\#####################################") 
call append(line("."), "\# File Name: ".expand("%")) 
call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
call append(line(".")+4, "\#####################################") 
call append(line(".")+5, "\#!/bin/bash") 
call append(line(".")+6, "") 
"else 
"call setline(1, "/*************************************************************************") 
"call append(line("."), "	> File Name: ".expand("%")) 
"call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
"call append(line(".")+4, " ************************************************************************/") 
"call append(line(".")+5, "")
endif
if &filetype == 'py' 
call setline(1,"\#####################################") 
call append(line("."), "\# File Name: ".expand("%")) 
call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
call append(line(".")+4, "\#####################################") 
call append(line(".")+5, "\#!/usr/bin/python") 
call append(line(".")+6, "") 
endif
if &filetype == 'python' 
call setline(1,"\#####################################") 
call append(line("."), "\# File Name: ".expand("%")) 
call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
call append(line(".")+4, "\#####################################") 
call append(line(".")+5, "\#!/usr/bin/python") 
call append(line(".")+6, "") 
endif
if &filetype == 'cpp'
call append(line(".")+6, "#include<iostream>")
call append(line(".")+7, "using namespace std;")
call append(line(".")+8, "")
endif
if &filetype == 'c'
call append(line(".")+6, "#include<stdio.h>")
call append(line(".")+7, "")
endif
"	if &filetype == 'java'
"		call append(line(".")+6,"public class ".expand("%"))
"		call append(line(".")+7,"")
"	endif
"新建文件后，自动定位到文件末尾 autocmd BufNewFile * normal G
endfunc 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"代码补全 
set completeopt=preview,menu 
"允许插件  
filetype plugin on

" 去掉输入错误的提示声音
set noeb

" 自动缩进
set autoindent
set cindent
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 不要用空格代替制表符
"set noexpandtab
" 在行和段开始处使用制表符
"set smarttab
" 显示行号
set number
" 历史记录数
set history=1000
"禁止生成临时文件
"set nobackup
"set noswapfile
"搜索忽略大小写
"set ignorecase
"搜索逐字符高亮
set hlsearch
set incsearch
""行内替换
"set gdefault
"编码设置
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
"语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn
" 我的状态行显示的内容（包括文件类型和解码）
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
" 总是显示状态行
"set laststatus=2
"" 命令行（在状态行下）的高度，默认为1，这里是2
"set cmdheight=2
" 侦测文件类型
filetype on
" 载入文件类型插件
filetype plugin on
" 为特定文件类型载入相关缩进文件
filetype indent on
filetype plugin indent on 
"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"Add argument (can be negative, default 1) to global variable i.
" Return value of i before the change.

function! Incr()
	let a = line('.') - line("'<")
	let c = virtcol("'<")
	if a > 0 
		execute 'normal! '.c.'|'.a."\<C-a>"
	endif
	normal `<
endfunction
vnoremap <C-a> :call Incr()<CR>

"colorscheme evening
"colorscheme morning
"colorscheme torte
