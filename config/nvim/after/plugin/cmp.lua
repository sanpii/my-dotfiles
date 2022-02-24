vim.o.completeopt ='menu,menuone,noselect'

local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    formatting = {
        format = lspkind.cmp_format(),
    },
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'vsnip' },
        },
        {
            { name = 'buffer' },
        }
    ),
    experimental = {
        ghost_text = true,
    },
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
}
