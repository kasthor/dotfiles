return function()
    local ls = require('luasnip')
    local s = ls.snippet
    local sn = ls.snippet_node
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local c = ls.choice_node
    local d = ls.dynamic_node
    local l = require('luasnip.extras').lambda
    local r = require('luasnip.extras').rep
    local p = require('luasnip.extras').partial
    local m = require('luasnip.extras').match
    local n = require('luasnip.extras').nonempty
    local dl = require('luasnip.extras').dynamic_lambda
    local fmt = require('luasnip.extras.fmt').fmt
    local fmta = require('luasnip.extras.fmt').fmta
    local types = require('luasnip.util.types')
    local conds = require('luasnip.extras.expand_conditions')

    ls.config.set_config({
        history = true,
        updateevents = 'TextChanged, TextChanged1',
    })

    ls.snippets = {
        all = {
            s(
                'lorem',
                t(
                    'Lorem ipsum dolor sit amet, qui minim labore adipisicing minim sint cillum sint consectetur cupidatat.'
                )
            ),
            s(
                'loremPara',
                t(
                    'Lorem ipsum dolor sit amet, officia excepteur ex fugiat reprehenderit enim labore culpa sint ad nisi Lorem pariatur mollit ex esse exercitation amet. Nisi anim cupidatat excepteur officia. Reprehenderit nostrud nostrud ipsum Lorem est aliquip amet voluptate voluptate dolor minim nulla est proident. Nostrud officia pariatur ut officia. Sit irure elit esse ea nulla sunt ex occaecat reprehenderit commodo officia dolor Lorem duis laboris cupidatat officia voluptate. Culpa proident adipisicing id nulla nisi laboris ex in Lorem sunt duis officia eiusmod. Aliqua reprehenderit commodo ex non excepteur duis sunt velit enim. Voluptate laboris sint cupidatat ullamco ut ea consectetur et est culpa et culpa duis.'
                )
            ),
        },
        html = {},
        javascriptreact = {
            s('useState', {
                t('const ['),
                i(1),
                t(', set'),
                f(function(args, snip)
                    return args[1][1]:gsub("^%l", string.upper)
                end, {1}),
                t('] = useState('),
                i(2, 'null'),
                t(');'),
            }),
            s('useTranslate', t('const {t} = useTranslate();')),
            s('styled', {t('const '), i(1), t(' = styled'), c(2, {i(3, '.div'), sn(nil, {t('('), i(1,'Element'), t(')')})}), t('``')}),
            s('useEffect', {t('useEffect(() => {'), c(2, {t(''), t('return () => {}')}),t('}, ['), i(1), t('])')}),
            s('rfc',  {
              t('export const '),
              f(
                function(args, snip) 
                  if snip.env.TM_FILENAME_BASE == 'index' then
                    return string.match(snip.env.TM_DIRECTORY, "[^/]*$")
                  else
                    return snip.env.TM_FILENAME_BASE
                  end
                end, {}
              ),
              t(' = () => '), c(1, {t('(<></>)'), t('{return (<></>)}')})
            })
        },
    }

    ls.filetype_extend('javascript', { 'javascriptreact' })

    local function prequire(...)
        local status, lib = pcall(require, ...)
        if status then
            return lib
        end
        return nil
    end

    local luasnip = prequire('luasnip')
    local cmp = prequire('cmp')

    local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    local check_back_space = function()
        local col = vim.fn.col('.') - 1
        if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
            return true
        else
            return false
        end
    end

    _G.tab_complete = function()
        if cmp and cmp.visible() then
            cmp.select_next_item()
        elseif luasnip and luasnip.expand_or_jumpable() then
            return t('<Plug>luasnip-expand-or-jump')
        elseif check_back_space() then
            return t('<Tab>')
        else
            cmp.complete()
        end
        return ''
    end
    _G.s_tab_complete = function()
        if cmp and cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip and luasnip.jumpable(-1) then
            return t('<Plug>luasnip-jump-prev')
        else
            return t('<S-Tab>')
        end
        return ''
    end

    vim.api.nvim_set_keymap(
        'i',
        '<Tab>',
        'v:lua.tab_complete()',
        { expr = true }
    )
    vim.api.nvim_set_keymap(
        's',
        '<Tab>',
        'v:lua.tab_complete()',
        { expr = true }
    )
    vim.api.nvim_set_keymap(
        'i',
        '<S-Tab>',
        'v:lua.s_tab_complete()',
        { expr = true }
    )
    vim.api.nvim_set_keymap(
        's',
        '<S-Tab>',
        'v:lua.s_tab_complete()',
        { expr = true }
    )
    vim.api.nvim_set_keymap('i', '<C-E>', '<Plug>luasnip-next-choice', {})
    vim.api.nvim_set_keymap('s', '<C-E>', '<Plug>luasnip-next-choice', {})
end
