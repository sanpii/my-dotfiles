vim.o.completeopt ='menu,menuone,noselect'

local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
    formatting = {
        format = lspkind.cmp_format(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp.mapping.confirm({ select = false }),
    }),
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
    window = {
        completion = {
            scrollbar = false,
            winhighlight = "Normal:Normal,CursorLine:Visual,Search:None,FloatBorder:Normal",
            border = "single",
            col_offset = -3,
            side_padding = 0,
        },

        documentation = {
            border = "single",
            winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "

            return kind
        end,
    },
})
