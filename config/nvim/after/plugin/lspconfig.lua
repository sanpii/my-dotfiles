local lspconfig = require('lspconfig')

vim.o.updatetime = 300

vim.api.nvim_create_autocmd("CursorHold", {
    pattern = '*',
    command = 'lua vim.diagnostic.open_float(nil, { focusable = false })',
    group = 'lsp',
})

local on_attach = function(client, bufnr)
    local function buf_set_keymap(mode, lhs, callback)
        local opts = { noremap = true, silent = true, callback = callback }

        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, '', opts)
    end

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    buf_set_keymap('n', 'gd', vim.lsp.buf.definition)
    buf_set_keymap('n', '<f2>', vim.lsp.buf.rename)
    buf_set_keymap('n', '<f5>', vim.lsp.buf.code_action)

    vim.keymap.set('n', 'g(', vim.diagnostic.goto_prev)
    vim.keymap.set('n', 'g)', vim.diagnostic.goto_next)

    client.server_capabilities.semanticTokensProvider = nil
end

lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                features = "all",
            },
        },
    },
})

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
