local dial = require('dial');

dial.augends["custom#boolean"] = dial.common.enum_cyclic {
    name = "boolean",
    strlist = {"true", "false"},
}

table.insert(dial.config.searchlist.normal, "custom#boolean")

local map = vim.api.nvim_set_keymap

map('n', '<C-a>', '<Plug>(dial-increment)', {})
map('n', '<C-x>', '<Plug>(dial-decrement)', {})
map('v', '<C-a>', '<Plug>(dial-increment)', {})
map('v', '<C-x>', '<Plug>(dial-decrement)', {})
map('v', 'g<C-a>', '<Plug>(dial-increment-additional)', {})
map('v', 'g<C-x>', '<Plug>(dial-decrement-additional)', {})
