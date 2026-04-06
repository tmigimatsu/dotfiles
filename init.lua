-- ─────────────────────────────────────────────
-- Plugins (vim.pack)
-- ─────────────────────────────────────────────

-- Post-install/update hooks (must be registered before vim.pack.add).
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "fzf" and (kind == "install" or kind == "update") then
            vim.fn["fzf#install"]()
        end
        if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
            vim.cmd("TSUpdate")
        end
    end,
})

vim.pack.add({
    "https://github.com/airblade/vim-gitgutter",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/joshdick/onedark.vim",
    "https://github.com/junegunn/fzf",
    "https://github.com/junegunn/fzf.vim",
    "https://github.com/kyazdani42/nvim-tree.lua",
    "https://github.com/kylechui/nvim-surround",
    "https://github.com/ojroques/vim-oscyank",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/numToStr/Comment.nvim",
    "https://github.com/tmigimatsu/barbar.nvim",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/tpope/vim-sleuth",
    "https://github.com/vim-airline/vim-airline",
})

-- ─────────────────────────────────────────────
-- Settings
-- ─────────────────────────────────────────────

vim.opt.tabstop     = 4      -- Tab width.
vim.opt.shiftwidth  = 4      -- Shift width.
vim.opt.expandtab   = true   -- Expand tab to spaces.
vim.opt.joinspaces  = false  -- Use single spaces between sentences.

vim.opt.mouse          = "a"    -- Mouse support for all modes.
vim.opt.termguicolors  = true   -- True colors.
vim.opt.cursorline     = true   -- Highlight current line.
vim.opt.relativenumber = true   -- Display relative line numbers.
vim.opt.number         = true
vim.opt.textwidth      = 80     -- Set wrapping width.

do  -- Display margin.
    local cols = {}
    for i = 100, 320 do cols[i - 99] = i end
    vim.opt.colorcolumn = cols
end

vim.opt.list      = true    -- Display whitespace.
vim.opt.listchars = { tab = "¦ ", trail = "·", nbsp = "+", extends = ")", precedes = "(" }

-- 1st tab lists all matches/completes longest common string, 2nd cycles through options.
vim.opt.wildmenu       = true
vim.opt.wildmode       = "list:longest,full"
vim.opt.wildignorecase = true   -- Ignore case in autocompletion.
vim.opt.ignorecase     = true   -- Case sensitive only for uppercase.
vim.opt.smartcase      = true
vim.opt.gdefault       = true   -- Substitute globally.

-- Shared data file.
-- !    : Save global variables.
-- '100 : Remember marks for last 100 files.
-- <50  : Remember registers up to 100 lines each.
-- s10  : Skip items with contents more than 10KiB.
-- h    : Do not restore 'hlsearch' highlighting.
-- %    : Save buffer list.
vim.opt.shada    = "!,'100,<50,s10,h,%"
vim.opt.undofile = true  -- Save undo history across sessions.

-- ─────────────────────────────────────────────
-- Keymaps
-- ─────────────────────────────────────────────

-- Very magic search.
vim.keymap.set({ "n", "x" }, "/", "/\\v")

-- Switch register and mark keys.
vim.keymap.set({ "n", "x", "o" }, "-", '"')

-- Navigate window splits.
vim.keymap.set({ "n", "x", "o" }, "<C-h>", "<C-w>h")
vim.keymap.set({ "n", "x", "o" }, "<C-l>", "<C-w>l")
vim.keymap.set({ "n", "x", "o" }, "<C-j>", "<C-w>j")
vim.keymap.set({ "n", "x", "o" }, "<C-k>", "<C-w>k")

-- Go to beginning and end of line.
vim.keymap.set({ "n", "x", "o" }, "H", "^")
vim.keymap.set({ "n", "x", "o" }, "L", "$")
-- Redo.
vim.keymap.set("n", "U", "<C-r>")
-- Copy rest of line.
vim.keymap.set("n", "Y", "y$")
-- Insert new line.
vim.keymap.set("n", "<CR>", "o<Esc>")
-- Insert space.
vim.keymap.set("n", "<Space>", "i<Space><Esc>l")
-- Select whatever was just inserted.
vim.keymap.set("n", "gv", "`[v`]")

-- Increment and decrement integer with <Alt> key.
vim.keymap.set("n", "<A-a>", "<C-a>")
vim.keymap.set("n", "<A-x>", "<C-x>")
-- macOS version.
vim.keymap.set("n", "å", "<C-a>")
vim.keymap.set("n", "≈", "<C-x>")

