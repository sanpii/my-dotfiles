require('blink.cmp').setup({
    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
        },
        menu = {
            draw = {
                columns = { { "kind_icon", gap = 1, "label" } },
                components = {
                    kind_icon = {
                        text = function(ctx)
                            local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                            return kind_icon
                        end,
                        highlight = function(ctx)
                            local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                            return hl
                        end,
                    },
                },
            },
        },
    },
    keymap = { preset = 'super-tab' },
    signature = { enabled = true },
})
