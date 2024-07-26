local nvimtree = pcall(require, "nvim-tree")

if not nvimtree then
  vim.notify('nvim-tree not found')
else

  -- optionally enable 24-bit colour

  vim.opt.termguicolors = true

  -- empty setup using defaults

  nvimtree.setup(
  {
    on_attach = function (bufnr)
      local api = require "nvim-tree.api"

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      vim.keymap.set('n', 'l', api.tree.change_root_to_node, opts('CD'))
      vim.keymap.set('n', 'h', api.tree.change_root_to_parent, opts('Up'))
    end
    -- filters = {
      --   dotfiles = false,
      -- },
    }
    )

    local opts = { silent = true }

    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
    vim.keymap.set("n", "<leader><C-e>", ":NvimTreeFocus<cr>", opts)
    vim.keymap.set("n", "<leader>E", ":NvimTreeCollapse<cr>", opts)

  end
