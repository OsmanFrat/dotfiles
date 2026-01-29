local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node

ls.add_snippets("org", {
  s("fila", {
    t({ "#+begin_src sh", "" }),
    i(0),
    t({ "", "#+end_src" }),
  }),
})

