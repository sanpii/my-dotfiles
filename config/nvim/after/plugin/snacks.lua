local layouts = {
    'files',
    'buffers',
    'recent',
    index = 1,
}

layouts.next = function(picker)
    layouts.index = layouts.index % #layouts + 1
    picker:close()
    open(layouts[layouts.index])
end

layouts.prev = function(picker)
    if layouts.index <= 1 then
        layouts.index = #layouts
    else
        layouts.index = layouts.index - 1
    end
    picker:close()
    open(layouts[layouts.index])
end

require('snacks').setup({
    picker = {
        sources = {
            buffers = {
                layout = {
                    preview = false,
                },
            },
            files = {
                layout = {
                    preview = false,
                },
            },
            recent = {
                layout = {
                    preview = false,
                },
            },
        },
        win = {
            input = {
                keys = {
                    ["<c-f>"] = { "next_layout", mode = { "i", "n" } },
                    ["<c-p>"] = { "prev_layout", mode = { "i", "n" } },
                    ["<c-u>"] = { "clear", mode = { "i" } },
                },
            },
        },
        actions = {
            clear = function(picker)
                picker.input:set("", "")
            end,
            create_file = function(picker)
                print('create_file')
                local file = picker.input:get()

                picker:close()
                vim.cmd('edit ' .. file)
            end,
            next_layout = function(picker)
                layouts.next(picker)
            end,
            prev_layout = function(picker)
                layouts.prev(picker)
            end,
        },
    },
})

open = function(type)
    local cwd = vim.fn.expand('%:h')
    local picker = Snacks.picker(type, opts)

    if cwd ~= '' and cwd ~= '.' then
        picker.input.filter.pattern = cwd .. '/'
    end
end

vim.keymap.set('n', '<c-p>', function() open('files') end)
vim.keymap.set('n', '<leader>u', '<cmd>lua Snacks.picker.undo()<cr>')

vim.api.nvim_command('highlight! link SnacksPickerDir SnacksPickerFile')
