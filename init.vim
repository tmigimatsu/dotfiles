""""""""""""
" Settings "
""""""""""""

set tabstop=4     " Tab width.
set shiftwidth=4  " Shift width.
set expandtab     " Expand tab to spaces.
set nojoinspaces  " Use single spaces between sentences.

set mouse=a                " Mouse support for all modes.
set cursorline             " Highlight current line
set relativenumber number  " Display relative line numbers.
set textwidth=80           " Set wrapping width
let &colorcolumn=join(range(100,320),",")   " Display margin
set listchars=tab:¦\ ,trail:·,nbsp:+,extends:),precedes:(
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"  " Bold on.
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"  " Bold off.
set t_ZH=[3m   " Italics on.
set t_ZR=[23m  " Italics off.

" 1st tab lists all matches/completes longest common string, 2nd cycles through options
set wildmenu wildmode=list:longest,full
set wildignorecase        " Ignore case in autocompletion.
set ignorecase smartcase  " Case sensitive only for uppercase.
set gdefault              " Substitute globally.

" Shared data file.
" !    : Save global variables.
" '100 : Remember marks for last 100 files.
" <50  : Remember registers up to 100 lines each.
" s10  : Skip items with contents more than 10KiB.
" h    : Do not restore 'hlsearch' highlighting.
" %    : Save buffer list.
set shada=!,'100,<50,s10,h,%
set undofile  " Save undo history across sessions.

"""""""""""""
" Shortcuts "
"""""""""""""

" Very magic search.
nnoremap / /\v
vnoremap / /\v

" Switch register and mark keys
noremap - "

" Navigate window wplits.
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

" Go to beginning and end of line.
noremap H ^
noremap L $
" Redo.
nnoremap U <C-r>
" Copy rest of line.
nnoremap Y y$
" Insert new line.
nnoremap <CR> o<Esc>
" Insert space.
nnoremap <Space> i<Space><Esc>l
" Select whatever was just inserted
nnoremap gv `[v`]

" Increment and decrement integer with <Alt> key.
nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>
" MacOS version.
nnoremap å <C-a>
nnoremap ≈ <C-x>

" Close current buffer while keeping split..
nnoremap <silent> <Leader>q :BufferPrevious<CR>:bd #<CR>
" Save.
nnoremap <silent> <Leader>w :w<CR>
" Clear search highlighting.
nnoremap <silent> <Leader><Bslash> :noh<CR>
" cd to current directory.
nnoremap <silent> <Leader>cd :cd %:p:h<CR>:pwd<CR>

nnoremap <Leader>e :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap [e :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap ]e :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap K :lua vim.lsp.buf.hover()<CR>
nnoremap <C-k> :lua vim.lsp.buf.signature_help()<CR>
nnoremap <C-]> :lua vim.lsp.buf.definition()<CR>
nnoremap gd :lua vim.lsp.buf.definition()<CR>
nnoremap gi :lua vim.lsp.buf.implementation()<CR>
nnoremap gD :lua vim.lsp.buf.declaration()<CR>
nnoremap <Leader>D :lua vim.lsp.buf.type_definition()<CR>
nnoremap <Leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap gr :lua vim.lsp.buf.references()<CR>
nnoremap <Leader>= :lua vim.lsp.buf.formatting()<CR>
vnoremap <Leader>= :lua vim.lsp.buf.range_formatting()<CR>

"""""""""""""
" Filetypes "
"""""""""""""
autocmd FileType c,cpp,javascript,yaml setlocal tabstop=2 shiftwidth=2
autocmd FileType pddl setlocal noexpandtab

"""""""""""
" Plugins "
"""""""""""

" Automatically install Plug.
let plug_dir = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(plug_dir))
  silent execute '!curl -fLo ' . plug_dir . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function InstallLspServers()
    execute '!npm install -g --prefix=~/.local '
        \ . 'bash-language-server '
        \ . 'vscode-langservers-extracted '
        \ . 'pyright '
        \ . 'typescript typescript-language-server '
        \ . 'vim-language-server '
        \ . 'yaml-language-server '
        \ . 'prettier '
    execute '!pip install '
        \ . 'cmake-language-server '
        \ . 'black '
        \ . 'mypy '
        \ . 'flake8 '
    let uname = system('uname')
    if uname == 'Darwin'
        execute '!brew install efm-langserver'
    else
        execute '!go install github.com/mattn/efm-langserver@latest'
    endif
