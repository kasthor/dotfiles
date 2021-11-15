return function()
    local cmp = require('cmp')
    cmp.setup({
        mapping = {
            ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
            ['<C-e>'] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
            ['<C-y>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            }),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
            -- ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            -- ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
            -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        experimental = {
            native_menu = false,
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'nvim_lua' },
            { name = 'path' },
            { name = 'luasnip' },
            { name = 'buffer', keyword_length = 4 },
        }),
        snippet = { 
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        -- formatting = {
        --     format = lspkind.cmp_format({
        --         with_text = true,
        --         menu = {
        --             buffer = '[buf]',
        --             nvim_lsp = '[LSP]',
        --             nvim_lua = '[lua]',
        --             path = '[path]',
        --             luasnip = '[snip]',
        --         },
        --     }),
        -- },
    })
    -- snippet = {
    --   expand = function(args)
    --     vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    --     -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    --     -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    --     -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    --   end,
    -- },
    -- sources = cmp.config.sources({
    --   { name = 'nvim_lsp' },
    --   { name = 'vsnip' }, -- For vsnip users.
    --   -- { name = 'luasnip' }, -- For luasnip users.
    --   -- { name = 'ultisnips' }, -- For ultisnips users.
    --   -- { name = 'snippy' }, -- For snippy users.
    -- }, {
    --   { name = 'buffer' },
    -- })
    -- })

    -- -- Use buffer source for `/`.
    -- cmp.setup.cmdline('/', {
    -- sources = {
    --   { name = 'buffer' }
    -- }
    -- })

    -- -- Use cmdline & path source for ':'.
    -- cmp.setup.cmdline(':', {
    -- sources = cmp.config.sources({
    --   { name = 'path' }
    -- }, {
    --   { name = 'cmdline' }
    -- })
    -- })

    -- -- Setup lspconfig.
    local capabilities = require('cmp_nvim_lsp').update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )
end
