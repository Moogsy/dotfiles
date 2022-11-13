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

    -- Colorscheme
    use('bluz71/vim-moonfly-colors')

    -- Lspconfig's family
    use({"neovim/nvim-lspconfig"}) -- Base lsp
    use('hrsh7th/nvim-cmp') -- Autocompletion plugin
    use('hrsh7th/cmp-nvim-lsp') -- LSP source for nvim-cmp
    use("onsails/lspkind.nvim") -- Show types icons during autocompletion
    use({'simrat39/symbols-outline.nvim'}) -- Symbols in current file
    use("https://git.sr.ht/~whynothugo/lsp_lines.nvim") -- Virtual lines diagnostics

    -- Treesitter's family
    use("nvim-treesitter/nvim-treesitter") -- General highlighting
    use("p00f/nvim-ts-rainbow") -- Rainbow parenthesises

    -- UI Redesigns
    use("MunifTanjim/nui.nvim") -- Base plugin
    -- use("rcarriga/nvim-notify") -- Notifications
    use("folke/noice.nvim") -- Redesign for the command line
    --

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
    use({"lervag/vimtex", ft = {"tex", }}) -- Mappings + Syntax for LaTeX
    use("fladson/vim-kitty") -- Highlighting for kitty config files

    -- Python related
    -- use("numirias/semshi") -- Highlighting
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
    use("airblade/vim-rooter") -- Change root dir


    -- Navigation
    use("phaazon/hop.nvim") -- Within current buffers

    -- Fast editing
    use({"kylechui/nvim-surround", tag = "*" })

    -- Automatically install packer if needed
    if is_first_launch then
        require("packer").sync()
    end
end)
