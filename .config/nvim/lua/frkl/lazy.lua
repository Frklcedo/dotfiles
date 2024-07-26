local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
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
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
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
          files = {"src/parser.c"},
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
  "mbbill/undotree",
  "tpope/vim-fugitive",
  {
    "mattn/emmet-vim",
    lazy = false,
    -- config = function ()
      --     vim.g.user_emmet_leader_key = "<M-,>"
      --     vim.api.nvim_exec([[
      --         let g:user_emmet_leader_key = '<M-,>'
      --     ]], false)
      -- end
    },


    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = { "rafamadriz/friendly-snippets" },
    },
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {"hrsh7th/cmp-buffer"},
    {"hrsh7th/cmp-path"},
    {"hrsh7th/cmp-cmdline"},
    {'hrsh7th/nvim-cmp'},
    {"saadparwaiz1/cmp_luasnip"},

    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      opts = {
        check_ts = true,
        fast_wrap = {
          map = "<M-w>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = [=[[%'%"%>%]%)%}%,]]=],
          end_key = "$",
          before_key = "h",
          after_key = "l",
          cursor_pos_before = true,
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          manual_position = true,
          highlight = "Search",
          highlight_grey = "Comment",
        },
      }
    },
    {"windwp/nvim-ts-autotag"},

    {
      "numToStr/Comment.nvim",
      lazy = false
    },
    {"JoosepAlviste/nvim-ts-context-commentstring"},
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    { "lambdalisue/suda.vim" },
    -- {
    --   "nvim-tree/nvim-tree.lua",
    --   dependencies = { 'nvim-tree/nvim-web-devicons' },
    --   config = function ()
    --     -- disable netrw at the very start of your init.lua
    --     vim.g.loaded_netrw = 1
    --     vim.g.loaded_netrwPlugin = 1
    --   end
    -- },
    {
      'stevearc/oil.nvim',
      opts = {},
      -- Optional dependencies
      -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
      dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    },

    {
      "brenoprata10/nvim-highlight-colors",
      config = function ()
        require('nvim-highlight-colors').setup({})
      end
    },

  })
