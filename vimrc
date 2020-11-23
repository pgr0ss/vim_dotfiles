set nocompatible
syntax on

call plug#begin('~/.vim/plugged')

Plug 'aklt/plantuml-syntax'
Plug 'benmills/vimux'
Plug 'chase/vim-ansible-yaml'
Plug 'elixir-lang/vim-elixir'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'hashivim/vim-terraform'
Plug 'janko-m/vim-test'
Plug 'jtratner/vim-flavored-markdown'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pgr0ss/vim-github-url'
Plug 'rodjek/vim-puppet'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'uarun/vim-protobuf'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/Align'
Plug 'w0rp/ale'

call plug#end()

set background=dark
set backupcopy=yes
set completeopt-=preview
set dir=/tmp//
set hidden
set hlsearch
set ignorecase
set isk+=?
set mouse=
set nofoldenable
set number
set scrolloff=5
set showmatch
set smartcase
set textwidth=0 nosmartindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set updatetime=300
set wildignore+=*.pyc,*.o,*.class
set wrap

colorscheme vibrantink

nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> Y y$

autocmd BufNewFile,BufRead *.md,*.markdown setlocal textwidth=120 spell
autocmd BufNewFile,BufRead *.txt setlocal spell
autocmd FileType elm,kotlin,php,python,rust setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType gitcommit setlocal spell
autocmd FileType go setlocal noexpandtab
autocmd FileType tex setlocal textwidth=80 spell
autocmd Filetype elixir :command! A ElixirAlternateFile()

" Aliases
command! SudoW w !sudo tee "%" > /dev/null
command! W w

map <silent> <LocalLeader>p :set paste<CR>:echo 'Paste mode on'<CR>
map <silent> <LocalLeader>P :set nopaste<CR>:echo 'Paste mode off'<CR>

" https://vim.fandom.com/wiki/Reverse_order_of_lines
command! -bar -range=% ReverseLines <line1>,<line2>g/^/m<line1>-1|nohl

" Grep
function! Grep(search)
  let l:cmd = 'rg -i --vimgrep "' . a:search . '"'
  echo 'Running: ' . l:cmd
  cgetexpr system(l:cmd)
  cwin
endfunction
command! -nargs=1 Grep :call Grep('<args>')

" GitGrepWord
function! GitGrepWord()
  cgetexpr system("git grep -n '" . expand("<cword>") . "'")
  cwin
  echo 'Number of matches: ' . len(getqflist())
endfunction
command! -nargs=0 GitGrepWord :call GitGrepWord()
nnoremap <silent> <Leader>gw :GitGrepWord<CR>

" FZF
let $FZF_DEFAULT_COMMAND = 'find . -type f 2>/dev/null
                             \ | grep -v -E "tmp\/|.gitmodules|.git\/|deps\/|_build\/|node_modules\/|vendor\/"
                             \ | sed "s|^\./||"'
let $FZF_DEFAULT_OPTS = '--reverse'
let g:fzf_tags_command = 'ctags -R --exclude=".git" --exclude="node_modules" --exclude="vendor" --exclude="log" --exclude="tmp" --exclude="db" --exclude="pkg" --exclude="deps" --exclude="_build" --exclude="output" --extra=+f .'

map <silent> <leader>ff :Files<CR>
map <silent> <leader>fg :GFiles<CR>
map <silent> <leader>fb :Buffers<CR>
map <silent> <leader>ft :Tags<CR>

" NerdTree
map <silent> <LocalLeader>nf :NERDTreeFind<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>

" Search highlighting
map <silent> <LocalLeader>nh :nohls<CR>

" CTags
map <silent> <LocalLeader>rt :!ctags -R --exclude=".git" --exclude="node_modules" --exclude="vendor" --exclude="log" --exclude="tmp" --exclude="db" --exclude="pkg" --exclude="deps" --exclude="_build" --extra=+f .<CR>

" Test
nnoremap <silent> <leader>rf :wa<CR>:TestNearest<CR>
nnoremap <silent> <leader>rb :wa<CR>:TestFile<CR>
nnoremap <silent> <leader>ra :wa<CR>:TestSuite<CR>
nnoremap <silent> <leader>rl :wa<CR>:TestLast<CR>

" Vimux
let g:test#strategy = 'vimux'
let g:test#preserve_screen = 0
let g:VimuxUseNearestPane = 1

map <silent> <LocalLeader>ri :wa<CR> :VimuxInspectRunner<CR>
map <silent> <LocalLeader>vl :wa<CR> :VimuxRunLastCommand<CR>
map <silent> <LocalLeader>vi :wa<CR> :VimuxInspectRunner<CR>
map <silent> <LocalLeader>vk :wa<CR> :VimuxInterruptRunner<CR>
map <silent> <LocalLeader>vx :wa<CR> :VimuxCloseRunner<CR>
map <silent> <LocalLeader>vp :VimuxPromptCommand<CR>

vmap <silent> <LocalLeader>vs "vy :call VimuxRunCommand(@v)<CR>
nmap <silent> <LocalLeader>vs vip<LocalLeader>vs<CR>

" Ale
let g:ale_enabled = 1                     " Enable linting by default
let g:ale_fix_on_save = 1
let g:ale_lint_on_insert_leave = 1        " Automatically lint when leaving insert mode
let g:ale_lint_on_text_changed = 'normal' " Only lint while in normal mode
let g:ale_linters_explicit = 1            " Only run linters that are explicitly listed below
let g:ale_set_highlights = 0              " Disable highlighting as it interferes with readability and accessibility
let g:ale_set_signs = 1                   " Enable signs showing in the gutter to reduce interruptive visuals

let g:ale_linters = {
\   'elixir': ['mix'],
\   'puppet': ['puppetlint'],
\   'ruby': ['ruby'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'terraform': ['terraform'],
\}

let black = system('grep -q black Pipfile')
if v:shell_error == 0
  let g:ale_fixers['python'] = ['black']
  let g:ale_python_black_auto_pipenv = 1
endif

" Status
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " buffer number, and flags
set statusline+=%-40f\                    " relative path
set statusline+=%=                        " seperate between right- and left-aligned
set statusline+=%1*%y%*%*\                " file type
set statusline+=%10(L(%l/%L)%)\           " line
set statusline+=%2(C(%v/125)%)\           " column
set statusline+=%P                        " percentage of file