-- Close current buffer while keeping split.
vim.keymap.set("n", "<Leader>q",         "<Cmd>BufferPrevious<CR><Cmd>bd #<CR>", { silent = true })
-- Save.
vim.keymap.set("n", "<Leader>w",         "<Cmd>w<CR>",                           { silent = true })
-- Clear search highlighting.
vim.keymap.set("n", "<Leader><Bslash>",  "<Cmd>noh<CR>",                         { silent = true })
-- cd to current directory.
vim.keymap.set("n", "<Leader>cd",        "<Cmd>cd %:p:h<CR><Cmd>pwd<CR>",        { silent = true })
-- Yank to clipboard.
vim.keymap.set("v", "<Leader>y",         "<Cmd>OSCYank<CR>",                     { silent = true })

-- LSP.
vim.keymap.set("n", "<Leader>e",  vim.diagnostic.open_float)
vim.keymap.set("n", "[e",         vim.diagnostic.goto_prev)
vim.keymap.set("n", "]e",         vim.diagnostic.goto_next)
vim.keymap.set("n", "K",          vim.lsp.buf.hover)
vim.keymap.set("n", "<Leader>s",  vim.lsp.buf.signature_help)
vim.keymap.set("n", "<Leader>S",  vim.lsp.buf.document_symbol)
vim.keymap.set("n", "gd",         vim.lsp.buf.definition)
vim.keymap.set("n", "gi",         vim.lsp.buf.implementation)
vim.keymap.set("n", "gD",         vim.lsp.buf.declaration)
vim.keymap.set("n", "<Leader>D",  vim.lsp.buf.type_definition)
vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "gr",         vim.lsp.buf.references)
vim.keymap.set("n", "<Leader>f",  function() vim.lsp.buf.format() end)
vim.keymap.set("v", "<Leader>f",  function()
    vim.lsp.buf.format({
        range = {
            ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
            ["end"]   = vim.api.nvim_buf_get_mark(0, ">"),
        },
    })
end)
-- Go to entry in references list.
vim.keymap.set("n", "g<CR>", "<CR>")

-- ─────────────────────────────────────────────
-- Indent helpers
-- ─────────────────────────────────────────────

