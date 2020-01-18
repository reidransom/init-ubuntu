set ruler
set tabstop=4
set softtabstop=4
set shiftwidth=4
set cinoptions=>4
set autoindent
set expandtab
set enc=utf-8
set nocindent
set nosmartindent
set incsearch
set number  " Show line numbers

" Use mouse to highlight text and reposition panes
set mouse=a

" Fix clipboard copy/paste with external programs
" See https://stackoverflow.com/a/30691754
" set clipboard^=unnamed,unnamedplus
set clipboard=unnamed

" Fix backspace key
" From https://stackoverflow.com/a/34217222
set backspace=2  

syntax on

" Set alternate tab widths
autocmd FileType html :setlocal sw=2 ts=2 sts=2
autocmd FileType htmldjango :setlocal sw=2 ts=2 sts=2
autocmd FileType django :setlocal sw=2 ts=2 sts=2
autocmd FileType javascript :setlocal sw=2 ts=2 sts=2
autocmd FileType css :setlocal sw=2 ts=2 sts=2
autocmd FileType scss :setlocal sw=2 ts=2 sts=2

" More natural split opening
set splitbelow
set splitright

" Highlight search matches
set hlsearch

" Automatically reload files when they change on disk
set autoread
au CursorHold * checktime  " https://superuser.com/a/1090762

" Don't bother with .swp files and the like
set nobackup
set nowritebackup
set noswapfile

" set cursorline cursorcolumn " crosshair

" Remove trailing whitespace
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,php,ruby,python,javascript,html autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

inoremap DB import pdb; pdb.set_trace()

" Try to install NeoBundle
let iCanHazNeoBundle=1
let neobundle_readme=expand($HOME.'/.vim/bundle/neobundle.vim/README.md')
if !filereadable(neobundle_readme)
    echo "Installing NeoBundle.."
    echo ""
    silent !mkdir -p $HOME/.vim/bundle
    silent !git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
    let iCanHazNeoBundle=0
endif
if has('vim_starting')
    set rtp+=$HOME/.vim/bundle/neobundle.vim/
endif

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'ervandew/supertab'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'bkad/CamelCaseMotion'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'nono/vim-handlebars'
NeoBundle 'w0rp/ale'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-rhubarb'
call neobundle#end()

" Required
filetype plugin on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


let NERDTreeShowHidden = 1


" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Configure tagbar
nmap <F2> :TagbarToggle<CR>

let g:gitgutter_realtime = 1

command! -complete=file -nargs=1 Remove :echo 'Remove: '.'<f-args>'.' '.(delete(<f-args>) == 0 ? 'SUCCEEDED' : 'FAILED')

"let g:ale_python_pylint_executable = '/Users/reid/src/LCMS/venv/bin/python'
"let g:ale_python_pylint_options = '-rcfile /Users/reid/src/pdsdata/pylintrc'

let g:ale_pattern_options = {
\ '\.py$': {'ale_linters': ['pylint'], 'ale_fixers': []},
\ '\.js$': {'ale_linters': ['standard'], 'ale_fixers': []},
\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
\}

let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_saved = 1
let g:ale_lint_on_filetype_changed = 1

let g:jellybeans_overrides = {
\    'background': { 'guibg': '191919' },
\}

colorscheme jellybeans
