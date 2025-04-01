vim.lsp.enable({'rust-analyzer'})

vim.o.updatetime = 300

vim.api.nvim_create_autocmd('CursorHold', {
    pattern = '*',
    command = 'lua vim.diagnostic.open_float(nil, { focusable = false })',
    group = 'lsp',
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
    end
});

vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<f2>', vim.lsp.buf.rename)
vim.keymap.set('n', '<f5>', vim.lsp.buf.code_action)
vim.keymap.set('n', 'g(', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'g)', vim.diagnostic.goto_next)

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
            [vim.diagnostic.severity.HINT] = '󰠠 ',
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
            [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
        },
    },
})
