local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local colors = require('tango-dark.colors').setup()

require('heirline').load_colors(colors)

local expand = {
    provider = '%=',
    hl = { bg = colors.gray },
}

local padding = {
    provider = ' ',
    hl = { bg = colors.gray },
}

local space = {
    provider = ' ',
    hl = { bg = colors.light_gray },
}

local pipe = {
    provider = ' | ',
    hl = { fg = colors.gray },
}

local open = {
    provider = '',
    hl = { fg = colors.light_gray },
}

local close = {
    provider = '',
    hl = { fg = colors.light_gray },
}

local vimode = {
    condition = conditions.is_active,

    open,
    {
        static = {
            mode_names = {
                n = 'N',
                no = 'N?',
                nov = 'N?',
                noV = 'N?',
                ['no\22'] = 'N?',
                niI = 'Ni',
                niR = 'Nr',
                niV = 'Nv',
                nt = 'Nt',
                v = 'V',
                vs = 'Vs',
                V = 'V_',
                Vs = 'Vs',
                ['\22'] = '^V',
                ['\22s'] = '^V',
                s = 'S',
                S = 'S_',
                ['\19'] = '^S',
                i = 'I',
                ic = 'Ic',
                ix = 'Ix',
                R = 'R',
                Rc = 'Rc',
                Rx = 'Rx',
                Rv = 'Rv',
                Rvc = 'Rv',
                Rvx = 'Rv',
                c = 'C',
                cv = 'Ex',
                r = '...',
                rm = 'M',
                ['r?'] = '?',
                ['!'] = '!',
                t = 'T',
            },
            mode_colors = {
                n = colors.light_red,
                i = colors.light_green,
                v = colors.light_blue,
                V =  colors.light_blue,
                ['\22'] =  colors.light_blue,
                c =  colors.cyan,
                s =  colors.purple,
                S =  colors.purple,
                ['\19'] =  colors.purple,
                R =  colors.cyan,
                r =  colors.cyan,
                ['!'] =  colors.red,
                t =  colors.red,
            }
        },

        init = function(self)
            self.mode = vim.fn.mode(1)
        end,
        provider = function(self)
            return '%-05(  '..self.mode_names[self.mode]..'%)'
        end,
        hl = function(self)
            local mode = self.mode:sub(1, 1)
            return { fg = self.mode_colors[mode], bold = true, bg = colors.light_gray }
        end,
        update = {
            'ModeChanged',
            pattern = '*:*',
            callback = vim.schedule_wrap(function()
                vim.cmd('redrawstatus')
            end),
        },
    },
    close,
}

local filetype = {
    init = function(self)
        local extension = vim.fn.fnamemodify(self.filename, ':e')
        _, self.icon_color = require('nvim-web-devicons').get_icon_color(self.filename, extension, { default = true })
    end,
    provider = function(self)
        return vim.bo.filetype
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end
}

local fileicon = {
    init = function(self)
        local extension = vim.fn.fnamemodify(self.filename, ':e')
        self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(self.filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon .. ' '
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end
}

local filename = {
    provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ':.')
        if filename == ''
        then
            return '[No Name]'
        end
        if not conditions.width_percent_below(#filename, 0.5)
        then
            filename = vim.fn.pathshorten(filename)
        end
        return filename
    end,
    hl = { fg = colors.light_blue },
}

local fileflags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = ' [+]',
        hl = { fg = colors.green },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = ' ',
        hl = { fg = colors.cyan },
    },
}

local file = {
    open,
    {
        init = function(self)
            self.filename = vim.api.nvim_buf_get_name(0)
        end,
        hl = { bg = colors.light_gray },
        filename,
        fileflags,
    },
    close,
}

local lsp = {
    condition = conditions.has_diagnostics,

    open,
    {
        static = {
            error_icon = ' ',
            warn_icon = ' ',
            info_icon = ' ',
            hint_icon = ' ',
        },

        init = function(self)
            self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
            self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
            self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
            self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        end,

        update = { 'DiagnosticChanged', 'BufEnter' },
        hl = { bg = colors.light_gray },

        {
            provider = function(self)
                return self.errors > 0 and (self.error_icon .. self.errors .. ' ')
            end,
            hl = { fg = utils.get_highlight('DiagnosticError').fg },
        },
        {
            provider = function(self)
                return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ')
            end,
            hl = { fg = utils.get_highlight('DiagnosticWarn').fg },
        },
        {
            provider = function(self)
                return self.info > 0 and (self.info_icon .. self.info .. ' ')
            end,
            hl = { fg = utils.get_highlight('DiagnosticInfo').fg },
        },
        {
            provider = function(self)
                return self.hints > 0 and (self.hint_icon .. self.hints)
            end,
            hl = { fg = utils.get_highlight('DiagnosticHint').fg },
        },
    },
    close,
}

local encoding = {
    provider = function()
        return (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
    end
}

local format = {
    static = {
        icons = {
            dos = '',
            unix = '',
            mac = '',
        },
    },
    provider = function(self)
        return self.icons[vim.bo.fileformat]
    end
}

local fileinfo = {
    condition = conditions.is_active,
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,

    open,
    {
        hl = { bg = colors.light_gray },
        encoding,
        pipe,
        format,
        pipe,
        fileicon,
        space,
        filetype,
    },
    close,
}

local ruler = {
    provider = '%l:%c',
}

local scrollbar = {
    static = {
        sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
    },
    provider = function(self)
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local x = math.floor((curr_line - 1) / lines * #self.sbar) + 1
        return self.sbar[x]
    end,
    hl = { fg = colors.blue },
}

local position = {
    condition = conditions.is_active,

    open,
    {
        hl = { bg = colors.light_gray },
        ruler,
        space,
        scrollbar,
    },
    close,
}

local statusline = {
    hl = { bg = colors.gray },

    padding,
    vimode,
    padding,
    file,
    expand,
    lsp,
    expand,
    fileinfo,
    padding,
    position,
    padding,
}

local tab = {
    init = function(self)
        local win = vim.api.nvim_tabpage_get_win(self.tabnr)
        local buf = vim.api.nvim_win_get_buf(win)
        self.filename = vim.api.nvim_buf_get_name(buf)
    end,
    hl = function(self)
        if not self.is_active
        then
            return "TabLine"
        else
            return "TabLineSel"
        end
    end,
    {
        provider = function(self)
            local file = vim.fn.fnamemodify(self.filename, ':t')

            return '%' .. self.tabnr .. 'T ' .. self.tabpage .. '. %T'
        end
    },
    fileicon,
    {
        provider = function(self)
            if self.filename == ''
            then
                return '[No Name]'
            else
                return vim.fn.fnamemodify(self.filename, ':t')
            end
        end
    },
}

local tabline = {
    condition = function()
        return #vim.api.nvim_list_tabpages() > 1
    end,
    utils.make_tablist(tab),
}

require('heirline').setup({
    statusline = statusline,
    tabline = tabline,
})
