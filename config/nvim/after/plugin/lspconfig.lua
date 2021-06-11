local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    local opts = { noremap=true, silent=true }

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<f2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<f5>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

for _, lsp in ipairs({"rust_analyzer"}) do
    lspconfig[lsp].setup{ on_attach = on_attach }
end
