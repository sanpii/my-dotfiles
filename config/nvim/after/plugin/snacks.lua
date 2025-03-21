-- https://gist.github.com/VADemon/afb10dbb0d10d99aeb21449752da6285
do
    local function regexEscape(str)
        return str:gsub("[%(%)%.%%%+%-%*%?%[%^%$%]]", "%%%1")
    end

    string.replace = function (s, pattern, repl)
        return s:gsub(regexEscape(pattern), repl:gsub("%%", "%%%%"))
    end

    string.start_with = function (s, pattern)
        for x in s:gmatch('^' .. regexEscape(pattern)) do
            return true
        end
        return false
    end
end

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
                    ["<Esc>"] = { "close", mode = { "i", "n" } },
                    ["<c-f>"] = { "next_layout", mode = { "i", "n" } },
                    ["<c-p>"] = { "prev_layout", mode = { "i", "n" } },
                    ["<c-s>"] = { "list_up", mode = { "i", "n" } },
                    ["<c-t>"] = { "list_down", mode = { "i", "n" } },
                    ["<c-u>"] = { "<Esc>ddi", mode = { "i" }, expr = true },
                    ["<c-y>"] = { "create_file", mode = { "i", "n" } },
                    ["<tab>"] = { "cmp", mode = { "i" } },
                },
            },
        },
        actions = {
            cmp = function(picker)
                local prompt = picker.input:get()
                local entry = picker.list:current()

                if entry ~= nil
                then
                    local selection = entry.file:gsub(picker:cwd(), '')
                    selection = selection:gsub('^/', '')

                    if selection:start_with(prompt)
                    then
                        selection = selection:gsub(prompt, '')
                        if selection:find('/')
                        then
                            prompt = prompt .. selection:match('[^/]*/')
                        end
                    else
                        prompt = selection:gsub('/[^/]+$', '/')
                    end
                end

                picker.input:set(prompt)
            end,
            create_file = function(picker)
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
