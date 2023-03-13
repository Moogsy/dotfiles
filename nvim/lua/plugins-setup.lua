-- vim:fileencoding=utf-8:foldmethod=marker
--: Autocompletion (lspconfig + cmp + luasnip) {{{
local luasnip = require("luasnip")
local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-j>'] = cmp.mapping.scroll_docs(-4),
        ['<C-k>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },

    formatting = {
        format = require("lspkind").cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",
        })
    }
})

vim.api.nvim_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

--: }}}

--: Language servers {{{
local servers = { "bashls", "pyright", "rust_analyzer", "texlab", "clangd" }
local navic = require("nvim-navic")

for _, lsp in pairs(servers) do
    require("lspconfig")[lsp].setup({
        flags = { debounce_text_changes = 150 },
        on_attach = function(client, bufnr)
            if client.server_capabilities.documentSymbolProvider then
                navic.attach(client, bufnr)
            end
        end,
    })
end

require('lspconfig').lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})

--: }}}

--: Autopairs {{{
require("nvim-autopairs").setup({})
--: }}}

--: Bufferline {{{
require("bufferline").setup({})
--: }}}

--: Colourful Winsep {{{
require("colorful-winsep").setup()
--: }}}

--: Dap {{{
local dap = require("dap")

local handle = io.popen("which python3")
---@diagnostic disable-next-line: need-check-nil
local result = handle:read("*a")
---@diagnostic disable-next-line: need-check-nil
handle:close()

require("dap-python").setup(result)


local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

--: }}}

--: Hop {{{
local hop = require("hop")
hop.setup()
--: }}}

--: IndentBlankline {{{
require("indent_blankline").setup({
    space_char_blankline = " ",
    show_current_context = true,
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
})

--: }}}

--: Lint {{{
local lint = require("lint")

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

lint.linters_by_ft = {
}

--: }}}

--: Lualine {{{
require("lualine").setup({ options = { theme = "monokai-pro" } })
--: }}}

--: LuaSnip {{{
require("luasnip.loaders.from_vscode").lazy_load()

--: }}}

--: LspLines {{{
require("lsp_lines").setup()

vim.diagnostic.config({
    virtual_text = false, -- This is now redundant
})

--: }}}

--: Mason {{{
require("mason").setup()
--: }}}

--: Enfocado color theme + Delayed IdentBlankline setup {{{

vim.opt.background = "dark"
vim.cmd("colorscheme monokai-pro")

-- Some colorschemes clears those custom highlights, add them after the clear
vim.cmd("highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine")
vim.cmd("highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine")
vim.cmd("highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine")
vim.cmd("highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine")
vim.cmd("highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine")
vim.cmd("highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine")

--: }}}

--: Monokai Pro {{{
require("monokai-pro").setup({
    transparent_background = true,
    terminal_colors = true,
    devicons = true,
    italic_comments = true,
    filter = "classic",
})
--}}}

--: Neoclip {{{
require("neoclip").setup({
    defaults = {
      borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
    }
})
require("telescope").load_extension("neoclip")

--: }}}

