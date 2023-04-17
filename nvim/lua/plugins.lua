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

-- Loads plugins
return require("packer").startup(function(use)
	-- Plugins manager
	use("wbthomason/packer.nvim")

    -- LSP + DAP manager
    use("williamboman/mason.nvim")

    -- Colorscheme
    use {"loctvl842/monokai-pro.nvim"}
    -- Lspconfig's family
    use({"neovim/nvim-lspconfig"}) -- Base lsp
    use('hrsh7th/nvim-cmp') -- Autocompletion plugin
    use('hrsh7th/cmp-nvim-lsp') -- LSP source for nvim-cmp
    use("onsails/lspkind.nvim") -- Show types icons during autocompletion
    use({'simrat39/symbols-outline.nvim'}) -- Symbols in current file
    use("https://git.sr.ht/~whynothugo/lsp_lines.nvim") -- Virtual lines diagnostics
    use({"SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig"})
    -- Treesitter's family
    use("nvim-treesitter/nvim-treesitter") -- General highlighting
    use("HiPhish/nvim-ts-rainbow2")
    use({
    "utilyre/barbecue.nvim",
    tag = "*",
    requires = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    after = "nvim-web-devicons", -- keep this if you're using NvChad
    config = function()
        require("barbecue").setup({
            theme = 'monokai-pro'
        })
    end,
    })
    -- UI eye candy
    use("MunifTanjim/nui.nvim") -- Base plugin
    use("rcarriga/nvim-notify") -- Notifications
    use("folke/noice.nvim") -- Redesign for the command line
    use("nvim-zh/colorful-winsep.nvim") -- Add some coloured borders
    use("xiyaowong/nvim-transparent") -- Transparent background
    use({
    "giusgad/pets.nvim",
    requires = {
        "edluffy/hologram.nvim",
        "MunifTanjim/nui.nvim",
    }
    })
    -- Fix colorschemes that don't support new colors yet
    use("folke/lsp-colors.nvim")

    -- Status bar
    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }) -- Status line
    use({
        'akinsho/bufferline.nvim',
        tag = "v3.*",
        requires = 'nvim-tree/nvim-web-devicons'
    }) -- Indicator for buffers

    -- Color picker
    use("uga-rosa/ccc.nvim")

    -- Debugger
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("mfussenegger/nvim-dap-python")

    -- Linter
    use('mfussenegger/nvim-lint')

    -- Language specific plugins

    -- Markdown specific
    use("abeleinin/papyrus")

    -- LaTeX Specific
    use("lervag/vimtex") -- Mappings + Syntax for LaTeX

    -- Kitty config files
    use("fladson/vim-kitty") -- Highlighting for kitty config files

    -- Python related
    use("psf/black") -- Format

    -- Snippets handler 
    -- FIXME: Those snippets aren't loaded
    use("L3MON4D3/LuaSnip")
    use({"rafamadriz/friendly-snippets"}) -- Snippets database

    -- Indicators for indentation
    use("lukas-reineke/indent-blankline.nvim")

    -- Telescope family
    use({"nvim-telescope/telescope.nvim", requires = {"nvim-lua/plenary.nvim"}})
    use("Acksld/nvim-neoclip.lua") -- Navigate throught old yanked text
    use("cljoly/telescope-repo.nvim") -- Go to repos
    use("airblade/vim-rooter") -- Change root dir (utils for telescope-repo)
    use("debugloop/telescope-undo.nvim") -- Navigate throught past states

    -- Navigation
    use("phaazon/hop.nvim") -- Within current buffers
    use("akinsho/toggleterm.nvim") -- Dynamic terminal

    -- Fast editing
    use({"kylechui/nvim-surround", tag = "*" })
    use("windwp/nvim-autopairs")


    -- Automatically install packer if needed
    if is_first_launch then
        require("packer").sync()
    end
end)
