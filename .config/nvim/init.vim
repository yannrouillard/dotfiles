if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tweekmonster/fzf-filemru'
Plug 'rking/ag.vim'
Plug 'neomake/neomake'
Plug 'janko-m/vim-test'
Plug 'romainl/vim-qf'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'jreybert/vimagit'
Plug 'lambdalisue/gina.vim'
Plug 'chr4/nginx.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-lua-ftplugin'
Plug 'xolox/vim-lua-inspect'
Plug 'dracula/vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vimlab/split-term.vim'

if executable('python') || executable('python3')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'zchee/deoplete-jedi'
endif

if executable('npm')
  " Javascript support 
  Plug 'ternjs/tern_for_vim'
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
  Plug 'pangloss/vim-javascript'
  Plug 'othree/yajs.vim'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'posva/vim-vue'
endif

call plug#end()

" Fuzzy search with ctrl-P
nnoremap <C-p> :FZF<CR>

" Show the line numbers on the left side.
set number
set noswapfile
set autowrite

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

" Enable automatic filetype detection
filetype on

" Change color of syntax check markers
highlight NeomakeErrorMsg ctermfg=227 ctermbg=237
highlight MyWarningMsg ctermfg=yellow ctermbg=none

" Enable automatic syntax check on buffer save
autocmd! BufWritePost,BufEnter * Neomake "Run :Neomake"
let g:neomake_open_list = 2

color dracula

let mapleader = ","

let g:AutoPairsFlyMode = 1

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

let g:deoplete#enable_at_startup = 1

let g:neomake_javascript_enabled_makers = ['eslint']

" Ours default tabs settings
set ts=4 sts=4 sw=4 expandtab

nnoremap <c-p> :FilesMru --tiebreak=end<cr>


let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>
autocmd CompleteDone * pclose " To close preview window of deoplete automagically

noremap <c-e> :ll<cr>

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

set hidden

" make test commands execute using dispatch.vim
let test#strategy = "neomake"
" let test#python#runner = 'nose'

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
