local augend = require('dial.augend');

require("dial.config").augends:register_group{
    default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%m/%d"],
        augend.date.alias["%H:%M"],
        augend.constant.alias.ja_weekday_full,
        augend.constant.new {
            elements = {"true", "false"},
            cyclic = true,
        }
    }
}

local map = vim.api.nvim_set_keymap
local dial = require('dial.map');

map("n", "<C-a>", dial.inc_normal(), {noremap = true})
map("n", "<C-x>", dial.dec_normal(), {noremap = true})
map("v", "<C-a>", dial.inc_visual(), {noremap = true})
map("v", "<C-x>", dial.dec_visual(), {noremap = true})
map("v", "g<C-a>", dial.inc_gvisual(), {noremap = true})
map("v", "g<C-x>", dial.dec_gvisual(), {noremap = true})
