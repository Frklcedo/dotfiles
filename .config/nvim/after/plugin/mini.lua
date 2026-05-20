local installed, mini = pcall(require, 'mini.ai')

if not installed then
    vim.notify("'mini.nvim' not installed", vim.log.levels.ERROR)
    return
end

require('mini.extra').setup()
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
require('frkl.mini.pick')
require('frkl.mini.indentscope')
require('frkl.mini.statusline')

vim.api.nvim_set_keymap('n', '<leader>bk', ':lua MiniBufremove.delete()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bK', ':lua MiniBufremove.wipeout()<CR>', { noremap = true, silent = true })

