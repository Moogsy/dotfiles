-- vim:fileencoding=utf-8:foldmethod=marker

--: Packer bootstrap  {{{

-- Automatically reinstall packer if needed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd([[packadd packer.nvim]])
        return true
    end

    return false
end

local is_first_launch = ensure_packer()

--: }}}

-- Loads plugins
return require("packer").startup(function(use)
	-- Plugins manager
	use("wbthomason/packer.nvim")

    --: Essential plugins {{{

    --: Multi languages {{{

    -- Autocompletion
    use('hrsh7th/nvim-cmp') -- Autocompletion plugin
    use('hrsh7th/cmp-nvim-lsp') -- LSP source for nvim-cmp

    -- LSP
    use({"neovim/nvim-lspconfig"})

    -- Syntax highlighting
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
    })

    -- Snippets handler
    use({ --FIXME: Snippets aren't loaded at all !
        "L3MON4D3/LuaSnip",
        run = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    })

    -- Snippets database
    use({"rafamadriz/friendly-snippets"})

    -- Currently present symbols
    use({'simrat39/symbols-outline.nvim'})

    -- Debugger
    use("puremourning/vimspector")

    -- Linter
    use('mfussenegger/nvim-lint')

    --: }}}

    --: Language specific {{{

    -- LaTeX
    use({"lervag/vimtex", ft = {"tex", }})

    -- Python
    use("numirias/semshi")

    use({ -- Debugger
        "mfussenegger/nvim-dap-python",
        requires = {"mfussenegger/nvim-dap"}
    })

    use("psf/black") -- Format

    -- Kitty config files
    use("fladson/vim-kitty")

    --:}}}

    --:}}}

	--: Eye candy {{{

    -- Rainbow parenthesises
    use({
        "p00f/nvim-ts-rainbow",
        requires = {"nvim-treesitter/nvim-treesitter"}
    })


    -- FIXME: Loading those plugins silence any error when our config files are loaded

    -- Notifications, and better command
    use("MunifTanjim/nui.nvim")
    use("rcarriga/nvim-notify")
    use("folke/noice.nvim")

    --]]

    -- Indicators for indentation
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
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
        end,
    })

    -- Status line
    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    })

    -- Tab pages for buffers
    use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

    --: }}}

    --: Navigation {{{
    use({
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons",
        },
    })
    use({
        "nvim-telescope/telescope.nvim",
        requires = {"nvim-lua/plenary.nvim"}
    })

    -- Jump anywhere
    use("phaazon/hop.nvim")

    -- Change delimiters
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })
    --: }}}

    -- Automatically install packer if needed
    if is_first_launch then
        require("packer").sync()
    end
end)
