return {
  "mrshmllow/orgmode-babel.nvim",
  dependencies = {
    "nvim-orgmode/orgmode",
    "nvim-treesitter/nvim-treesitter"
  },
  cmd = { "OrgExecute", "OrgTangle" },
  opts = {
    -- by default, none are enabled
    langs = { "python", "lua", "c", "cpp", ... },

    -- paths to emacs packages to additionally load
    load_paths = {}
  }
}
