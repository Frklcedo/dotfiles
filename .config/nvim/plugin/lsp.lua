vim.lsp.enable("phpactor")
vim.lsp.enable({ "ts_ls", "vue_ls" })
vim.lsp.enable("lua_ls")

local setup_mason = function ()
    local installed, mason = pcall(require, "mason")
    if not installed then
        vim.notify("'mason' not installed", vim.log.levels.ERROR)
        return
    end
    mason.setup()
end

setup_mason()
