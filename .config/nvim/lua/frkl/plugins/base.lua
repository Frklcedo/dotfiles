return {
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    -- config = function()
    --   vim.cmd([[colorscheme tokyonight]])
    -- end,
  },
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      --[[ require("onedarkpro").setup({
        options = {
          transparency = true
        }
      }) ]]
      vim.cmd([[colorscheme onedark]])
    end,
  },

  "mbbill/undotree",
  "tpope/vim-fugitive",

  { "lambdalisue/suda.vim" },
}
