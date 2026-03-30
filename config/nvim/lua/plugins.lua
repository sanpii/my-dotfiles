local v = vim.version.range

local plugins = {
    { name = 'abolish', src = 'https://github.com/tpope/vim-abolish', version = v('1.2') },
    { name = 'automkdir', src = 'https://github.com/mateuszwieloch/automkdir.nvim' },
    { name = 'clam', src = 'https://github.com/sjl/clam.vim', version = v('1.4') },
    { name = 'dial', src = 'https://github.com/monaqa/dial.nvim', version = v('0.5') },
    { name = 'eunuch', src = 'https://github.com/tpope/vim-eunuch', version = v('1.3') },
    { name = 'gnupg', src = 'https://github.com/jamessan/vim-gnupg', version = v('2.7') },
    { name = 'grug-far', src = 'https://github.com/MagicDuck/grug-far.nvim', version = v('1.6') },
    { name = 'heirline', src = 'https://github.com/rebelot/heirline.nvim', version = v('1.0') },
    { name = 'loupe', src = 'https://github.com/wincent/loupe', version = v('1.2') },
    { name = 'lspkind', src = 'https://github.com/onsails/lspkind-nvim' },
    { name = 'lsp-signature', src = 'https://github.com/ray-x/lsp_signature.nvim', version = v('0.3') },
    { name = 'marks', src = 'https://github.com/chentoast/marks.nvim' },
    { name = 'matchtag', src = 'https://github.com/gregsexton/MatchTag' },
    { name = 'numbertoggle', src = 'https://github.com/jeffkreeftmeijer/vim-numbertoggle', version=v('2.1') },
    { name = 'mini', src = 'https://github.com/echasnovski/mini.nvim', version = v('0.17') },
    { name = 'polyglot', src = 'https://github.com/sheerun/vim-polyglot' },
    { name = 'shot-f', src = 'https://github.com/deris/vim-shot-f' },
    { name = 'single-compile', src = 'https://github.com/xuhdev/SingleCompile', version = v('2.12') },
    { name = 'snacks', src = 'https://github.com/folke/snacks.nvim', version = v('2.31') },
    { name = 'splice', src = 'https://github.com/sjl/splice.vim', version = v('1.1') },
    { name = 'tango-dark', src = 'https://github.com/sanpii/tango-dark.vim' },
    { name = 'vimade', src = 'https://github.com/TaDaa/vimade', version = v('2.5') },
    { name = 'troll-stopper', src = 'https://github.com/vim-utils/vim-troll-stopper' },
}

vim.pack.add(plugins)
