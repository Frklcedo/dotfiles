local oil = pcall(require, "oil")

if not oil then
  vim.notify('oil not found')
end

require("oil").setup({
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<leader>ds"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
    ["<leader>dh"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
    ["<leader>dt"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
    ["<leader>dp"] = "actions.preview",
    ["<leader>dc"] = "actions.close",
    ["<leader>dl"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },
use_default_keymaps = false
})

vim.keymap.set("n", "<leader>e", ":Oil ")
vim.keymap.set("n", "<leader>ee", ":Oil .<cr>")