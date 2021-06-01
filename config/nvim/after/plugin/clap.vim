lua << EOF

vim.g.clap_theme = 'material_design_dark'
vim.g.clap_insert_mode_only = true
vim.g.clap_open_preview = 'never'

function ctrlp()
    local dir = vim.fn.expand('%:h')

    vim.cmd('Clap files')

    if dir ~= '' and dir ~= '.' then
        vim.api.nvim_feedkeys(dir .. '/', 'i', false)
    end
end

function clap_switch(order)
    local providers = {'files', 'buffers', 'history'}
    local current_provider = vim.g.clap.provider.id
    local current_id = 0

    for x, provider in ipairs(providers) do
        if provider == current_provider then
            current_id = x
            break
        end
    end

    if order > 0 then
        current_id = current_id % table.getn(providers) + 1
    else
        if current_id > 1 then
            current_id = current_id - 1
        else
            current_id = table.getn(providers)
        end
    end

    vim.cmd('Clap ' .. providers[current_id])
end

EOF

nnoremap <silent> <c-p> :call v:lua.ctrlp()<cr>

autocmd FileType clap_input inoremap <silent> <buffer> <c-t> <c-r>=clap#navigation#linewise('down')<cr>
autocmd FileType clap_input inoremap <silent> <buffer> <c-s> <c-r>=clap#navigation#linewise('up')<cr>
autocmd FileType clap_input inoremap <silent> <buffer> <c-p> <esc>:call v:lua.clap_switch(-1)<cr><right>
autocmd FileType clap_input inoremap <silent> <buffer> <c-f> <esc>:call v:lua.clap_switch(+1)<cr>
