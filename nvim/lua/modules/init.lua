local utils = require('core.utils')
local packer_url = 'https://github.com/wbthomason/packer.nvim'
local packer_path = utils.os.data .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
    print('Downloading plugin manager...')
    vim.cmd('silent! !git clone ' .. packer_url .. ' ' .. packer_path)

    vim.cmd('packadd packer.nvim')
end

local packer = require('packer')

return packer.startup(function(use)
    packer.init({ profile = { enable = true } })

    -- Plugin manager
    use({ 'wbthomason/packer.nvim' })
    -- Common dependencies
    use({
        'nvim-lua/plenary.nvim',
        module = 'plenary',
    })
    use({
        'nvim-lua/popup.nvim',
        module = 'popup',
    })

    --[[ Template for adding a plugin
      use ({
           'plugin/name'
           config = require('modules.config.plugin_name')
           event|cmd|module --> way to lazy load the plugin
           run = 'If it needs to run a command'
           requires = {}
      })
  --]]

    -----[[------------]]-----
    --- Essentials ---
    -----]]------------[[-----
    -- Treesitter
    use({
        'nvim-treesitter/nvim-treesitter',
        config = require('modules.config.nvim-treesitter'),
        -- event = 'BufRead',
        run = ':TSUpdate',
        requires = {
            'p00f/nvim-ts-rainbow',
            'nvim-treesitter/playground',
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
    })

    -----[[------------]]-----
    --- UI Related ---
    -----]]------------[[-----
    -- Start Screen
    use({
        'glepnir/dashboard-nvim',
        config = require('modules.config.dashboard-nvim'),
        cmd = 'Dashboard',
    })

    -----[[------------]]-----
    --- Color Schemes ---
    -----]]------------[[-----

    use({
        'marko-cerovac/material.nvim',
        config = require('modules.config.material'),
    })

    -- Icons
    use({
        'kyazdani42/nvim-web-devicons',
        config = require('modules.config.nvim-web-devicons'),
        module = 'nvim-web-devicons',
    })

    -- Vim Wiki
    use({
        'vimwiki/vimwiki',
        config = function()
            vim.g.vimwiki_global_ext = 0
            vim.g.vimwiki_folding = 'list'
            vim.g.vimwiki_key_mappings = { all_maps = 0 }
            vim.g.vimwiki_list = {
                {
                    auto_export = 1,
                    path = '~/.dotfiles/vimwiki/',
                    syntax = 'markdown',
                    ext = '.md',
                },
            }
            vim.api.nvim_command([[
                autocmd FileType vimwiki setlocal nobuflisted
                autocmd FileType vimwiki map <buffer> <C-]> <Plug>VimwikiFollowLink
                autocmd FileType vimwiki map <buffer> <C-[> <Plug>VimwikiGoBackLink
                autocmd FileType vimwiki map <buffer> <C-Space> <Plug>VimwikiToggleListItem
                nnoremap <Leader>ww :VimwikiIndex<CR>
            ]])
        end,
    })

    -- File tree
    use({
        'kyazdani42/nvim-tree.lua',
        config = require('modules.config.nvim-tree'),
        -- cmd = { 'NvimTreeClipboard', 'NvimTreeClose', 'NvimTreeFindFile', 'NvimTreeOpen', 'NvimTreeRefresh', 'NvimTreeToggle', },
    })

    -- Fuzzy finding / Ctrl + p
    use({
        'nvim-telescope/telescope.nvim',
        config = require('modules.config.telescope'),
        module = 'telescope',
        requires = {
            { 'nvim-telescope/telescope-fzy-native.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        },
    })

    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = require('modules.config.lualine'),
    })

    use({
        'akinsho/nvim-bufferline.lua',
        config = require('modules.config.nvim-bufferline'),
        event = 'ColorScheme',
    })

    -- Indent Lines

    --[[-----
  use({
      'lukas-reineke/indent-blankline.nvim',
      config = require('modules.config.indent-blankline'),
      event = 'ColorScheme',
  })
  --]]
    -----

    -----[[--------------]]-----
    --- IDE features ---
    -----]]--------------[[-----

    use({
        'mattn/emmet-vim',
    })

    -- Commenting
    --
    use({ 'tpope/vim-commentary', event = 'BufEnter' })

    -- Should be in vim core
    use({
        'tpope/vim-surround',
        event = 'BufEnter',
    })

    -- <C-n> To create multiple cursors
    use({
        'terryma/vim-multiple-cursors',
    })

    -----[[-------------]]-----
    --- GIT RELATED ---
    -----]]-------------[[-----
    use({
        'lewis6991/gitsigns.nvim',
        config = require('modules.config.gitsigns'),
        event = 'BufRead',
    })

    use({
        'TimUntersberger/neogit',
        config = require('modules.config.neogit'),
        cmd = 'Neogit',
        requires = {
            { 'sindrets/diffview.nvim', module = 'diffview' },
        },
    })

    -----[[------------]]-----
    --- Completion ---
    -----]]------------[[-----
    -- Built-in lsp
    use({
        'neovim/nvim-lspconfig',
        config = require('modules.config.nvim-lspconfig'),
        requires = {
            { 'kabouzeid/nvim-lspinstall', module = 'lspinstall' },
            { 'glepnir/lspsaga.nvim' },
            { 'ray-x/lsp_signature.nvim', module = 'lsp_signature' },
            {
                'jose-elias-alvarez/nvim-lsp-ts-utils',
                module = 'nvim-lsp-ts-utils',
            },
        },
    })

    -- Completion plugin

    use({
        'hrsh7th/nvim-cmp',
        config = require('modules.config.nvim-cmp'),
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'saadparwaiz1/cmp_luasnip',
        },
    })

    -- Snippets

    use({
        'L3MON4D3/LuaSnip',
        config = require('modules.config.luasnip'),
    })

    use({
        'saadparwaiz1/cmp_luasnip',
        after = 'nvim-cmp',
        requires = {
            'rafamadriz/friendly-snippets',
            'dsznajder/vscode-es7-javascript-react-snippets',
        },
    })

    -----[[-------------]]-----
    --- Web dev ---
    -----]]-------------[[-----
    use({
        'norcalli/nvim-colorizer.lua',
        config = require('modules.config.nvim-colorizer'),
        event = 'ColorScheme',
    })

    -----[[-------------]]-----
    --- Terminal ---
    -----]]-------------[[-----

    use({
        'akinsho/toggleterm.nvim',
        config = require('modules.config.toggleterm'),
    })

    packer.install()
    packer.compile()
end)
