"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This .vimrc was initially setup from:
"       Amir Salihefendic
"       http://amix.dk - amix@amix.dk
"
"       Version: 
"             5.0 - 29/05/12 15:43:36
"
" Sections:
"    -> Vundle setup
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug and plugin setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:ale_completion_enabled = 1
call plug#begin()

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " awesome fuzzing helper"
Plug 'junegunn/fzf.vim'                             " fzf's helpers
"Plug 'w0rp/ale'                                     " Linter
Plug 'vim-airline/vim-airline'                      " Status bar
Plug 'vim-airline/vim-airline-themes'               " Airline themes
Plug 'jiangmiao/auto-pairs'                         " Pairing of brackets
Plug 'editorconfig/editorconfig-vim'                " Switch settings based on code bases
Plug 'mattn/emmet-vim'                              " The awesome html helpers
Plug 'scrooloose/nerdcommenter'                     " Helps in commenting codes
Plug 'airblade/vim-gitgutter'                       " Marks the changed lines
Plug 'tpope/vim-fugitive'                           " Awesome git plugin
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-surround'                           " Changing the surrouding brackets/quotes
Plug 'godlygeek/tabular'                            " Fixing tabluar indentation
Plug 'sheerun/vim-polyglot'                         " Syntax plugin for a 100+ languages
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'  }
Plug 'rust-lang/rust.vim'
Plug 'majutsushi/tagbar'
"Plug 'bufbuild/vim-buf'
Plug 'uber/prototool', { 'rtp':'vim/prototool'  }

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

"set background=dark
colorscheme Mustang

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l:%c[%P\]


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>
noremap <leader>x :ccl<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Vertical split in right
set splitright

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

"My code starts from here
set mouse=a 
set number

nnoremap <silent><C-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><C-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

au BufRead,BufNewFile *.asm set filetype=nasm
au BufRead,BufNewFile *.s set filetype=gas

"let g:EditorConfig_core_mode = 'external_command'

"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

autocmd Filetype gitcommit setlocal spell textwidth=72

function! CLsp()
  if executable('clangd')
    au User lsp_setup call lsp#register_server({
          \ 'name': 'clangd',
          "\ 'cmd': {server_info -> ['linux-clangd', '-background-index'] },
          \ 'cmd': {server_info -> ['clangd', '-background-index'] },
          \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
          \ })
  endif
endfunction

function! PythonLsp()
  echo "here1"
	if executable('pyls')
    echo "here2"
			au User lsp_setup call lsp#register_server({
					\ 'name': 'pyls',
					\ 'cmd': {server_info->['pyls']},
					\ 'whitelist': ['python'],
					\ 'workspace_config': {'pyls': {'plugins': {'pydocstyle': {'enabled': v:true}}}}
					\ })
	endif
endfunction

function! GoLsp()
  if executable('gopls')
    au User lsp_setup call lsp#register_server({
          \ 'name': 'gopls',
          \ 'cmd': {server_info->['gopls', '-remote=auto'] },
          \ 'whitelist': ['go'],
          \ })
    autocmd BufWritePre *.go LspDocumentFormatSync
  endif
endfunction

function! JsLsp()
  if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
          \ 'name': 'javascript support using typescript-language-server',
          \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio'] },
          \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..')) },
          \ 'whitelist': ['javascript', 'javascript.jsx', 'javascriptreact']
          \ })
    autocmd BufWritePre *.js LspDocumentFormatSync
  endif
endfunction

function! RustLsp()
  if executable('rust-analyzer')
    au User lsp_setup call lsp#register_server({
          \   'name': 'Rust Language Server',
          \   'cmd': {server_info->['rust-analyzer']},
          \   'whitelist': ['rust'],
          \ })
  endif
endfunction

function! ProtoLsp()
  if executable('prototool-lint')
    au User lsp_setup call lsp#register_server({
          \ 'name': 'prototool-lint',
          \ 'cmd': {server_info->['prototool-lint'] },
          \ 'whitelist': ['proto'],
          \ })
  endif
endfunction

function! PythonLsp()
  if executable('pyls')
    au User lsp_setup call lsp#register_server({
          \ 'name': 'pyls',
          \ 'cmd': {server_info->['pyls']},
          \ 'whitelist': ['python'],
          \ 'workspace_config': {'pyls': {'plugins': {'pyls_mypy': {'enabled': v:true, "live_mode": v:false}}}},
          \ })
  endif
endfunction

function! YAMLLsp()
  if executable('yaml-language-server')
		autocmd User lsp_setup call lsp#register_server({
       \ 'name': 'yaml-language-server',
       \ 'cmd': {server_info->['yaml-language-server', '--stdio']},
       \ 'whitelist': ['yaml', 'yaml.ansible'],
       \ 'workspace_config': {
       \   'yaml': {
       \     'validate': v:true,
       \     'hover': v:true,
       \     'completion': v:true,
       \     'customTags': [],
       \     'schemas': { 'kubernetes': '/*.yaml'},
       \     'schemaStore': { 'enable': v:true },
       \   }
       \ }
       \ })
  endif
endfunction

"Add marker at 81st column
"Remove trailing whitespace
autocmd FileType c,cpp,ruby,java,php,python,lisp
      \ setlocal colorcolumn=80 |
      \ autocmd BufWritePre <buffer> :%s/\s\+$//e

