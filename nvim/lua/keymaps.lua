local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Builtin Lsp
keymap('n', '(', vim.diagnostic.goto_prev, opts, "Go to preious diagnostic")
keymap('n', ')', vim.diagnostic.goto_next, opts)

keymap('n', '<space>D', vim.lsp.buf.type_definition, opts)
keymap('n', '<space>c', vim.lsp.buf.code_action, opts)
keymap('n', '<space>d', vim.lsp.buf.definition, opts)
keymap('n', '<space>e', vim.diagnostic.open_float, opts)
keymap('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
keymap('n', '<space>i', vim.lsp.buf.implementation, opts)
keymap('n', '<space>k', vim.lsp.buf.hover, opts)
keymap('n', '<space>n', vim.lsp.buf.rename, opts)
keymap('n', '<space>r', vim.lsp.buf.references, opts)

-- Terminal
keymap('t', '<Esc>', [[ <C-\><C-n> ]], opts)

-- That overlaps with Telescope's usual prefix
keymap('n', 'tt', function() require("toggleterm").toggle(1) end, opts)

-- LspLines
keymap("n", "<space>l", require("lsp_lines").toggle, opts)

-- Hop
keymap("n", "mc", function() vim.cmd("HopAnywhereCurrentLine") end, opts)
keymap("n", "ma", function() vim.cmd("HopAnywhere") end, opts)
keymap('n', 'ml', function() vim.cmd("HopLine") end, opts)
keymap('n', 'mp', function() vim.cmd("HopPattern") end, opts)
keymap('n', 'mw', function() vim.cmd("HopWord") end, opts)

-- SymbolsOutline
keymap('n', '"', function() vim.cmd("SymbolsOutline") end, opts)

-- Telescope
local tbuiltins = require("telescope.builtin")
local telescope = require("telescope")
keymap('n', 'tb', tbuiltins.buffers, opts) -- buffers
keymap('n', 'tc', tbuiltins.commands, opts) -- vim commands
keymap('n', 'td', tbuiltins.diagnostics, opts) -- lsp diagnostics
keymap('n', 'tf', tbuiltins.find_files, opts) -- files (same folder + subfolders)
keymap('n', 'tg', tbuiltins.git_files, opts) -- listed git files (whole workspace)
keymap('n', 'th', tbuiltins.help_tags, opts) -- vim help pages
keymap('n', 'tm', tbuiltins.man_pages, opts) -- man pages
keymap('n', 'tn', telescope.extensions.neoclip.default, opts) -- registers
keymap('n', 'tr', function() vim.cmd("Telescope repo list") end, opts) -- Git repos
keymap('n', 'ts', tbuiltins.spell_suggest, opts) -- spell correction
keymap('n', 'tv', tbuiltins.lsp_document_symbols, opts) -- variables
keymap('n', 'tl', tbuiltins.live_grep, opts) -- Grep and show matches at the same time
keymap('n', 'tu', function() vim.cmd("Telescope undo") end, opts) -- Shows undo tree

-- Dap
local dap = require("dap")
keymap('n', '<F5>', dap.continue, opts)
keymap('n', '<S-F5>', dap.terminate, opts)

keymap('n', '<F3>', dap.repl.toggle, opts)
keymap('n', '<F4>', dap.toggle_breakpoint, opts)

keymap('n', '<F6>', dap.step_over, opts)
keymap('n', '<F7>', dap.step_into, opts)
keymap('n', '<F8>', dap.step_out, opts)

-- Papyrus
keymap('n', '<space>pc', function() vim.cmd("PapyrusCompile") end, opts)
keymap('n', '<space>pa', function() vim.cmd("PapyrusAutoCompile") end, opts)
keymap('n', '<space>pv', function() vim.cmd("PapyrusView") end, opts)
keymap('n', '<space>ps', function() vim.cmd("PapyrusStart") end, opts)

