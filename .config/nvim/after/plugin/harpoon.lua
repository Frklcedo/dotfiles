local status_ok, h_mark = pcall(require, "harpoon.mark")
if not status_ok then
	vim.notify("harpoon not found!")
end
local h_ui = require("harpoon.ui")

local nav = function (mark)
    h_ui.nav_file(mark)
end

local marks = {
    "w", "e", "r", "t",
    "s", "d", "f", "g",
    "v"
}

vim.keymap.set("n", "<leader>ha", function ()
    h_mark.add_file()
end)
vim.keymap.set("n", "<leader><C-h>", function ()
    h_ui.toggle_quick_menu()
end)
for i, mark in ipairs(marks) do
    vim.keymap.set("n", "<leader>h"..mark, function ()
        nav(i)
    end)
end
vim.keymap.set("n", "<leader>hh", function ()
    h_ui.nav_prev()
end)
vim.keymap.set("n", "<leader>hl", function ()
    h_ui.nav_next()
end)
