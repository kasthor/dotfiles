return function()
    function _G._TelescopePersonal()
        if require('core.utils').os.is_git_dir == 0 then
            return 'lua require"telescope.builtin".git_files()'
        else
            return 'lua require"telescope.builtin".find_files()'
        end
    end
    vim.g.dashboard_footer_icon = '🐬 '
    vim.g.dashboard_preview_file_height = 12
    vim.g.dashboard_preview_file_width = 80
    vim.g.dashboard_disable_statusline = 1
    vim.g.dashboard_default_executive = 'telescope'
    vim.g.dashboard_custom_section = {
        _01_find_files = {
            description = { '  Git files                           \\oo' },
            command = 'silent! lua require"telescope.builtin".git_files()',
        },
        _02_find_history = {
            description = { '  Recently opened files               \\ol' },
            command = 'lua require"telescope.builtin".oldfiles()',
        },
        _03_find_word = {
            description = { '  Find  word                          \\og' },
            command = 'lua require"telescope.builtin".live_grep()',
        },
        _04_find_dotfiles = {
            description = { '  Open Personal dotfiles              \\oc' },
            command = 'lua require"telescope.builtin".git_files({cwd = "$HOME/.dotfiles" })',
        },
        _05_vimwiki = {
            description = { '  Wiki                                \\ww', },
            command = ':VimwikiIndex',
        },
    }

    vim.g.dashboard_custom_header = {
        '',
        '',
        '',
        ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
        ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
        ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
        ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
        ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
        ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
        '',
    }
end
