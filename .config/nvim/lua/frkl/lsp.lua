local M = {}

M.specs = {
	-- LSP
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
}

local setup_mason = function ()
    local installed, mason = pcall(require, "mason")
    if not installed then
        vim.notify("'mason' not installed", vim.log.levels.ERROR)
        return
    end
    mason.setup()
end

M.setup = function ()
    vim.lsp.enable("phpactor")
    vim.lsp.enable({ "ts_ls", "vue_ls" })
    vim.lsp.enable("lua_ls")

    setup_mason()
end

return M
