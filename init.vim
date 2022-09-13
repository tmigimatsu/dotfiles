""""""""""""
" Settings "
""""""""""""

set tabstop=4     " Tab width.
set shiftwidth=4  " Shift width.
set expandtab     " Expand tab to spaces.
set nojoinspaces  " Use single spaces between sentences.

set mouse=a                " Mouse support for all modes.
set termguicolors          " True colors.
set cursorline             " Highlight current line.
set relativenumber number  " Display relative line numbers.
set textwidth=80           " Set wrapping width.
let &colorcolumn=join(range(100,320),",")   " Display margin.
set list                   " Display whitespace.
set listchars=tab:¦\ ,trail:·,nbsp:+,extends:),precedes:(
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"  " Foreground true color.
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"  " Background true color.
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
" Yank to clipboard.
vnoremap <silent> <Leader>y :OSCYank<CR>

nnoremap <Leader>e :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap [e :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap ]e :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap K :lua vim.lsp.buf.hover()<CR>
nnoremap <Leader>s :lua vim.lsp.buf.signature_help()<CR>
nnoremap <Leader>S :lua vim.lsp.buf.document_symbol()<CR>
nnoremap gd :lua vim.lsp.buf.definition()<CR>
nnoremap gi :lua vim.lsp.buf.implementation()<CR>
nnoremap gD :lua vim.lsp.buf.declaration()<CR>
nnoremap <Leader>D :lua vim.lsp.buf.type_definition()<CR>
nnoremap <Leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap gr :lua vim.lsp.buf.references()<CR>
nnoremap <Leader>f :lua vim.lsp.buf.formatting()<CR>
vnoremap <Leader>f :lua vim.lsp.buf.range_formatting()<CR>
" Go to entry in references list.
nnoremap g<CR> <CR>

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

"""""""""""""
" Filetypes "
"""""""""""""
autocmd FileType c,cpp,javascript,yaml setlocal tabstop=2 shiftwidth=2
autocmd FileType html,javascript,pddl setlocal noexpandtab

"""""""""""
" Plugins "
"""""""""""

" Automatically install Plug.
let plug_dir = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(plug_dir))
  silent execute '!curl -fLo ' . plug_dir . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Automatically install LSP servers.
function InstallLspServers()
    execute '!npm install -g '
        \ . 'bash-language-server '
        \ . 'vscode-langservers-extracted '
        \ . 'typescript typescript-language-server '
        \ . 'vim-language-server '
        \ . 'yaml-language-server '
        \ . 'prettier '
    execute '!pipx install cmake-language-server'
    execute '!pipx install python-lsp-server && pipx inject python-lsp-server '
        \ . 'python-lsp-black '
        \ . 'pyls-flake8 '
        \ . 'pylsp-mypy '
        \ . 'pylint '
    execute '!ln -s ~/.local/pipx/venvs/python-lsp-server/bin/flake8 ~/.local/bin'
    let uname = system('uname')
    if uname == 'Darwin'
        execute '!brew install efm-langserver'
    else
        execute '!go install github.com/mattn/efm-langserver@latest'
    endif
    " sudo apt install clangd-13 clang-format-13 clang-tidy-13
endfunction

" Plug.
call plug#begin(stdpath('data') . '/plugged')
    Plug 'airblade/vim-gitgutter'    " Git gutter.
    Plug 'hrsh7th/cmp-nvim-lsp'      " LSP plugin for auto-completion.
    Plug 'hrsh7th/nvim-cmp'          " Auto-completion.
    Plug 'joshdick/onedark.vim'      " One Dark colorscheme.
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Fuzzy finder.
    Plug 'junegunn/fzf.vim'          " Vim extras for fuzzy finder.
    Plug 'kyazdani42/nvim-tree.lua', { 'on': 'NvimTreeToggle' }  " File explorer.
    " Plug 'kyazdani42/nvim-web-devicons'  " File icons.
    Plug 'kylechui/nvim-surround'    " Surround characters.
    Plug 'ojroques/vim-oscyank'      " Yank to local clipboard.
    Plug 'neovim/nvim-lspconfig', { 'do': { -> InstallLspServers() } }  " Automatically launch language servers.
    Plug 'nvim-treesitter/nvim-treesitter', { 'branch': '0.5-compat', 'do': ':TSUpdate' }  " LSP syntax highlighting.
    Plug 'numToStr/Comment.nvim'     " Comment code.
    Plug 'tmigimatsu/barbar.nvim'    " Reorderable tabs.
    " Plug 'scrooloose/nerdtree', { 'on': 'NERDTree' }  " File explorer.
    " Plug 'tpope/vim-surround'        " Surround characters.
    Plug 'tpope/vim-fugitive'        " Git integration.
    Plug 'tpope/vim-sleuth'          " Preserve file tab settings.
    Plug 'vim-airline/vim-airline'   " Status line.
