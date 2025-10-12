require('mini.ai').setup()
require('mini.pairs').setup()
require('mini.surround').setup()
require('mini.icons').setup()
require('mini.git').setup()
require('mini.diff').setup()
require('mini.tabline').setup()
require('mini.icons').setup()
require('mini.splitjoin').setup()
require('mini.operators').setup()
require('mini.bufremove').setup()

vim.api.nvim_set_keymap('n', '<leader>bk', ':lua MiniBufremove.delete()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bK', ':lua MiniBufremove.wipeout()<CR>', { noremap = true, silent = true })

require('mini.comment').setup({
    options = {
        custom_commentstring = function()
            if vim.bo.filetype == "blade" then
                return vim.bo.commentstring
            end
            return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
        end
    }
})

local indentscope = require('mini.indentscope')
indentscope.setup({
    draw = {
        animation = indentscope.gen_animation.none()
    }
})

local statusline = require('mini.statusline');
statusline.setup({
    content = {
        active = function()
            local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
            local git           = statusline.section_git({ trunc_width = 40 })
            -- local diff          = statusline.section_diff({ trunc_width = 75 })
            local diagnostics   = statusline.section_diagnostics({ trunc_width = 75 })
            local lsp           = statusline.section_lsp({ trunc_width = 75 })
            local filename      = statusline.section_filename({ trunc_width = 140 })
            local fileinfo      = statusline.section_fileinfo({ trunc_width = 120 })
            local location      = statusline.section_location({ trunc_width = 75 })
            local search        = statusline.section_searchcount({ trunc_width = 75 })
            return statusline.combine_groups({
                { hl = mode_hl,              strings = { mode } },
                '%<', -- Mark general truncate point
                { hl = 'MiniStatuslineFileName', strings = { filename } },
                '%=', -- End left alignment
                -- { hl = 'statuslineDevinfo',  strings = { diff } },
                { hl = 'MiniStatuslineDevInfo',  strings = { diagnostics, lsp } },
                { hl = 'MiniStatuslineFileInfo', strings = { fileinfo } },
                { hl = 'MiniStatuslineGitInfo',  strings = { git } },
                { hl = mode_hl,              strings = { search, location } },
            })
        end
    }
})
