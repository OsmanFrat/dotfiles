return {
  "loctvl842/monokai-pro.nvim",
  priority = 1000,
  config = function()
    require("monokai-pro").setup({
      transparent_background = false,
      terminal_colors = true,
      devicons = true,
      styles = {
        comment = { italic = false},
        keyword = { italic = false },
        type = { italic = false },
        storageclass = { italic = false },
        structure = { italic = false },
        parameter = { italic = false },
        annotation = { italic = false },
        tag_attribute = { italic = false },
      },
      filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
      day_night = {
        enable = false,
        day_filter = "pro",
        night_filter = "spectrum",
      },
      inc_search = "background",
      background_clear = {
        "toggleterm",
        "telescope",
        "which-key",
        "renamer",
        "alpha",
        "notify",
      },
      plugins = {
        bufferline = {
          underline_selected = false,
          underline_visible = false,
        },
        indent_blankline = {
          context_highlight = "default",
          context_start_underline = false,
        },
      },
    })

    vim.cmd.colorscheme("monokai-pro")
  end
}
