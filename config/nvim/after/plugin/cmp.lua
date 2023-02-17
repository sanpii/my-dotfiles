vim.o.completeopt ='menu,menuone,noselect'

local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
    formatting = {
        format = lspkind.cmp_format(),
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp.mapping.confirm({ select = false }),
    },
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp' },
            { name = 'path' },
        },
        {
            { name = 'buffer' },
        }
    ),
    experimental = {
        ghost_text = true,
    },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
}
