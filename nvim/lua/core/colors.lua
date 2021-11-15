local colorscheme = 'material'
local g = vim.g

g.material_style = 'palenight'

pcall(function()
    vim.cmd('colorscheme ' .. colorscheme)
end)
