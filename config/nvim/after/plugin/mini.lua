function hi(group, color)
    vim.api.nvim_set_hl(0, group, { fg = color })
end

local colors = require('tango-dark.colors').setup()

hi('MiniIconsAzure', colors.blue)
hi('MiniIconsOrange', colors.yellow)
hi('MiniIconsBlue', colors.light_blue)
hi('MiniIconsCyan', colors.cyan)
hi('MiniIconsGreen', colors.light_green)
hi('MiniIconsGrey', colors.gray)
hi('MiniIconsPurple', colors.purple)
hi('MiniIconsRed', colors.light_red)
hi('MiniIconsYellow', colors.light_yellow)
