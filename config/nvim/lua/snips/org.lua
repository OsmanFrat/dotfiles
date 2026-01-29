local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node

ls.add_snippets("org", {
  s(
    {
      trig = "<sh",
      wordTrig = false,
    },
    {
      t({ "#+begin_src sh", "" }),
      i(0),
      t({ "", "#+end_src" }),
    }
  ),
})

