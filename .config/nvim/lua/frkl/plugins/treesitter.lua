
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

      configs.setup({
        ensure_installed = { "php", "html", "css", "javascript", "json", "vue", "c", "lua", "vim", "vimdoc", "query" },
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "php", "blade" },
        },
        indend = { enable = true },
        autotag = { enable = true }
      })

      parser_config.blade = {

        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade"
      }

      vim.filetype.add({
        pattern = {
          ['.*%.blade%.php'] = 'blade',
        },
      })
    end
  },
  "nvim-treesitter/nvim-treesitter-context",

  { "windwp/nvim-ts-autotag" },

  {
    "numToStr/Comment.nvim",
    lazy = false
  },
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  { "lukas-reineke/indent-blankline.nvim",        main = "ibl", opts = {} },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },

}
