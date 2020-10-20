set encoding=utf-8
let s:uname = system("uname")

" Plugin manager
call plug#begin('~/.vim/bundle')

Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'           , { 'on': 'NERDTree' }
Plug 'severin-lemaignan/vim-minimap' , { 'on': 'Minimap' }
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
" Plug 'itchyny/vim-cursorword'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-sleuth'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'ycm-core/YouCompleteMe'        , { 'do': 'python3 install.py --clangd-completer --ts-completer' }
Plug 'vim-scripts/fakeclip'

Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

Plug 'SirVer/ultisnips'              , { 'for': 'tex' }
Plug 'honza/vim-snippets'            , { 'for': 'tex' }
Plug 'LaTeX-Box-Team/LaTeX-Box'      , { 'for': 'tex'}

Plug 'guns/xterm-color-table.vim'    , { 'on': 'XtermColorTable' }

call plug#end()
if !empty(glob(expand("<sfile>:p:h") . "/.vim/bundle/vim-glaive"))
	let glaive_exists = 1
	call glaive#Install()
else
	let glaive_exists = 0
endif

" Syntax theme
syntax on
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set t_ZH=[3m
set t_ZR=[23m
set termguicolors
set fillchars+=vert:│
" set t_Co=256
colorscheme molokai
au BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp  " Treat arduino filetypes as c++
au BufNewFile,BufReadPost *.frag,*.vert set filetype=c  " Treat GLSL files as c
" au BufNewFile,BufReadPost *.rs set filetype=rust        " Recognize Rust files
set mouse=a

" Syntax folding
let php_folding = 1
let javaScript_fold = 1

" Directories for swp, backup, and undo files
set directory=~/.vim/.swp
set backupdir=~/.vim/.backup
set undofile
set undodir=~/.vim/.undo

" Tab formatting
set tabstop=4           " Tab width
set shiftwidth=4        " Shift and autoindent width
set noexpandtab         " Use tab characters
set smarttab            " Treat space indentation as tabs
set copyindent          " Copy indent structure of previous line
set preserveindent      " Preserve indent structure of current line
autocmd FileType c,cmake,cpp,haskell,javascript,python,rust setlocal expandtab  " Use spaces for certain filetypes
autocmd FileType c,cpp,javascript,yaml setlocal tabstop=2 shiftwidth=2
augroup ProjectSetup    " Use expandtab for certain projects
	au BufRead,BufEnter */CMakeLists.txt set expandtab
augroup END

augroup autoformat_settings
	autocmd FileType bzl AutoFormatBuffer buildifier
	autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
	autocmd FileType dart AutoFormatBuffer dartfmt
	autocmd FileType go AutoFormatBuffer gofmt
	autocmd FileType gn AutoFormatBuffer gn
	autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
	autocmd FileType java AutoFormatBuffer google-java-format
	autocmd FileType python AutoFormatBuffer black
	" Alternative: autocmd FileType python AutoFormatBuffer autopep8
	autocmd FileType rust AutoFormatBuffer rustfmt
	autocmd FileType vue AutoFormatBuffer prettier
augroup END

function! CleanLeadingIndent(indent, numtabs)
	if a:numtabs == -1
		" Replace with as many tabs as possible
		let spaces = repeat(' ', &tabstop)
		let result = substitute(a:indent, spaces, '\t', 'g')
	else
		" Replace up to specified number of tabs
		let spaces = repeat(' ', &tabstop * a:numtabs)
		let tabs   = repeat('\t', a:numtabs)
		let result = substitute(a:indent, spaces, tabs, '')
	endif
	return result
endfunction

function! CleanIndent(line1, line2, align)
	if a:align
		" Count number of tabs on previous line
		let prevline = a:line1 - 1
		let tabtokens = map(split(getline(prevline), '\t', 1), {key, val -> strlen(val) == 0})
		let numtabs = index(tabtokens, 0)
		if numtabs == -1
			let numtabs = len(tabtokens) - 1
		endif
	else
		let numtabs = -1
	endif

	" Save current position
	let savepos = getpos('.')

	" Change all tabs to spaces
	let etcurr = &et
	set et
	execute a:line1 . ',' . a:line2 . 'retab'

	" Removing trailing whitespace
	execute a:line1 . ',' . a:line2 . 's/\s\+$//e'
	call histdel('search', -1)

	" Restore expandtab status
	if etcurr == 1
		call setpos('.', savepos)
		return
	endif
	set noet

	" Change leading indentation to tabs/spaces
	execute a:line1 . ',' . a:line2 . 's/^\s\+/\=CleanLeadingIndent(submatch(0),' . numtabs . ')/e'
	call histdel('search', -1)
	call setpos('.', savepos)
endfunction

command! -range Retab call CleanIndent(<line1>,<line2>,0)
command! -range RetabAlign call CleanIndent(<line1>,<line2>,1)
noremap <silent> <Leader>t :Retab<CR>
noremap <silent> <Leader>a :RetabAlign<CR>

" Text wrapping
set textwidth=80    " Set wrapping width
set fo+=t           " Automatically wrap long lines
set fo+=l           " Avoid wrapping long lines with text appended
let &colorcolumn=join(range(100,320),",")   " Display margin
" set nowrap          " Display long lines as one line
set nojoinspaces    " Use single spaces between sentences

" Display special characters
set list
set listchars=tab:¦\ ,trail:·,extends:),precedes:(

" Search behavior
set hlsearch                " Highlight all search pattern matches
set incsearch               " Start searching immediately
set ignorecase smartcase    " Case sensitive only for uppercase
set gdefault                " Substitute globally
" Perl regex search
nnoremap <Leader>s :perldo s/
" Very magic search
nnoremap / /\v
vnoremap / /\v

" Line endings
set ffs=unix,dos    " First use unix, then dos line endings
" Use dos line endings
nnoremap <Leader>ld :setl ff=dos
" Use unix line endings
nnoremap <Leader>lu :setl ff=unix
" Reopen with dos line endings
nnoremap <Leader>ed :e ++ff=dos

" Autocomplete commands. 1st tab completes longest common substring, 2nd cycles through options
set wildmenu wildmode=list:longest,full
set backspace=indent,eol,start  " Delete over line breaks
set scrolloff=4                 " Begin scrolling window before the edge
set cursorline                  " Highlight current line
set ruler                       " Display ruler in status line
set laststatus=2                " Always display status line
set foldcolumn=0                " Display folds in left column
set relativenumber number       " Display relative line numbers
set wildignorecase              " Ignore case in file autocompletion

" Remember session info
"   '10   : remember marks for 10 previous files
"   \"100 : save 100 lines for each register
"   :20   : remember 20 lines of command line history
"   %     : save and restore buffer list
"   n     : location to save .viminfo file
set viminfo='10,\"100,:20,%,n~/.vim/.viminfo

" Restore cursor position
function! ResCur()
	if line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction

augroup resCur
	autocmd!
	autocmd BufWinEnter * call ResCur()
augroup END

" Restore fold states
au BufWinLeave ?* if &foldmethod != "syntax" | mkview | endif
au BufWinEnter ?* if &foldmethod != "syntax" | silent loadview | endif

" System copy and paste
function! Getclip()
	let reg_save = @@
	let @@ = join(readfile('/dev/clipboard'), "\n")
	setlocal paste
	exe 'normal p'
	setlocal nopaste
	let @@ = reg_save
endfunction

function! Putclip(type, ...) range
	let sel_save = &selection
	let &selection = "inclusive"
	let reg_save = @@
	if a:type == 'n'
		silent exe a:firstline . "," . a:lastline . "y"
	elseif a:type == 'c'
		silent exe a:1 . "," . a:2 . "y"
	else
		silent exe "normal! `<" . a:type . "`>y"
	endif
	call writefile(split(@@,"\n"), '/dev/clipboard')
	let &selection = sel_save
	let @@ = reg_save
endfunction

if s:uname == "CYGWIN_NT-6.1\n"
	nnoremap <silent> <Leader>p :call Getclip()<CR>
	vnoremap <silent> <Leader>y :call Putclip(visualmode(), 1)<CR>
	nnoremap <silent> <Leader>y :call Putclip('n', 1)<CR>
else
	noremap <Leader>p "*p
	noremap <Leader>y "*y
	nnoremap <silent> <Leader>v :set invpaste paste?<CR>
endif

" Command line shortcuts

" cd to current directory
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>
" Show register buffer
nnoremap <silent> <Leader>r :reg<CR>
" Save
nnoremap <silent> <Leader>w :w<CR>
" Quit
nnoremap <silent> <Leader>q :q<CR>
" Clear search highlighting
nnoremap <silent> <Leader><Bslash> :noh<CR>
" Reload current file
nnoremap <silent> <Leader>l :e<CR>
" Go to next and previous file in buffer
nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> <S-Tab> :bp<CR>
" Go back up to last file
" nnoremap <Leader>g :e#<CR>
" Close current buffer while keeping split
nnoremap <silent> <Leader>q :bp\|bd #<CR>
" Close buffer in split above
nnoremap <silent> <Leader>c <C-w>k :bd<CR>
" Display tag
" nnoremap <Leader>? :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>
nnoremap <Leader>? :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Normal mode shortcuts

" Redo
nnoremap U <C-r>
" Copy rest of line
nnoremap Y y$
" Insert new line
nnoremap <CR> o<Esc>
" Insert space
nnoremap <Space> i<Space><Esc>l
" Insert tab
nnoremap <Leader><Tab> i<Tab><Esc>l
" Decrement and increment integer with <Alt> key
if s:uname == "CYGWIN_NT-6.1\n"
	nnoremap a <C-a>
	nnoremap x <C-x>
elseif s:uname == "Darwin\n"
	nnoremap å <C-a>
	nnoremap ≈ <C-a>
endif
" Select whatever was just inserted
nnoremap gv `[v`]

" Normal and visual mode shortcuts

" Navigate window splits
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
" Go to beginning and end of line
noremap H ^
noremap L $
" Switch register and mark keys
noremap - "

" Avoid common typos
noremap <F1> <Esc>
command WQ wq
command Wq wq
command W w
command Q q

" gdb
nnoremap <Leader>dl :packadd termdebug<CR>:Termdebug<CR>
nnoremap <Leader>dr :Run<CR>
nnoremap <Leader>db :Break<CR>
nnoremap <Leader>dd :Clear<CR>
nnoremap <Leader>ds :Step<CR>
nnoremap <Leader>dn :Over<CR>
nnoremap <Leader>dc :Continue<CR>
nnoremap <Leader>ds :Stop<CR>

" Fzf
nnoremap <C-p> :FZF<CR>
nnoremap <Leader>f :GFiles<CR>
nnoremap <Leader>b :Buffers<CR>

" codefmt
nnoremap <Leader>= :FormatCode<CR>
vnoremap <Leader>= :FormatLines<CR>
if glaive_exists
	Glaive codefmt clang_format_style='Google'
endif
" Glaive codefmt yapf_executable='yapf --style="{based_on_style: google}"'

" Ale
nnoremap <Leader>l :ALELint<CR>
" nnoremap <silent> <Leader>e :Error<CR>
" let g:syntastic_python_checkers = ['pylint']
" let g:syntastic_javascript_checkers = ['jshint']
" let g:syntastic_check_on_open = 0
" let g:syntastic_error_symbol = '●'
" let g:syntastic_warning_symbol = '>'
" let g:syntastic_style_error_symbol = '~'
" let g:syntastic_style_warning_symbol = '-'
" let g:syntastic_loc_list_height = 5
" let g:syntastic_auto_jump = 1
" let g:syntastic_stl_format = '[%E{Errors: %e (line %fe)}%B{, }%W{Warnings: #%w (line %fw)}]'
" let g:syntastic_mode_map = { 'mode': 'passive',
"                            \ 'passive_filetypes': ['python'] }
let g:ale_lint_on_enter = 0               " Lint on file open
let g:ale_lint_on_save = 0                " Lint on file save
let g:ale_lint_on_text_changed = 'never'  " Lint on text change
let g:ale_python_pylint_options = '--rcfile=~/dotfiles/.pylintrc'
let g:ale_linters = {'cpp': ['clangtidy']}
let g:ale_cpp_clangtidy_checks = ['bugprone-*', 'cppcoreguidelines-*', 'clang-analyzer-*', 'google-*', 'misc-*', 'modernize-*', 'performance-*', 'portability-*', 'readability-*',
                                  \ '-cppcoreguidelines-non-private-member-variables-in-classes',
                                  \ '-cppcoreguidelines-pro-bounds-array-to-pointer-decay',
                                  \ '-cppcoreguidelines-pro-type-vararg',
                                  \ '-misc-non-private-member-variables-in-classes',
                                  \ '-modernize-pass-by-value',
                                  \ '-modernize-use-nodiscard',
                                  \ '-modernize-use-trailing-return-type',
                                  \ '-readability-braces-around-statements',
                                  \ ]
" cppcoreguidelines-pro-bounds-array-to-pointer-decay: prevent assert() warnings
" let g:ale_pattern_options = {'\v\.(c|cc|cpp|h|hh|hpp)$': {'ale_lint_on_save': 0}}
" let g:ale_pattern_options_enabled = 1
" let g:ale_sign_error = '>'
" let g:ale_sign_warning = '-'

" YouCompleteMe
nnoremap <Leader>Y :YcmCompleter
nnoremap <silent> <Leader>g :YcmCompleter GoTo<CR>
" nnoremap <silent> <Leader>d :YcmCompleter GetDoc<CR>
" let g:ycm_key_detailed_diagnostics = '<Leader>e'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
" let g:ycm_filetype_blacklist = { 'cpp': 1 }
" let g:ycm_python_binary_path = '/usr/local/bin/python3'

" DelimitMate
" let g:delimitMate_expand_cr = 1
" let g:delimitMate_expand_space = 0
" let g:AutoPairsFlyMode = 1
let g:AutoPairsMultilineClose = 0

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDRemoveExtraSpaces = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDAltDelims_haskell = 1
let g:NERDCustomDelimiters = {'python': {'left': '#', 'leftAlt': '"""', 'rightAlt': '"""'}}

" NERDTree
nnoremap <silent> <Leader>o :NERDTree<CR>
let g:NERDTreeShowLineNumbers = 1
autocmd FileType nerdtree setlocal relativenumber

" Minimap
" nnoremap <silent> <Leader>mm :Minimap<CR>
" nnoremap <silent> <Leader>mc :MinimapClose<CR>

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-l>"

" LaTeX-Box
nnoremap <Leader>lc :LatexmkClean<CR>
" let g:LatexBox_latexmk_options = "-pdflatex=lualatex"
let g:LatexBox_latexmk_options = "-shell-escape"
let g:LatexBox_latexmk_async = 0

" Airline
if s:uname == "Darwin\n" || s:uname == "Linux\n"
	let g:airline_left_sep = ""
	let g:airline_right_sep = ""
else
	let g:airline_powerline_fonts = 1
endif
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ycm#enabled = 1
let g:bufferline_echo = 0


let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
if g:airline_theme == 'dark'
  let s:N1 = [ '#000000' , '#e6eb74' , 232 , 144 ] " mode
  let s:N2 = [ '#f7f1ff' , '#404040' , 253 , 16 ] " info
  let s:N3 = [ '#f7f1ff' , '#1c1c1c' , 253 , 67  ] " statusline
  let a:palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
  let a:palette.normal_modified = {
      \ 'airline_c': [ '#ffffff' , '#543a83' , 232 , 144 , '' ] ,
      \ }

  let s:I1 = [ '#000000' , '#66d9ef' , 232 , 81  ]
  let s:I2 = [ '#66d9ef' , '#404040' , 253 , 16 ]
  let s:I3 = [ '#66d9ef' , '#1c1c1c' , 253 , 67  ]
  let a:palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
  let a:palette.insert_modified = {
      \ 'airline_c': [ '#ffffff' , '#543a83' , 232 , 144 , '' ] ,
      \ }

  let s:R1 = [ '#000000' , '#fc618d' , 232 , 161 ]
  let s:R2 = [ '#f92672' , '#404040' , 253 , 16 ]
  let s:R3 = [ '#f92672' , '#1c1c1c' , 253 , 67  ]
  let a:palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
  let a:palette.replace_modified = {
      \ 'airline_c': [ '#ffffff' , '#543a83' , 232 , 144 , '' ] ,
      \ }

  let s:V1 = [ '#000000' , '#a6e22e' , 232 , 118 ]
  let s:V2 = [ '#a6e22e' , '#404040' , 253 , 16 ]
  let s:V3 = [ '#a6e22e' , '#1c1c1c' , 253 , 67  ]
  let a:palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
  let a:palette.visual_modified = {
      \ 'airline_c': [ '#ffffff' , '#543a83' , 232 , 144 , '' ] ,
      \ }

  let s:IA1 = [ '#000000' , '#404040' , 232 , 118 ]
  let s:IA2 = [ '#808080' , '#1c1c1c' , 253 , 16 ]
  let s:IA3 = [ '#808080' , '#080808' , 253 , 67  ]
  let a:palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)
  let a:palette.inactive_modified = {
      \ 'airline_c': [ '#ae81ff' , '#080808' , 232 , 144 , '' ] ,
      \ }
endif
endfunction
