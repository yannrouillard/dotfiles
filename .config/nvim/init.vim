nmap <D-t> :LoadDailyTodo<CR>
nmap <D-i> :TodoNewTask<CR>
nmap <S-D-i> :TodoNewTaskItem<CR>
nmap <D-o> :TodoSortTasks<CR>
nmap <D-x> :TodoToggleState<CR>
nmap <D-a> :TodoArchiveDoneItems<CR>
nmap <D-r> :TodoAddRecurringTasks<CR>
nmap <Tab> za

nnoremap <D-h> <C-w>k
nnoremap <D-j> <C-w>h
nnoremap <D-k> <C-w>l
nnoremap <D-l> <C-w>j

nnoremap <S-D-k> :bn<CR>
nnoremap <S-D-j> :bp<CR>

let g:python3_host_prog = '/usr/local/bin/python3'

call plug#begin()
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

colorscheme dracula

au BufNewFile,BufRead *.todo set filetype=todo

set shiftwidth=2
set foldmethod=expr
set foldexpr=TestFunction(v:lnum)

cd ~/ysys
edit ~/ysys/daily_todo.todo
