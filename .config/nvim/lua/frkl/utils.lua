
function _G.with_desc(opts, desc)
    return vim.tbl_extend("force", opts, { desc = desc })
end