call plug#end()

" Barbar.
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

" FZF.
nnoremap <C-p> :FZF<CR>
nnoremap <silent> <Leader>g :GFiles<CR>
nnoremap <silent> <Leader>b :Buffers<CR>

" NERDTree.
nnoremap <silent> <Leader>o :NvimTreeToggle<CR>
" nnoremap <silent> <Leader>o :NERDTree<CR>
" let g:NERDTreeShowLineNumbers = 1  " Show line numbers.
" autocmd FileType nerdtree setlocal relativenumber

" One Dark.
let g:onedark_terminal_italics = 1
" white/foreground: #abb2bf, comment_grey: #5c6370;59
let g:onedark_color_overrides = {
    \ "comment_grey": {"gui": "#707884", "cterm": "244", "cterm16": "7" },
\}
    "foreground": {"gui": "#b1bac7", "cterm": "145", "cterm16": "15" },
    "white": {"gui": "#b1bac7", "cterm": "145", "cterm16": "15" },

augroup colorset
    autocmd!
    let s:colors = onedark#GetColors()
    let s:black = s:colors.black
    let s:blue = s:colors.blue
    let s:cyan = s:colors.cyan
    let s:dark_red = s:colors.dark_red
    let s:dark_yellow = s:colors.dark_yellow
    let s:green = s:colors.green
    let s:purple = s:colors.purple
    let s:red = s:colors.red
    let s:yellow = s:colors.yellow
    let s:white = s:colors.white
    let s:foreground = s:colors.foreground
    let s:background = s:colors.background
    let s:comment_grey = s:colors.comment_grey
    let s:cursor_grey = s:colors.cursor_grey
    " Barbar colors.
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
    " LSP signature colors.
    autocmd ColorScheme * call onedark#set_highlight("NormalFloat", { "fg": s:foreground, "bg": s:background })
    autocmd ColorScheme * call onedark#set_highlight("FloatBorder", { "fg": s:comment_grey, "bg": s:background })
    " nvim-tree colors.
    autocmd ColorScheme * call onedark#set_highlight("NvimTreeSymlink", { "fg": s:cyan })
    autocmd ColorScheme * call onedark#set_highlight("NvimTreeFolderIcon", { "fg": s:blue })
    autocmd ColorScheme * call onedark#set_highlight("NvimTreeFolderName", { "fg": s:blue })
    autocmd ColorScheme * call onedark#set_highlight("NvimTreeOpenedFolderName", { "fg": s:blue })
    autocmd ColorScheme * call onedark#set_highlight("NvimTreeExecFile", { "fg": s:green })
    autocmd ColorScheme * call onedark#set_highlight("NvimTreeGitDeleted", { "fg": s:red, "gui": "bold" })
    autocmd ColorScheme * call onedark#set_highlight("NvimTreeGitDirty", { "fg": s:purple, "gui": "bold" })
    autocmd ColorScheme * call onedark#set_highlight("NvimTreeGitIgnored", { "fg": s:comment_grey })
    autocmd ColorScheme * call onedark#set_highlight("NvimTreeGitMerge", { "fg": s:red, "gui": "bold" })
    autocmd ColorScheme * call onedark#set_highlight("NvimTreeGitNew", { "fg": s:yellow, "gui": "bold" })
    autocmd ColorScheme * call onedark#set_highlight("NvimTreeGitRenamed", { "fg": s:purple, "gui": "bold" })
    autocmd ColorScheme * call onedark#set_highlight("NvimTreeGitStaged", { "fg": s:green, "gui": "bold" })
augroup END
augroup colorextend
    autocmd!
    let s:colors = onedark#GetColors()
    let s:comment_grey = s:colors.comment_grey
    " Make line numbers more visible.
    autocmd ColorScheme * call onedark#extend_highlight("LineNr", { "fg": s:comment_grey })
augroup END

colorscheme onedark
"colorscheme molokai

"""""""
" Lua "
"""""""

lua << EOF
require("Comment").setup()

-- NeoVim LSP.
-- https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp.lua
local lspconfig = require("lspconfig")

-- Disable LSP diagnostics in insert mode.
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { update_in_insert = false }
)