local function clean_leading_indent(indent, numtabs, tabstop)
    if numtabs == -1 then
        -- Replace all leading space groups with tabs.
        local spaces = string.rep(" ", tabstop)
        return (indent:gsub(spaces, "\t"))
    else
        -- Replace up to the specified number of leading tab-widths.
        local spaces = string.rep(" ", tabstop * numtabs)
        local tabs   = string.rep("\t", numtabs)
        if indent:sub(1, #spaces) == spaces then
            return tabs .. indent:sub(#spaces + 1)
        end
        return indent
    end
end

local function clean_indent(line1, line2, align)
    local numtabs
    if align then
        -- Count leading tabs on the line before the range.
        local prevline = vim.fn.getline(line1 - 1)
        numtabs = 0
        for i = 1, #prevline do
            if prevline:sub(i, i) == "\t" then
                numtabs = numtabs + 1
            else
                break
            end
        end
    else
        numtabs = -1
    end

    local savepos = vim.fn.getpos(".")
    local et_curr = vim.bo.expandtab
    local tabstop = vim.bo.tabstop

    -- Expand all tabs to spaces.
    vim.bo.expandtab = true
    vim.cmd(line1 .. "," .. line2 .. "retab")

    -- Strip trailing whitespace.
    for lnum = line1, line2 do
        local line    = vim.fn.getline(lnum)
        local trimmed = line:gsub("%s+$", "")
        if trimmed ~= line then vim.fn.setline(lnum, trimmed) end
    end

    if et_curr then
        vim.fn.setpos(".", savepos)
        return
    end
    vim.bo.expandtab = false

    -- Convert leading spaces back to tabs.
    for lnum = line1, line2 do
        local line    = vim.fn.getline(lnum)
        local leading = line:match("^%s+")
        if leading then
            local new_indent = clean_leading_indent(leading, numtabs, tabstop)
            vim.fn.setline(lnum, new_indent .. line:sub(#leading + 1))
        end
    end

    vim.fn.setpos(".", savepos)
end

vim.api.nvim_create_user_command("Retab", function(opts)
    clean_indent(opts.line1, opts.line2, false)
end, { range = true })

vim.api.nvim_create_user_command("RetabAlign", function(opts)
    clean_indent(opts.line1, opts.line2, true)
end, { range = true })

vim.keymap.set({ "n", "x", "o" }, "<Leader>t", "<Cmd>Retab<CR>",      { silent = true })
vim.keymap.set({ "n", "x", "o" }, "<Leader>a", "<Cmd>RetabAlign<CR>", { silent = true })

-- ─────────────────────────────────────────────
-- Filetypes
-- ─────────────────────────────────────────────

local ft_group = vim.api.nvim_create_augroup("filetypes", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group    = ft_group,
    pattern  = { "c", "cpp", "javascript", "yaml" },
    callback = function()
        vim.opt_local.tabstop    = 2
        vim.opt_local.shiftwidth = 2
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    group    = ft_group,
    pattern  = { "html", "javascript", "pddl" },
    callback = function() vim.opt_local.expandtab = false end,
})

-- ─────────────────────────────────────────────
-- Barbar
-- ─────────────────────────────────────────────

vim.g.bufferline = {
    animation             = false,
    icons                 = false,
    icon_close_tab        = "⨯",
    icon_separator_active   = "",
    icon_separator_inactive = "",
}

-- Go to next/previous buffer.
vim.keymap.set("n", "<Tab>",   "<Cmd>BufferNext<CR>",         { silent = true })
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>",     { silent = true })
-- Move buffer tab.
vim.keymap.set("n", "<A-l>",   "<Cmd>BufferMoveNext<CR>",     { silent = true })
vim.keymap.set("n", "<A-h>",   "<Cmd>BufferMovePrevious<CR>", { silent = true })
-- macOS version.
vim.keymap.set("n", "¬", "<Cmd>BufferMoveNext<CR>",     { silent = true })
vim.keymap.set("n", "˙", "<Cmd>BufferMovePrevious<CR>", { silent = true })

-- ─────────────────────────────────────────────
-- FZF
-- ─────────────────────────────────────────────

vim.keymap.set("n", "<C-p>",     "<Cmd>FZF<CR>")
vim.keymap.set("n", "<Leader>g", "<Cmd>GFiles<CR>",  { silent = true })
vim.keymap.set("n", "<Leader>b", "<Cmd>Buffers<CR>", { silent = true })

-- ─────────────────────────────────────────────
-- nvim-tree
-- ─────────────────────────────────────────────

vim.keymap.set("n", "<Leader>o", "<Cmd>NvimTreeToggle<CR>", { silent = true })

require("nvim-tree").setup({
    git = { ignore = false },
    renderer = {
        add_trailing  = true,
        highlight_git = true,
        icons = {
            git_placement = "after",
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_closed = "▸",
                    arrow_open   = "▾",
                    default      = "▸",
                    open         = "▾",
                    empty        = "▸",
                    empty_open   = "▾",
                    symlink      = "▸",
                    symlink_open = "▾",
                },
                git = {
                    unstaged  = "*",
                    staged    = "✓",
                    unmerged  = "?",
                    renamed   = "➜",
                    untracked = "*",
                    deleted   = "✗",
                    ignored   = "",
                },
            },
            show         = { file = true, folder = true, folder_arrow = false },
            symlink_arrow  = " ➛ ",
            webdev_colors  = false,
        },
        special_files       = {},
        symlink_destination = true,
    },
    view = {
        number         = true,
        relativenumber = true,
        signcolumn     = "no",
    },
})

-- ─────────────────────────────────────────────
-- Colorscheme (onedark)
-- ─────────────────────────────────────────────

vim.g.onedark_terminal_italics = 1
vim.g.onedark_color_overrides  = {
    comment_grey = { gui = "#707884", cterm = "244", cterm16 = "7" },
}

-- Known onedark palette (with overrides applied).
local c = {
    black        = 0x282c34,
    blue         = 0x61afef,
    cyan         = 0x56b6c2,
    green        = 0x98c379,
    purple       = 0xc678dd,
    red          = 0xe06c75,
    yellow       = 0xe5c07b,
    foreground   = 0xabb2bf,
    background   = 0x282c34,
    comment_grey = 0x707884,  -- overridden from default
    cursor_grey  = 0x2c313a,
}

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern  = "*",
    callback = function()
        -- Barbar colors.
        vim.api.nvim_set_hl(0, "BufferCurrent",        { fg = c.black,       bg = c.green })
        vim.api.nvim_set_hl(0, "BufferCurrentMod",     { fg = c.black,       bg = c.blue })
        vim.api.nvim_set_hl(0, "BufferCurrentIndex",   { fg = c.black,       bg = c.green })
        vim.api.nvim_set_hl(0, "BufferCurrentLetter",  { fg = c.black,       bg = c.green })
        vim.api.nvim_set_hl(0, "BufferVisible",        { fg = c.green,       bg = c.background })
        vim.api.nvim_set_hl(0, "BufferVisibleMod",     { fg = c.blue,        bg = c.background })
        vim.api.nvim_set_hl(0, "BufferVisibleIndex",   { fg = c.green,       bg = c.background })
        vim.api.nvim_set_hl(0, "BufferVisibleLetter",  { fg = c.green,       bg = c.background })
        vim.api.nvim_set_hl(0, "BufferInactive",       { fg = c.green,       bg = c.background })
        vim.api.nvim_set_hl(0, "BufferInactiveMod",    { fg = c.blue,        bg = c.background })
        vim.api.nvim_set_hl(0, "BufferInactiveIndex",  { fg = c.green,       bg = c.background })
        vim.api.nvim_set_hl(0, "BufferInactiveLetter", { fg = c.green,       bg = c.background })
        vim.api.nvim_set_hl(0, "BufferTabpageFill",    { fg = c.foreground,  bg = c.cursor_grey })
        -- LSP float colors.
        vim.api.nvim_set_hl(0, "NormalFloat",  { fg = c.foreground,   bg = c.background })
        vim.api.nvim_set_hl(0, "FloatBorder",  { fg = c.comment_grey, bg = c.background })
        -- nvim-tree colors.
        vim.api.nvim_set_hl(0, "NvimTreeSymlink",          { fg = c.cyan })
        vim.api.nvim_set_hl(0, "NvimTreeFolderIcon",       { fg = c.blue })
        vim.api.nvim_set_hl(0, "NvimTreeFolderName",       { fg = c.blue })
        vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = c.blue })
        vim.api.nvim_set_hl(0, "NvimTreeExecFile",         { fg = c.green })
        vim.api.nvim_set_hl(0, "NvimTreeGitDeleted",       { fg = c.red,    bold = true })
        vim.api.nvim_set_hl(0, "NvimTreeGitDirty",         { fg = c.purple, bold = true })
        vim.api.nvim_set_hl(0, "NvimTreeGitIgnored",       { fg = c.comment_grey })
        vim.api.nvim_set_hl(0, "NvimTreeGitMerge",         { fg = c.red,    bold = true })
        vim.api.nvim_set_hl(0, "NvimTreeGitNew",           { fg = c.yellow, bold = true })
        vim.api.nvim_set_hl(0, "NvimTreeGitRenamed",       { fg = c.purple, bold = true })
        vim.api.nvim_set_hl(0, "NvimTreeGitStaged",        { fg = c.green,  bold = true })
        -- Make line numbers more visible (extend existing LineNr highlight).
        local lineNr = vim.api.nvim_get_hl(0, { name = "LineNr" })
        lineNr.fg = c.comment_grey
        vim.api.nvim_set_hl(0, "LineNr", lineNr)
    end,
})

