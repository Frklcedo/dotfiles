vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Lsp actions",
	callback = function(event)
		local opts = { buffer = event.buf, remap = false }

		vim.keymap.set("n", "<leader>ch", function()
			vim.lsp.buf.hover()
		end, with_desc(opts, "Lsp actions: Display symbol information"))

		vim.keymap.set("i", "<M-i>", function()
			vim.lsp.buf.hover()
		end, with_desc(opts, "Lsp actions: Display symbol information"))

		vim.keymap.set("n", "<leader>cd", function()
			vim.lsp.buf.definition()
		end, with_desc(opts, "Lsp actions: Goto Definition"))

		vim.keymap.set("n", "<leader>cp", function()
			vim.lsp.buf.references()
		end, with_desc(opts, "Lsp actions: List symbol references"))

		vim.keymap.set("n", "<leader>cr", function()
			vim.lsp.buf.rename()
		end, with_desc(opts, "Lsp actions: Rename all symbol references"))

		vim.keymap.set("n", "<leader>ca", function()
			vim.lsp.buf.code_action()
		end, with_desc(opts, "Lsp actions: Select code action"))

		vim.keymap.set("n", "<leader>cs", function()
			vim.lsp.buf.signature_help()
		end, with_desc(opts, "Lsp actions: Display symbol signature help"))

		vim.keymap.set("i", "<C-s>", function()
			vim.lsp.buf.signature_help()
		end, with_desc(opts, "Lsp actions: Display symbol signature help"))

		vim.keymap.set("n", "<leader>cf", function()
			local conform_ok, conform = pcall(require, "conform")
			if conform_ok then
				conform.format({ async = true })
			else
				vim.lsp.buf.format({ async = true })
			end
		end, with_desc(opts, "Lsp actions: Format buffer"))

		vim.keymap.set("n", "<leader>cw", function()
			vim.diagnostic.open_float()
		end, with_desc(opts, "Lsp actions: Display diagnostic"))

		-- vim.keymap.set("n", "<leader>cqq", function()
		-- 	vim.lsp.buf.workspace_symbol()
		-- end, with_desc(opts, "Lsp actions: Search by grep workspace symbol"))

        -- vim.keymap.set("n", "<leader>cqq", function ()
        --     require("mini.extra").pickers.lsp({ scope = "workspace_symbol" })
        -- end, { desc = "Lsp actions: Search workspace symbol"})

        vim.keymap.set("n", "<leader>cW", function()
            vim.diagnostic.setqflist()
        end, with_desc(opts, "Lsp actions: Show diagnostics list"))

        vim.keymap.set("n", "<leader>clq", function ()
            require("mini.extra").pickers.lsp({ scope = "workspace_symbol_live" })
        end, { desc = "Lsp actions: Search workspace symbol"})


        vim.keymap.set("n", "<leader>clw", function ()
            require('mini.extra').pickers.diagnostic()
        end, { desc = "Lsp actions: List lsp diagnostics"})

        vim.keymap.set("n", "<leader>clp", function ()
            require('mini.extra').pickers.lsp({ scope = "references" })
        end, { desc = "Lsp actions: find symbol references"})

	end,
})

local setup_masonlsp = function()
	local installed, mason_lsp = pcall(require, "mason-lspconfig")
	if not installed then
		return
	end

	mason_lsp.setup({
		ensure_installed = { "html", "cssls", "tailwindcss", "jsonls", "emmet_language_server", },
	})
end

setup_masonlsp()
