local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

return {
    capabilities = capabilities,
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml', 'Cargo.lock' },
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                features = "all",
            },
            completion = {
                callable = {
                    snippets = "none",
                },
            },
        },
    }
}