vim.cmd.colorscheme("onedark")

-- ─────────────────────────────────────────────
-- Comment.nvim
-- ─────────────────────────────────────────────

require("Comment").setup()

-- ─────────────────────────────────────────────
-- nvim-surround
-- ─────────────────────────────────────────────

require("nvim-surround").setup({
    delimiters = {
        pairs = {
            ["("] = { "(", ")" },
            ["{"] = { "{", "}" },
            ["<"] = { "<", ">" },
            ["["] = { "[", "]" },
        },
    },
})

-- ─────────────────────────────────────────────
-- nvim-treesitter
-- ─────────────────────────────────────────────

require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    highlight = {
        enable                            = true,
        additional_vim_regex_highlighting = false,
    },
})

-- ─────────────────────────────────────────────
-- LSP
-- ─────────────────────────────────────────────

-- Disable diagnostics updates in insert mode.
vim.diagnostic.config({ update_in_insert = false })

-- Add completion capabilities via cmp-nvim-lsp.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lspconfig = require("lspconfig")

local servers = {
    "bashls",   -- npm install -g bash-language-server
    "cmake",    -- pipx install cmake-language-server
    "cssls",    -- npm install -g vscode-langservers-extracted
    "html",     -- npm install -g vscode-langservers-extracted
    "jsonls",   -- npm install -g vscode-langservers-extracted
    "ts_ls",    -- npm install -g typescript typescript-language-server
    "vimls",    -- npm install -g vim-language-server
}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({ capabilities = capabilities })
end

