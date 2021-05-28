set nocompatible
syntax on

call plug#begin('~/.vim/plugged')

Plug 'aklt/plantuml-syntax'
Plug 'benmills/vimux'
Plug 'chase/vim-ansible-yaml'
Plug 'elixir-lang/vim-elixir'
Plug 'hashivim/vim-terraform'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kshenoy/vim-signature'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
set signcolumn=yes
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

augroup filetypedetect
  au BufRead,BufNewFile go.mod set filetype=go
augroup END

" Aliases
command! SudoW w !sudo tee "%" > /dev/null
command! W w
imap <C-L> <SPACE>=><SPACE>

map <silent> <LocalLeader>p :set paste<CR>:echo 'Paste mode on'<CR>
map <silent> <LocalLeader>P :set nopaste<CR>:echo 'Paste mode off'<CR>

" https://vim.fandom.com/wiki/Reverse_order_of_lines
command! -bar -range=% ReverseLines <line1>,<line2>g/^/m<line1>-1|nohl

" Grep
function! Grep(search)
  let l:cmd = 'rg -i --sort path --vimgrep "' . a:search . '"'
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
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob !.git --sort path'
let $FZF_DEFAULT_OPTS = '--reverse'
let g:fzf_tags_command = 'ctags -R --exclude=".git" --exclude="node_modules" --exclude="vendor" --exclude="log" --exclude="tmp" --exclude="db" --exclude="pkg" --exclude="deps" --exclude="_build" --exclude="output" --extra=+f .'

map <silent> <leader>ff :Files<CR>
map <silent> <leader>fg :GFiles<CR>
map <silent> <leader>fb :Buffers<CR>
map <silent> <leader>ft :Tags<CR>

" Markdown

let g:markdown_fenced_languages = [
\  'bash=sh',
\  'go',
\  'html',
\  'java',
\  'javascript',
\  'python',
\  'ruby',
\  'c',
\  'rust',
\  'c++=cpp',
\  'cpp',
\]

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

map <silent> <LocalLeader>ri :wa<CR>:VimuxInspectRunner<CR>
map <silent> <LocalLeader>vl :wa<CR>:VimuxRunLastCommand<CR>
map <silent> <LocalLeader>vi :wa<CR>:VimuxInspectRunner<CR>
map <silent> <LocalLeader>vk :wa<CR>:VimuxInterruptRunner<CR>
map <silent> <LocalLeader>vx :wa<CR>:VimuxCloseRunner<CR>
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
\   'sh': ['shellcheck'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['rufo'],
\   'terraform': ['terraform'],
\}

"" Sometimes Coc puts the error at the end of the file (e.g. when missing a close brace), so we don't want to format it with ale. Once the file compiles, gofmt will format it as part of Coc.
let g:ale_fix_on_save_ignore = {'go': ['remove_trailing_lines', 'trim_whitespace']}

let g:ale_ruby_rufo_executable = 'bundle'

let black = system('grep -q black Pipfile')
if v:shell_error == 0
  let g:ale_fixers['python'] = ['black']
  let g:ale_python_black_auto_pipenv = 1
endif

" Coc

highlight! CocFloating ctermbg=black

command! -nargs=0 CocOutputChannel :CocCommand workspace.showOutput
command! -nargs=0 CocImports :call CocAction('runCommand', 'editor.action.organizeImport')

inoremap <silent><expr> <c-@> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

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