--: Noice {{{
require("noice").setup({
    cmdline = {
        enabled = true, -- enables the Noice cmdline UI
        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = {}, -- global options for the cmdline. See section on views
        ---@type table<string, CmdlineFormat>
        format = {
            -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
            -- view: (default is cmdline view)
            -- opts: any options passed to the view
            -- icon_hl_group: optional hl_group for the icon
            -- title: set to anything or empty string to hide
            cmdline = { pattern = "^:", icon = "", lang = "vim" },
            search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
            filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
            lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
            help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
            input = {}, -- Used by input()
        },
    },
    messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        enabled = true, -- enables the Noice messages UI
        view = "notify", -- default view for messages
        view_error = "notify", -- view for errors
        view_warn = "notify", -- view for warnings
        view_history = "messages", -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
    },
    popupmenu = {
        enabled = true, -- enables the Noice popupmenu UI
        ---@type 'nui'|'cmp'
        backend = "nui", -- backend to use to show regular cmdline completions
        ---@type NoicePopupmenuItemKind|false
        -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
        kind_icons = {}, -- set to `false` to disable icons
    },
    -- You can add any custom commands below that will be available with `:Noice command`
    ---@type table<string, NoiceCommand>
    commands = {
        history = {
            -- options for the message history that you get with `:Noice`
            view = "split",
            opts = { enter = true, format = "details" },
            filter = {
                any = {
                    { event = "notify" },
                    { error = true },
                    { warning = true },
                    { event = "msg_show", kind = { "" } },
                    { event = "lsp", kind = "message" },
                },
            },
        },
        -- :Noice last
        last = {
            view = "popup",
            opts = { enter = true, format = "details" },
            filter = {
                any = {
                    { event = "notify" },
                    { error = true },
                    { warning = true },
                    { event = "msg_show", kind = { "" } },
                    { event = "lsp", kind = "message" },
                },
            },
            filter_opts = { count = 1 },
        },
        -- :Noice errors
        errors = {
            -- options for the message history that you get with `:Noice`
            view = "popup",
            opts = { enter = true, format = "details" },
            filter = { error = true },
            filter_opts = { reverse = true },
        },
    },
    notify = {
        -- Noice can be used as `vim.notify` so you can route any notification like other messages
        -- Notification messages have their level and other properties set.
        -- event is always "notify" and kind can be any log level as a string
        -- The default routes will forward notifications to nvim-notify
        -- Benefit of using Noice for this is the routing and consistent history view
        enabled = true,
        view = "notify",
    },
    lsp = {
        progress = {
            enabled = true,
            -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
            -- See the section on formatting for more details on how to customize.
            --- @type NoiceFormat|string
            format = "lsp_progress",
            --- @type NoiceFormat|string
            format_done = "lsp_progress_done",
            throttle = 1000 / 30, -- frequency to update lsp progress message
            view = "mini",
        },
        override = {
            -- override the default lsp markdown formatter with Noice
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            -- override the lsp markdown formatter with Noice
            ["vim.lsp.util.stylize_markdown"] = true,
            -- override cmp documentation with Noice (needs the other options to work)
            ["cmp.entry.get_documentation"] = true,
        },
        hover = {
            enabled = true,
            view = nil, -- when nil, use defaults from documentation
            ---@type NoiceViewOptions
            opts = {}, -- merged with defaults from documentation
        },
        signature = {
            enabled = true,
            auto_open = {
                enabled = true,
                trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
                luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
                throttle = 50, -- Debounce lsp signature help request by 50ms
            },
            view = nil, -- when nil, use defaults from documentation
            ---@type NoiceViewOptions
            opts = {}, -- merged with defaults from documentation
        },
        message = {
            -- Messages shown by lsp servers
            enabled = true,
            view = "notify",
            opts = {},
        },
        -- defaults for hover and signature help
        documentation = {
            view = "hover",
            ---@type NoiceViewOptions
            opts = {
                lang = "markdown",
                replace = true,
                render = "plain",
                format = { "{message}" },
                win_options = { concealcursor = "n", conceallevel = 3 },
            },
        },
    },
    markdown = {
        hover = {
            ["|(%S-)|"] = vim.cmd.help, -- vim help links
            ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
        },
        highlights = {
            ["|%S-|"] = "@text.reference",
            ["@%S+"] = "@parameter",
            ["^%s*(Parameters:)"] = "@text.title",
            ["^%s*(Return:)"] = "@text.title",
            ["^%s*(See also:)"] = "@text.title",
            ["{%S-}"] = "@parameter",
        },
    },
    health = {
        checker = true, -- Disable if you don't want health checks to run
    },
    smart_move = {
        -- noice tries to move out of the way of existing floating windows.
        enabled = true, -- you can disable this behaviour here
        -- add any filetypes here, that shouldn't trigger smart move.
        excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
    },
    ---@type NoicePresets
    presets = {
        -- you can enable a preset by setting it to true, or a table that will override the preset config
        -- you can also add custom presets that you can enable/disable with enabled=true
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = false, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
    ---@type NoiceConfigViews
    views = {}, ---@see section on views
    ---@type NoiceRouteConfig[]
    routes = {}, --- @see section on routes
    ---@type table<string, NoiceFilter>
    status = {}, --- @see section on statusline components
    ---@type NoiceFormatOptions
    format = {}, --- @see section on formatting
})

require("notify").setup({background_colour = "#000000"})

--: }}}