autocmd FileType c,cpp
      \ setlocal noexpandtab |
      \ setlocal tabstop=4 |
      \ setlocal shiftwidth=4 |
      \ call CLsp()

autocmd FileType go
      \ map <leader>d  :GoDef<cr>|
      \ map <leader>D  :GoDecls<cr>|
      \ map <leader>r  :GoReferrers<cr>|
      \ map <leader>f  :GoFillStruct<cr>|
      \ map <leader>i  :GoInfo<cr>|
      \ map <leader>e  :GoDiagnostics<cr>|
      \ map <leader>td :GoDefType<cr>|
      \ set foldmethod=syntax
      "\ call GoLsp()

autocmd FileType markdown
      \ setlocal spell |
      \ setlocal colorcolumn=80 |
      \ setlocal textwidth=80

autocmd FileType python
      \ call PythonLsp()

autocmd FileType proto
      \ setlocal tabstop=4 |
      \ setlocal shiftwidth=4 |
      \ call ProtoLsp()

autocmd FileType javascript
      \ call JsLsp()

"autocmd FileType python
      "\ call PythonLsp()

autocmd FileType rust 
      \ call deoplete#custom#buffer_option('auto_complete', v:false) |
      \ call RustLsp()

autocmd FileType yaml
      \ setlocal omnifunc=lsp#complete |
      \ call YAMLLsp()

"Transperent backgound
hi Normal ctermbg=NONE

let g:airline_powerline_fonts = 1
let g:airline_theme='dark'
let g:airline#extensions#tabline#enabled = 1

"set list
"set listchars=tab:>-

map <C-p> :Files<CR>
map <C-l> :Buffers<CR>
map <C-k> :!tmux send -t 1 q Up Enter<CR><CR>

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

let g:ale_lint_delay = 10000
let g:ale_set_balloons=1
let g:ale_linters = {'c': [], 'cpp': [], 'go': [], 'proto': ['prototool-lint',], 'javascript': []} " Disabling for C/C++ in favour of vim-lsp

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

" vim-lsp configurations
let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
noremap <leader>d :LspDefinition<cr>
set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()
set foldlevel=99 " Not to fold the whole file by default
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
map <C-a> <Plug>(lsp-code-action)
map <C-s> <Plug>(lsp-code-lens)

" asyncomplete.vim configs
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" netrw configs
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
map <leader>b :Vexplore!<cr>

"deoplete
let g:deoplete#enable_at_startup = 0
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*'  })
call deoplete#custom#option({
    \ 'auto_complete_delay': 1000,
    \ 'auto_refresh_delay': 1000,
    \})

nmap <C-x> :TagbarToggle<CR>
let g:tagbar_autofocus = 1


" Sometimes I wonder what's wrong with me
if &term =~ '^screen'
  " tmux knows the extended mouse mode
  set ttymouse=sgr
endif
if &term =~ '256color'
  " Enable true (24-bit) colors instead of (8-bit) 256 colors.
  " :h true-color
  if has('termguicolors')
    "let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    "let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    "set termguicolors
  endif
endif

" vim-fugitive
let g:fugitive_gitlab_domains = ['https://gitlab.eng.vmware.com']

let g:go_metalinter_autosave = 1
"let g:go_metalinter_command = "golangci-lint"
"let g:go_diagnostics_enabled = 1
"let g:go_metalinter_autosave_enabled=['golint', 'govet', 'typecheck']
"let g:go_metalinter_command='golangci-lint'
"let g:go_auto_type_info = 1
let g:go_imports_autosave = 0
let g:go_fillstruct_mode = 'fillstruct'
let g:go_list_type_commands = {"GoMetaLinterAutoSave": "quickfix"}
let g:go_jump_to_error = 1

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_popup_delay = 500

let g:lsp_settings = {
  \  'gopls': {'args': ['-remote=auto']},
  \}

function! GoDisassFunc()
   let l:line = search('func \?\(([a-z]\+ \?\*\?\([a-z]\+\))\)\? \(\w\+\)(', 'bcnW')
   if l:line == 0 
     echo "not in a method"
     return
   endif

   let l:mats = matchlist(getline(l:line), 'func \?\(([a-z]\+ \?\*\?\([a-z]\+\))\)\? \(\w\+\)(')
   let l:sig = mats[3]
   if len(l:mats[2]) > 0
     let l:sig = mats[2] . ".?." . l:sig 
   endif
   echo "processing method " . l:sig
   let l:root = go#util#ModuleRoot()
   let l:cmds = globpath(go#util#ModuleRoot() . "/cmd", "*", 1, 1)
   for l:cmd in cmds
     echo l:cmd
     call system("go build -o tmp.vim.out " . l:cmd )
     let l:asm = system("go tool objdump -s " . l:sig . " ./tmp.vim.out")
     if len(l:asm) == 0 
       continue
     endif

     let l:filename = expand("%:t")
     let l:bname = '\[Disassembly - ' . l:filename . '\]'
     " create a new buffer
     exec 'topleft vsplit' . l:bname
     " clear the buffer
     silent! %d _
     put =l:asm
     setlocal nomodified nomodifiable filetype=asm buftype=nofile bufhidden=wipe
     return
   endfor
   echo "couldn't method in any of the compiled binary"
endfunction

command! GoDisass call GoDisassFunc()
