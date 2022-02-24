-- Général {{{
    vim.cmd('augroup buffer')
        vim.cmd('autocmd!')
    vim.cmd('augroup END')
    vim.cmd('augroup filetype')
        vim.cmd('autocmd!')
    vim.cmd('augroup END')

    local vimfiles = vim.env.HOME .. '/.config/nvim'

    vim.o.fileformats = 'unix'
    vim.o.foldmethod = 'marker'
    vim.o.number = true
    vim.o.relativenumber = true

    vim.o.spelllang = 'fr'
    vim.o.wrap = false

    vim.cmd('augroup buffer')
        vim.cmd('autocmd bufwritepost ' .. vimfiles .. '/init.lua luafile %')
    vim.cmd('augroup END')

    vim.o.textwidth = 80
    vim.o.colorcolumn = '+1'

    vim.o.inccommand = 'split'

    vim.o.splitbelow = true
-- }}}
-- Apparence {{{
    vim.cmd('colorscheme tango')

    vim.o.termguicolors = true
    vim.o.list = true
    vim.o.listchars='tab:»·,trail:·,precedes:…,extends:…,nbsp:‗'
    vim.o.showbreak='↪'
    vim.o.scrolloff=3
    vim.opt.fillchars:append {eob = ' '}

    vim.cmd("highlight NonText gui=bold guifg=darkgrey")
    vim.cmd("highlight SpecialKey gui=bold guifg=darkgrey")
-- }}}
-- Indentation {{{
    vim.o.smartindent = true
    vim.o.shiftwidth = 4
    vim.o.shiftround = true
    vim.o.tabstop = 4
    vim.o.softtabstop = 4
    vim.o.expandtab = true
    vim.o.breakindent = true
    vim.o.breakindentopt = 'shift:2'
    vim.o.showbreak = '↳'

    vim.cmd('augroup filetype')
        vim.cmd('autocmd FileType make setlocal noexpandtab')
        vim.cmd('autocmd FileType html setlocal indentkeys-=*<Return>')
    vim.cmd('augroup END')
-- }}}
-- Sauvegardes {{{
    vim.o.backupdir = os.getenv('HOME') .. '/.local/share/nvim/backup'

    vim.o.backup = true
    vim.o.undofile = true

    vim.cmd('augroup buffer')
        vim.cmd('autocmd BufWinLeave *? silent! mkview')
        vim.cmd('autocmd BufWinEnter *? silent! loadview')
    vim.cmd('augroup END')

-- }}}
-- Mappage {{{
    local map = vim.api.nvim_set_keymap

    vim.cmd('cabbrev h vert bo help')

    -- http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
    map('i', '<c-u>', '<c-g>u<c-u>', {noremap = true})
    map('i', '<c-w>', '<c-g>u<c-w>', {noremap = true})

    -- Re-selectionner le texte précédemment collé
    map('n', '<leader>v', 'V`]', {noremap = true})

    map('n', '<leader>ev', ':tabnew $MYVIMRC<CR>', {noremap = true})

    map('n', '<leader>P', ':setl paste!<CR>', {noremap = true})
    map('n', '<leader>wp', ':setl wrap!<CR>', {noremap = true})
    map('n', '<leader>sp', ':setl spell!<CR>', {noremap = true})
    map('n', '<leader>h', ':edit %:h<CR>', {noremap = true})

    map('i', 'dp', '<esc>', {noremap = true})
    map('i', '<esc>', '<nop>', {noremap = true})

    map('n', 'B', '^', {noremap = true})
    map('n', 'É', '$', {noremap = true})
    map('n', 'é', 'w', {noremap = true})
    map('n', '$', '<nop>', {noremap = true})
    map('n', '^', '<nop>', {noremap = true})

    map('n', '<C-l>', ':nohl<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>', {noremap = true, silent = true})
-- }}}

local local_vim = vimfiles .. '/local.vim'
local f = io.open(local_vim, 'r')
if f ~= nil then
    io.close(f)
    vim.cmd('source ' .. local_vim)
end
