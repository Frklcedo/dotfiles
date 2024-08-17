local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.filetype_extend("php", { "html" })
ls.filetype_extend("blade", { "php", "html" })
ls.add_snippets("php", {
  s("php", {
    t({ "<?php " }),
    i(1),
    t(" ?>"),
  }),
})
ls.add_snippets("php", {
  s("phpe", {
    t({ "<?= " }),
    i(1),
    t(" ?>"),
  }),
})