--: Pets {{{
require("pets").setup({
    default_pet = "cat",
    default_style = "brown"
})
--}}}

-- Rooter {{{
vim.g['rooter_cd_cmd'] = 'lcd'
-- }}}

--: Symbols outline {{{
---@diagnostic disable-next-line: redefined-local
local opts = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = false,
    position = 'right',
    relative_width = true,
    width = 25,
    auto_close = false,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = true,
    preview_bg_highlight = 'Pmenu',
    autofold_depth = nil,
    auto_unfold_hover = true,
    fold_markers = { '', '' },
    wrap = false,
    keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = { "<Esc>", "q" },
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        toggle_preview = "K",
        rename_symbol = "r",
        code_actions = "a",
        fold = "h",
        unfold = "l",
        fold_all = "H",
        unfold_all = "L",
        fold_reset = "R",
    },
    lsp_blacklist = {},
    symbol_blacklist = {},
    symbols = {
        File = { icon = "", hl = "String" },
        Module = { icon = "", hl = "Constant" },
        Namespace = { icon = "", hl = "Constant" },
        Package = { icon = "", hl = "Constant" },
        Class = { icon = "𝓒", hl = "Type" },
        Method = { icon = "ƒ", hl = "Function" },
        Property = { icon = "", hl = "Function" },
        Field = { icon = "", hl = "Function" },
        Constructor = { icon = "", hl = "Function" },
        Enum = { icon = "ℰ", hl = "Type" },
        Interface = { icon = "ﰮ", hl = "Type" },
        Function = { icon = "", hl = "Function" },
        Variable = { icon = "", hl = "Constant" },
        Constant = { icon = "", hl = "Constant" },
        String = { icon = "𝓐", hl = "String" },
        Number = { icon = "#", hl = "Number" },
        Boolean = { icon = "⊨", hl = "Boolean" },
        Array = { icon = "", hl = "Constant" },
        Object = { icon = "⦿", hl = "Type" },
        Key = { icon = "🔐", hl = "Type" },
        Null = { icon = "NULL", hl = "Constant" },
        EnumMember = { icon = "", hl = "Constant" },
        Struct = { icon = "𝓢", hl = "Type" },
        Event = { icon = "🗲", hl = "Type" },
        Operator = { icon = "+", hl = "Operator" },
        TypeParameter = { icon = "𝙏", hl = "Constant" }
    }
}

require("symbols-outline").setup(opts)


--: }}}

-- Toggleterm {{{
require("toggleterm").setup({
    direction = "vertical",
    border = "curved",
    size = function(term)
        if term.direction == "vertical" then
            return vim.o.columns * 0.5
        elseif term.direction == "horizontal" then
            return vim.o.lines * 0.3
        end
    end,
})
-- }}}

--: Transparent {{{
require("transparent").setup({
  enable = true, -- boolean: enable transparent
  extra_groups = { -- table/string: additional groups that should be cleared
    -- In particular, when you set it to 'all', that means all available groups

    -- example of akinsho/nvim-bufferline.lua
    "BufferLineTabClose",
    "BufferlineBufferSelected",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineSeparator",
    "BufferLineIndicatorSelected",
  },
  exclude = {}, -- table: groups you don't want to clear
})

--: }}}

--: Treesitter + Rainbow indentation / parenthesis {{{
require('nvim-treesitter.install').update({ with_sync = true })

require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
    },

    rainbow = {
        enable = true,
        strategy = require("ts-rainbow.strategy.global"),
        colors = { "#E0B0FF", "#90EE90", "#ADD8E6", "#FFFF00", "#FF0000" }
    }
})

--: }}}

--: TelescopeRepo {{{
require("telescope").load_extension("repo")
--: }}}

--: TelescopeUndo {{{
require("telescope").load_extension("undo")
--: }}}

-- Vimtex {{{
vim.g.vimtex_view_method = "mupdf"
-- }}}
