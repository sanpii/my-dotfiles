return {
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
