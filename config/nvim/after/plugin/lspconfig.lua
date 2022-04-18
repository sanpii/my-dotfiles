local lspconfig = require('lspconfig')

vim.o.updatetime = 300


vim.api.nvim_create_autocmd("CursorHold", {
    pattern = '*',
    command = 'lua vim.diagnostic.open_float(nil, { focusable = false })',
    group = 'lsp',
})

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local map = vim.api.nvim_set_keymap

    local opts = { noremap = true, silent = true }

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    buf_set_keymap('n', '<f2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    buf_set_keymap('n', '<f5>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

    map('n', 'g(', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
    map('n', 'g)', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
end

for _, lsp in ipairs({"rust_analyzer"}) do
    lspconfig[lsp].setup({ on_attach = on_attach })
end


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
    }
)


local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { text = sign.text, texthl = sign.name })
end