lspconfig.pylsp.setup({
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                black       = { enabled = true },
                flake8      = { maxLineLength = 160 },
                pycodestyle = { enabled = false },
                pylint      = { enabled = false },
                pyls_isort  = { enabled = true },
                pylsp_mypy  = { enabled = true },
            },
        },
    },
})

lspconfig.clangd.setup({
    capabilities = capabilities,
    cmd = { "clangd", "--background-index", "--clang-tidy", "--fallback-style=google" },
})

lspconfig.yamlls.setup({  -- npm install -g yaml-language-server
    capabilities = capabilities,
    settings = {
        yaml = {
            keyOrdering = false,
            schemaStore = { enable = false },
        },
    },
})

-- Extra LSP servers via efm-langserver.
-- brew install efm-langserver  /  go install github.com/mattn/efm-langserver@latest
local prettierCss      = { formatCommand = "prettier ${--tab-width:tabWidth} ${--single-quote:singleQuote} --parser css",                                            formatStdin = true }
local prettierHtml     = { formatCommand = "prettier ${--tab-width:tabWidth} ${--single-quote:singleQuote} --use-tabs=true --parser html",                           formatStdin = true }
local prettierJson     = { formatCommand = "prettier ${--tab-width:tabWidth} --parser json",                                                                         formatStdin = true }
local prettierMarkdown = { formatCommand = "prettier ${--tab-width:tabWidth} --parser markdown",                                                                     formatStdin = true }
local prettierToml     = { formatCommand = "prettier --parser toml ${--tab-width:tabWidth} --stdin-filepath=${INPUT}",                                               formatStdin = true }
local prettierXml      = { formatCommand = "prettier --parser xml ${--tab-width:tabWidth} --print-width=160 --stdin-filepath=${INPUT}",                              formatStdin = true }
local prettierYaml     = { formatCommand = "prettier ${--tab-width:tabWidth} --parser yaml",                                                                         formatStdin = true }

lspconfig.efm.setup({
    init_options = { documentFormatting = true },
    root_dir     = vim.uv.cwd,
    settings = {
        rootMarkers = { ".git/" },
        languages = {
            css      = { prettierCss },
            html     = { prettierHtml },
            json     = { prettierJson },
            markdown = { prettierMarkdown },
            toml     = { prettierToml },
            xml      = { prettierXml },
            yaml     = { prettierYaml },
        },
    },
    filetypes = { "css", "html", "json", "markdown", "toml", "xml", "yaml" },
})

-- ─────────────────────────────────────────────
-- nvim-cmp (autocompletion)
-- ─────────────────────────────────────────────

local cmp = require("cmp")
cmp.setup({
    mapping = {
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-CR>"]    = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        ["<Tab>"]     = function(fallback)
            if cmp.visible() then cmp.select_next_item() else fallback() end
        end,
        ["<S-Tab>"]   = function(fallback)
            if cmp.visible() then cmp.select_prev_item() else fallback() end
        end,
    },
    sources = { { name = "nvim_lsp" } },
})

-- ─────────────────────────────────────────────
-- LSP server install helper  (:InstallLspServers)
-- ─────────────────────────────────────────────

vim.api.nvim_create_user_command("InstallLspServers", function()
    vim.cmd("!npm install -g "
        .. "bash-language-server "
        .. "vscode-langservers-extracted "
        .. "typescript typescript-language-server "
        .. "vim-language-server "
        .. "yaml-language-server "
        .. "prettier")
    vim.cmd("!pipx install cmake-language-server")
    vim.cmd("!pipx install python-lsp-server && pipx inject python-lsp-server "
        .. "python-lsp-black "
        .. "pyls-flake8 "
        .. "pylsp-mypy")
    vim.cmd("!ln -s ~/.local/pipx/venvs/python-lsp-server/bin/flake8 ~/.local/bin")
    -- sudo apt install clangd
    if vim.uv.os_uname().sysname == "Darwin" then
        vim.cmd("!brew install efm-langserver")
    else
        vim.cmd("!go install github.com/mattn/efm-langserver@latest")
    end
end, {})