-- Add LSP completion capabilities via cmp-nvim-lsp.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local servers = {
    "bashls",    -- npm install -g bash-language-server
    "cmake",     -- pip install cmake-language-server
    "cssls",     -- npm install -g vscode-langservers-extracted
    "html",      -- npm install -g vscode-langservers-extracted
    "jsonls",    -- npm install -g vscode-langservers-extracted
    "tsserver",  -- npm install -g typescript typescript-language-server
    "vimls",     -- npm install -g vim-language-server
    "yamlls",    -- npm install -g yaml-language-server
}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
    }
end
lspconfig.pylsp.setup {
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        flake8 = {
          maxLineLength = 160,
        },
        pylint = { enabled = false },
      },
    },
  },
}
lspconfig.clangd.setup {
  capabilities = capabilities,
  cmd = { "clangd", "--background-index", "--clang-tidy", "--fallback-style=google" },
}

-- Add extra LSP servers via efm.
-- go install github.com/mattn/efm-langserver@latest
-- brew install efm-langserver
-- https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lsp/init.lua
local prettierCss = {  -- npm install -g prettier
    formatCommand = "prettier ${--tab-width:tabWidth} ${--single-quote:singleQuote} --parser css",
    formatStdin = true,
}
local prettierHtml = {  -- npm install -g prettier
    formatCommand = "prettier ${--tab-width:tabWidth} ${--single-quote:singleQuote} --use-tabs=true --parser html",
    formatStdin = true,
}
local prettierJson = {  -- npm install -g prettier
    formatCommand = "prettier ${--tab-width:tabWidth} --parser json",
    formatStdin = true,
}
local prettierMarkdown = {  -- npm install -g prettier
    formatCommand = "prettier ${--tab-width:tabWidth} --parser markdown",
    formatStdin = true,
}
local prettierToml = {  -- npm install -g prettier prettier-plugin-toml --save-dev --save-exact
    formatCommand = "prettier --parser toml ${--tab-width:tabWidth} --stdin-filepath=${INPUT}",
    formatStdin = true,
}
local prettierXml = {  -- npm install -g prettier
    formatCommand = "prettier --parser xml ${--tab-width:tabWidth} --print-width=160 --stdin-filepath=${INPUT}",
    formatStdin = true,
}
local prettierYaml = {  -- npm install -g prettier
    formatCommand = "prettier ${--tab-width:tabWidth} --parser yaml",
    formatStdin = true,
}
lspconfig.efm.setup {
    init_options = { documentFormatting = true },
    root_dir = vim.loop.cwd,
    settings = {
        rootMarkers = { ".git/" },
        languages = {
            css = { prettierCss },
            html = { prettierHtml },
            json = { prettierJson },
            markdown = { prettierMarkdown },
            toml = { prettierToml },
            xml = { prettierXml },
            yaml = { prettierYaml },
        },
    },
    filetypes = { "css", "html", "json", "markdown", "toml", "xml", "yaml" },
}

-- nvim-cmp.
local cmp = require("cmp")
cmp.setup {
    mapping = {
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-CR>"] = cmp.mapping.confirm {
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

-- nvim-surround
require("nvim-surround").setup {
    delimiters = {
        pairs = {
            ["("] = {"(", ")" },
            ["{"] = {"{", "}" },
            ["<"] = {"<", ">" },
            ["["] = {"[", "]" },
        },
    },
}

-- nvim-tree
require("nvim-tree").setup {
    git = {
        ignore = false,
    },
    renderer = {
        add_trailing = true,
        highlight_git = true,
        -- highlight_opened_files = "all",
        icons = {
            git_placement = "after",
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_closed = "▸",
                    arrow_open = "▾",
                    default = "▸",
                    open = "▾",
                    empty = "▸",
                    empty_open = "▾",
                    symlink = "▸",
                    symlink_open = "▾",
                },
                git = {
                    unstaged = "*",
                    staged = "✓",
                    unmerged = "?",
                    renamed = "➜",
                    untracked = "*",
                    deleted = "✗",
                    ignored = "",
                },
            },
            show = {
                file = true,
                folder = true,
                folder_arrow = false,
            },
            symlink_arrow = " ➛ ",
            webdev_colors = false,
        },
        -- indent_markers = {
        --     enable = true,
        -- },
        special_files = {},
        symlink_destination = true,
    },
    view = {
        number = true,
        relativenumber = true,
        signcolumn = "no",
        -- preserve_window_proportions = true,
    },
}

-- NVim Treesitter.
require("nvim-treesitter.configs").setup {
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