endfunction
call plug#begin(stdpath('data') . '/plugged')
    Plug 'airblade/vim-gitgutter'    " Git gutter.
    Plug 'hrsh7th/cmp-nvim-lsp'      " LSP plugin for auto-completion.
    Plug 'hrsh7th/nvim-cmp'          " Auto-completion.
    Plug 'joshdick/onedark.vim'      " One Dark colorscheme.
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Fuzzy finder.
    Plug 'junegunn/fzf.vim'          " Vim extras for fuzzy finder.
    Plug 'neovim/nvim-lspconfig', { 'do': { -> InstallLspServers() } }  " Automatically launch language servers.
    Plug 'nvim-treesitter/nvim-treesitter', { 'branch': '0.5-compat', 'do': ':TSUpdate' }  " LSP syntax highlighting.
    Plug 'tmigimatsu/barbar.nvim'    " Reorderable tabs.
    Plug 'scrooloose/nerdcommenter'  " Comment code.
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTree' }  " File explorer.
    Plug 'tpope/vim-surround'        " Surround characters.
    Plug 'tpope/vim-fugitive'        " Git integration.
    Plug 'tpope/vim-sleuth'          " Preserve file tab settings.
    Plug 'vim-airline/vim-airline'   " Status line.
call plug#end()

" Airline
"let g:airline#extensions#tabline#enabled = 1  " Buffer line.

" Barbar
let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:false
let bufferline.icons = v:false
let bufferline.icon_close_tab = '⨯'
let bufferline.icon_separator_active = ''
let bufferline.icon_separator_inactive = ''

" Go to next and previous file in buffer.
nnoremap <silent> <Tab> :BufferNext<CR>
nnoremap <silent> <S-Tab> :BufferPrevious<CR>
" Move buffer tab.
nnoremap <silent> <A-l> :BufferMoveNext<CR>
nnoremap <silent> <A-h> :BufferMovePrevious<CR>
" MacOS version.
nnoremap <silent> ¬ :BufferMoveNext<CR>
nnoremap <silent> ˙ :BufferMovePrevious<CR>

" FZF
nnoremap <C-p> :FZF<CR>
nnoremap <silent> <C-f> :GFiles<CR>
nnoremap <silent> <C-b> :Buffers<CR>

" NERDTree
nnoremap <silent> <C-o> :NERDTree<CR>
let g:NERDTreeShowLineNumbers = 1  " Show line numbers.
autocmd FileType nerdtree setlocal relativenumber

" One Dark
let g:onedark_terminal_italics = 1
let g:onedark_color_overrides = {
    \ "comment_grey": {"gui": "#5c6370", "cterm": "244", "cterm16": "7" },
\}

augroup colorset
    autocmd!
    let s:colors = onedark#GetColors()
    let s:blue = s:colors.blue
    let s:green = s:colors.green
    let s:black = s:colors.black
    let s:foreground = s:colors.foreground
    let s:background = s:colors.background
    let s:cursor_grey = s:colors.cursor_grey
    autocmd ColorScheme * call onedark#set_highlight("BufferCurrent", { "fg": s:black, "bg": s:green })
    autocmd ColorScheme * call onedark#set_highlight("BufferCurrentMod", { "fg": s:black, "bg": s:blue })
    autocmd ColorScheme * call onedark#set_highlight("BufferCurrentIndex", { "fg": s:black, "bg": s:green })
    autocmd ColorScheme * call onedark#set_highlight("BufferCurrentLetter", { "fg": s:black, "bg": s:green })
    autocmd ColorScheme * call onedark#set_highlight("BufferVisible", { "fg": s:green, "bg": s:background })
    autocmd ColorScheme * call onedark#set_highlight("BufferVisibleMod", { "fg": s:blue, "bg": s:background })
    autocmd ColorScheme * call onedark#set_highlight("BufferVisibleIndex", { "fg": s:green, "bg": s:background })
    autocmd ColorScheme * call onedark#set_highlight("BufferVisibleLetter", { "fg": s:green, "bg": s:background })
    autocmd ColorScheme * call onedark#set_highlight("BufferInactive", { "fg": s:green, "bg": s:background })
    autocmd ColorScheme * call onedark#set_highlight("BufferInactiveMod", { "fg": s:blue, "bg": s:background })
    autocmd ColorScheme * call onedark#set_highlight("BufferInactiveIndex", { "fg": s:green, "bg": s:background })
    autocmd ColorScheme * call onedark#set_highlight("BufferInactiveLetter", { "fg": s:green, "bg": s:background })
    autocmd ColorScheme * call onedark#set_highlight("BufferTabpageFill", { "fg": s:foreground, "bg": s:cursor_grey })
