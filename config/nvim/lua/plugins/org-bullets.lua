return {
  {
    "nvim-orgmode/org-bullets.nvim",
    dependencies = {
      "nvim-orgmode/orgmode",
    },
    config = function()
      require("org-bullets").setup({
  symbols = {
    headlines = { "◉", "○", "✸", "✿" },
    checkboxes = {
      half = { "", "OrgTSCheckboxHalfChecked" },
      done = { "✓", "OrgDone" },
      todo = { " ", "OrgTODO" },
    },
    end,
  },
}
