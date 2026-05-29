local installed, cmp = pcall(require, "blink.cmp")

if not installed then
	vim.notify("'blink.cmp' not installed", vim.log.levels.ERROR)
	return
end

require("frkl.mini.snippets")
cmp.build():wait(60000)

local menu_draw = {
	columns = {
		{ "kind_icon" },
		{ "label", "label_description", gap = 1 },
		{ "kind" },
	},
	components = {
		kind_icon = {
			text = function(ctx)
				if ctx.item.source_name == "LSP" then
					local color_item =
						require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
					if color_item and color_item.abbr ~= "" then
						return color_item.abbr .. ctx.icon_gap
					end
				end
				local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
				return kind_icon
			end,
			highlight = function(ctx)
				if ctx.item.source_name == "LSP" then
					local color_item =
						require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
					if color_item and color_item.abbr_hl_group then
						return color_item.abbr_hl_group
					end
				end

				local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
				return hl
			end,
		},
		kind = {
			highlight = function(ctx)
				local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
				return hl
			end,
		},
	},
}

--@module 'blink.cmp'
--@type blink.cmp.Config
local opts = {
	keymap = {
		preset = "default",
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<CR>"] = { "select_and_accept", "fallback" },
		["<Tab>"] = { "accept", "fallback" },
		["<S-Tab>"] = {},
		["<C-l>"] = { "snippet_forward", "fallback" },
		["<C-h>"] = { "snippet_backward", "fallback" },
		["<C-e>"] = { "hide", "fallback" },
	},

	cmdline = {
		keymap = {
			preset = "cmdline",
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
		},
	},

	sources = {
		default = {
			"lsp",
			"snippets",
			"path",
			"buffer",
			"nvim-px-to-rem",
		},
		per_filetype = {
			sql = { "snippets", "dadbod", "buffer" },
			mysql = { "snippets", "dadbod", "buffer" },
			plsql = { "snippets", "dadbod", "buffer" },
		},
		providers = {
			snippets = {
				opts = {
					friendly_snippets = true,
					-- see the list of frameworks in: https://github.com/rafamadriz/friendly-snippets/tree/main/snippets/frameworks
					-- and search for possible languages in: https://github.com/rafamadriz/friendly-snippets/blob/main/package.json
					extended_filetypes = {
						js = { "vue" },
						php = { "phpdoc" },
						blade = { "blade" },
						mysql = { "sql" },
						plsql = { "sql" },
					},
				},
			},
			["nvim-px-to-rem"] = {
				module = "nvim-px-to-rem.integrations.blink",
				name = "nvim-px-to-rem",
			},
			dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
		},
	},

	completion = {
		list = {
			selection = {
				preselect = false,
				auto_insert = false,
			},
		},
		menu = {
			draw = menu_draw,
			auto_show = function(ctx)
				return ctx.mode ~= "cmdline"
			end,
		},
		documentation = { auto_show = true },
	},

	signature = {
		enabled = true,
		window = {
			direction_priority = { "s", "n" },
		},
	},

	fuzzy = {
		sorts = {
			function(a, b)
				if (a.client_name == nil or b.client_name == nil) or (a.client_name == b.client_name) then
					return
				end
				return b.client_name == "emmet_language_server"
			end,
			"score",
			"sort_text",
		},
	},

	snippets = { preset = 'mini_snippets' },
	-- 'dadbod', 'nvim-px-to-rem',
	-- 'laravel'
}
cmp.setup(opts)
