require('mini.completion').setup()
vim.cmd([[au FileType snacks_picker_input lua vim.b.minicompletion_disable = true]])

require('mini.icons').setup()
MiniIcons.tweak_lsp_kind()

