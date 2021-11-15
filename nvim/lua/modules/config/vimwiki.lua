return function()
    vim.g.vimwiki_global_ext = 0
    vim.g.vimwiki_folding = 'list'
    vim.g.vimwiki_key_mappings = {
        all_maps = 0,
        global = 0,
        headers = 0,
        text_objs = 0,
        table_format = 0,
        table_mappings = 0,
        lists = 0,
        links = 0,
        html = 0,
        mouse = 0,
    }
    vim.g.vimwiki_list = {
        {
            auto_export = 1,
            path = '~/.dotfiles/vimwiki/',
            syntax = 'markdown',
            ext = '.md',
        },
    }

    vim.cmd([[
      autocmd FileType vimwiki setlocal nobuflisted
      autocmd FileType vimwiki map <buffer> gn <Plug>VimwikiFollowLink
      autocmd FileType vimwiki map <buffer> gp <Plug>VimwikiGoBackLink
      autocmd FileType vimwiki map <buffer> <Space> <Plug>VimwikiToggleListItem
      noremap <Leader>ww :VimwikiIndex<CR>
    ]])
end
