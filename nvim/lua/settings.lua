local opt=vim.opt

-- Setting up colors
opt.termguicolors = true

-- Misc
opt.mouse = nil
opt.pyx = 3
opt.encoding = "utf-8"
opt.updatetime = 250
opt.clipboard = "unnamedplus"

-- Readability
opt.number = true
opt.wrap = false
opt.conceallevel = 0

-- Interface
opt.title = true
opt.laststatus = 2
opt.scrolloff = 5

-- Completion
opt.wildmenu = true
opt.completeopt = {"menu", "menuone", "noselect"}

-- Indentation
opt.cindent = false

-- Backapce
opt.backspace = {"indent", "eol", "start"}

-- Parenthesises
opt.showmatch = true
opt.matchtime = 1

-- Tabs
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.shiftround = true

-- Search
opt.hlsearch = true
opt.is = true

opt.ignorecase = true
opt.smartcase = true

-- Fix some lsp issues since some language servers dislike backups
opt.backup = false
opt.writebackup = false

-- Vimtex
vim.g.vimtex_view_method = "mupdf"