augroup END
augroup colorextend
    autocmd!
    let s:colors = onedark#GetColors()
    let s:comment_grey = s:colors.comment_grey
    autocmd ColorScheme * call onedark#extend_highlight("LineNr", { "fg": s:comment_grey })
augroup END

colorscheme onedark

"""""""
" Lua "
"""""""

lua << EOF
-- NeoVim LSP.
-- https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp.lua
local lspconfig = require("lspconfig")

-- Add LSP completion capabilities via cmp-nvim-lsp.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local servers = {
    "bashls",    -- sudo npm install -g bash-language-server
    "clangd",
    "cmake",     -- pip install cmake-language-server
    "cssls",     -- sudo npm install -g vscode-langservers-extracted
    "html",      -- sudo npm install -g vscode-langservers-extracted
    "jsonls",    -- sudo npm install -g vscode-langservers-extracted
    "pyright",   -- sudo npm install -g pyright
    "tsserver",  -- sudo npm install -g typescript typescript-language-server
    "vimls",     -- sudo npm install -g vim-language-server
    "yamlls",    -- sudo npm install -g yaml-language-server
}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
    }
end

-- Add extra LSP servers via efm.
-- go install github.com/mattn/efm-langserver@latest
-- brew install efm-langserver
-- https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lsp/init.lua
local black = {  -- pip install black
    formatCommand = "black --fast -",
    formatStdin = true,
}
local clangformat = {
    formatCommand = "clang-format -style=google -",
    formatStdin = true,
}
local mypy = {  -- pip install mypy
    lintCommand = "mypy --show-column-numbers --ignore-missing-imports",
    lintFormats = {
        "%f:%l:%c: %trror: %m",
        "%f:%l:%c: %tarning: %m",
        "%f:%l:%c: %tote: %m",
    },
    lintSource = "mypy",
}
local flake8 = {  -- pip install flake8
    lintCommand = "flake8 --max-line-length 160 --format '%(path)s:%(row)d:%(col)d: %(code)s %(code)s %(text)s' --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintIgnoreExitCode = true,
    lintFormats = { "%f:%l:%c: %t%n%n%n %m" },
    lintSource = "flake8",
}
local prettier = {  -- sudo npm install -g prettier
    formatCommand = ([[
        $([ -n "$(command -v node_modules/.bin/prettier)" ] && echo "node_modules/.bin/prettier" || echo "prettier")
        ${--config-precedence:configPrecedence}
        ${--tab-width:tabWidth}
        ${--single-quote:singleQuote}
        ${--trailing-comma:trailingComma}
    ]]):gsub("\n", ""),
}
lspconfig.efm.setup {
    init_options = { documentFormatting = true },
    root_dir = vim.loop.cwd,
    settings = {
        rootMarkers = { ".git/" },
        languages = {
            cpp = { clangformat },
            python = { black, mypy, flake8 },
            yaml = { prettier },
            json = { prettier },
            html = { prettier },
            css = { prettier },
            markdown = { prettier },
        },
    },
}

-- nvim-cmp.
local cmp = require "cmp"
cmp.setup {
    mapping = {
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end
    },
    sources = {
        { name = "nvim_lsp" }
    },
}

-- NVim Treesitter.
local treesitter = require "nvim-treesitter.configs"
treesitter.setup {
    ensure_installed = "maintained",  -- Exclude experimental parsers.
    highlight = {
        enable = true,
        -- Setting regex_highlighting to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}
EOF
