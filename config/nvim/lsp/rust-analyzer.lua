return {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml', 'Cargo.lock' },
    settings = {
        ["rust-analyzer"] = {
            assist = {
                preferSelf = true,
            },
            cargo = {
                allTargets = true,
                features = "all",
                targetDir = "target/ra",
            },
            checks = {
                allTargets = true,
                command = "clippy",
            },
            completion = {
                callable = {
                    snippets = "none",
                },
                autoimport = {
                    enable = false,
                },
            },
            files = {
                exclude = {
                    "**/.git/**",
                    "**/target/**",
                    "**/node_modules/**",
                    "**/dist/**",
                    "**/out/**"
                },
            },
        },
    }
}
