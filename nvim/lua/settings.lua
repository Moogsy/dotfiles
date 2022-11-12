local opt=vim.opt

-- Colorscheme
opt.termguicolors = true
opt.syntax = "on"
vim.cmd("colorscheme mfantasy")

-- Misc
opt.mouse = nil
opt.pyx = 3
opt.encoding = "utf-8"
opt.updatetime = 250

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

-- Diagnostics
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    float = { border = "single" },
})

-- Fix some lsp issues, some language servers dislike backups
opt.backup = false
opt.writebackup = false


