local installed, harpoon = pcall(require, "harpoon")

if not installed then
    vim.notify("'harpoon' not installed", vim.log.levels.ERROR)
    return
end

harpoon:setup()

local marks = {
    "w", "e", "r", "t",
    "s", "d", "f", "g",
    "v"
}

vim.keymap.set("n", "<leader>ha", function () harpoon:list():add() end)
vim.keymap.set("n", "<leader><C-h>", function () harpoon.ui:toggle_quick_menu(harpoon:list()) end)

for i, mark in ipairs(marks) do
    vim.keymap.set("n", "<leader>h" .. mark, function () harpoon:list():select(i) end)
end
vim.keymap.set("n", "<leader>hk", function ()
    harpoon:list():prev()
end)
vim.keymap.set("n", "<leader>hj", function ()
    harpoon:list():next()
end)
