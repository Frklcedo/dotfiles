local installed, conform = pcall(require, 'conform')

if not installed then
    vim.notify("'conform' not installed", vim.log.levels.ERROR)
    return
end

conform.setup({
    formatters_by_ft = {
        php = { "pint" },
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        vue = { "prettierd", "prettier", stop_after_first = true },
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
    formatters = {
        prettierd = {
            env = string.format(
                "PRETTIERD_DEFAULT_CONFIG=%s",
                vim.fn.expand("~/.config/nvim/utils/formatters/.prettierrc.json")
            ),
        },
        ["clang-format"] = {
            append_args = {
                "--style={BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Never, ColumnLimit: 120, BreakBeforeBraces: Allman, AllowShortFunctionsOnASingleLine: None, SpacesInParentheses: false}",
            },
        },
    },
})
