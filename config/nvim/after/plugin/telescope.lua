local actions = require('telescope.actions')
local actions_state = require('telescope.actions.state')
local builtin = require('telescope.builtin')

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

pickers = {
    builtin.find_files,
    builtin.buffers,
    builtin.oldfiles,
    index = 1,
}

pickers.next = function()
    if pickers.index >= #pickers then
        pickers.index = 1
    else
        pickers.index = pickers.index + 1
    end
    pickers[pickers.index] { default_text = actions_state.get_current_line() }
end

pickers.prev = function()
    if pickers.index <= 1 then
        pickers.index = #pickers
    else
        pickers.index = pickers.index - 1
    end
    pickers[pickers.index] { default_text = actions_state.get_current_line() }
end

require('telescope').setup{
    defaults = {
        preview = false,
        mappings = {
            i = {
                ['<esc>'] = actions.close,
                ['<c-u>'] = false,
                ['<c-t>'] = actions.move_selection_next,
                ['<c-s>'] = actions.move_selection_previous,
                ['<c-f>'] = pickers.next,
                ['<c-p>'] = pickers.prev,
                ['<c-y>'] = function(prompt_bufnr)
                    local file = actions_state.get_current_picker(prompt_bufnr):_get_prompt();

                    actions.close(prompt_bufnr)
                    vim.cmd('edit ' .. file)
                end,
                ['<tab>'] = function(prompt_bufnr)
                    local picker = actions_state.get_current_picker(prompt_bufnr)
                    local prompt = picker:_get_prompt();
                    local entry = actions_state.get_selected_entry()

                    if entry ~= nil then
                        local selection = entry.path:gsub(entry.cwd, '')
                        selection = selection:gsub('^/', '')

                        if selection:start_with(prompt) then
                           selection = selection:gsub(prompt, '')
                           if selection:find('/') then
                              prompt = prompt .. selection:match('[^/]*/')
                           end
                        else
                            prompt = selection:gsub('/[^/]+$', '/')
                        end
                    end

                    picker:set_prompt(prompt)
                end,
            },
        },
    },
    pickers = {
        find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
    },
}

open = function()
    local cwd = vim.fn.expand('%:h')
    builtin.find_files()

    if cwd ~= '' and cwd ~= '.' then
        local prompt_bufnr = vim.api.nvim_get_current_buf()
        actions_state.get_current_picker(prompt_bufnr):set_prompt(cwd .. '/')
    end
end

vim.keymap.set('n', '<c-p>', open, {})
