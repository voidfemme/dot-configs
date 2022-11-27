" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" This config is targeted for Vim 8.1+ and expects you to have Plug installed.
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Plugins
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set nocompatible
filetype off
" Specify a directory for plugins.
call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'

" Automatically show Vim's complete menu while typing
Plug 'vim-scripts/AutoComplPop'

" Languages and file types.
" [insert langauge and file types plugin list here]
"
" coc.nvim: c and c++ language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Basic Settings
" 	Research any of these by running :help <setting>
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Use a line cursor within insert mode and a block cursor everywhere else.
"
" Reference chart of values:
" 	ps = 0	-> blinking block.
" 	ps = 1	-> blinking block (default).
" 	ps = 2	-> steady block.
" 	ps = 3	-> blinking underline.
" 	ps = 4	-> steady underline.
" 	ps = 5	-> blinking bar (xterm)
" 	ps = 6	-> steady bar (xterm)

filetype plugin indent on
syntax on

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Lightline Settings
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:lightline = {
            \ 'colorscheme': '16color',
            \ }

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~~~~~~~ General settings ~~~~~~~~~~~~
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set title
set titlestring=%t
set confirm
set laststatus=2
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.exe,*.flv,*.img,*.xlsx,*.out,*.txt
" set term=xterm
" Tab Settings"
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
" Persistent undo
set undofile
set undodir=~/.vim/undodir

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~~~~~ interface preferences ~~~~~~~~~
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
set autoindent
set number
set ruler
set breakindent
set linebreak
set cindent
set encoding=utf-8
set cursorcolumn
set cursorline
highlight CursorLine term=NONE cterm=italic ctermbg=0
highlight CursorColumn term=NONE cterm=italic ctermbg=0
highlight CursorLineNr term=NONE cterm=bold ctermfg=6
" hi CursorColumn term=NONE ctermfg=245
" set ignorecase
" set smartcase

" highlight matches when searching, but do not leave results highlighted:
augroup vimrc-incsearch-highlight
		  autocmd!
		  autocmd CmdlineEnter /,\? :set hlsearch
		  autocmd CmdlineEnter /,\? :set nohlsearch
augroup END

" enable .rasi syntax highlighting
au BufNewFile,BufRead /*.rasi setf css

" Open vim to line when last opened:
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" Automatically turn off caps lock when leaving insert mode:
" function! Cap_status()
" 		  let St = systemlist('xset -q | grep "Caps Lock" | awk ''{print $4}''')[0]
" 		  return St
" endfunction
"
" function! Capsoff()
" 		  if Cap_status() == "on"
" 					 call system("xdotool key Caps_Lock")
" 					 redraw
" 					 highlight Cursor guifg=white guibg=black
" 		  endif
" endfunction
"
" function! Caps_Toggle()
" 		  call system("xdotool key Caps_Lock")
" 		  redraw
" 		  if Cap_status() == "on"
" 					 highlight Cursor guifg=white guibg=green
" 		  else
" 					 highlight Cursor guifg=white guibg=black
" 		  endif
" endfunction
"
" inoremap <c-a> <esc>:call Caps_Toggle()<cr>a
" autocmd InsertLeave * call Capsoff()
" set laststatus=2
" set statusline=
" set statusline+=\ %f
" set statusline+=%=%{\"CL\ \"\.Cap_status()}

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~ auto-complete settings ~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" source /usr/share/vim/vim90/menu.vim
" set cpo-=<
" set wcm=<C-Z>
" map <F4> :emenu <C-Z>
set autoread
set complete+=kspell
set completeopt=menuone,longest
set shortmess+=c
set wildmode=longest:full,full
set wildmenu
set visualbell
" set hlsearch
" set incsearch
" set ignorecase
" set spell

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~ Tab Completion ~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Remap TAB to keyward completion
function! InsertTabWrapper(direction)
	let col = col('.') - 1
	if !col || getline('.')[col -1] !~ '\k'
		return "\<tab>"
	elseif "backward" == a:direction
		return "\<c-p>"
	elseif "forward" == a:direction
		return "\<c-n>"
	else
		return "\<c-x>\<c-k>"
	endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper ("forward")<CR>
inoremap <s-tab> <c-r>InsertTabWrapper ("backward")<CR>
inoremap <c-tab> <c-r>=InsertTabWrapper ("startkey"><CR>

" toggle tab completion
function! ToggleTabCompletion()
	if mapcheck("\<tab>", "i") != ""
		:iunmap <tab>
		:iunmap <s-tab>
		:iunmap <c-tab>
		echo "tab completion off"
	else
		:imap <tab> <c-n>
		:imap <tab> <c-n>
		:imap <tab> <c-n>
		echo "tab completion on"
	endif
endfunction

map <Leader>tc :call ToggleTabCompletion()<CR>

" tell complete to look in the dictionary
set complete-=k complete+=k

" ~~~~~~~~~~~~~ End Tab Completion ~~~~~~~~~~~~~

"~~~~~~~~~ Standard Bindings ~~~~~~~~~~
" Shortcutting split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"~~~~~~~~~ C++ Language Settings ~~~~~~~~~
" au Filetype cpp inoremap " ""<left>
au Filetype cpp inoremap "<space><space>  ""<right>

"au Filetype cpp inoremap ( ()<left>
au Filetype cpp inoremap (<space><space>  ()<right>

"au Filetype cpp inoremap [ []<left>
au Filetype cpp inoremap [<space><space>  []<right>

"au Filetype cpp inoremap { {}<left>
au Filetype cpp inoremap {<space><space>  {}<right>
au Filetype cpp inoremap {<CR> {<CR>}<esc>O
au Filetype cpp inoremap {;<CR> {<CR>};<esc>O
" au Filetype cpp inoremap <<<quick way out of parens and quotation marks>>>


"~~~~~~~~~ Python Language Settings ~~~~~~~~~
"au Filetype python inoremap " ""<left>
au Filetype python inoremap "<space><space>  ""<right><right>

"au Filetype python inoremap ( ()<left>
au Filetype python inoremap (<space><space>  ()<right><right>

"au Filetype python inoremap [ []<left>
au Filetype python inoremap [<space><space>  []<right><right>

"au Filetype python inoremap { {}<left>
au Filetype python inoremap {<space><space>  {}<right><right>
au Filetype python inoremap {<CR> {<CR>}<esc>O

"~~~~~~~~ Markdown filetype settings ~~~~~~~~~
au BufRead,BufNewFile *.md setlocal textwidth=80

"~~~~~~~~~ Russian Keyboard Mapping ~~~~~~~~~

" set keymap=russian-jcukenwin
" set iminsert=0
" set imsearch=0
" highlight lCursor guifg=NONE guibg=Cyan

"  Notes from https://www.youtube.com/watch?v=2f8h45YR494&t=403&ab_channel=NickJanetakis
" 	"Using Vim's Built-in Complete Menu for Autocompleting Words"
" 	- Also, look up snippets!
" 	- AutoComplPop plugin
" 	- First, specify a directory for plugins

" Remap russian characters
nmap й q
nmap ц w
nmap у e
nmap к r
nmap е t
nmap н y
nmap ш i
nmap щ o
nmap з p
nmap ф a
nmap ы s
nmap в d
nmap а f
nmap п g

nmap р h
nmap о j
nmap л k
nmap д l
nmap я z
nmap ч x
nmap с c
nmap м v
nmap и b
nmap т n
nmap ь m

set t_Co=256
