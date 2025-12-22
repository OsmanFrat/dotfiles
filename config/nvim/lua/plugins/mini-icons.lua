return
{
  'nvim-mini/mini.icons', version = false,
  -- Icon style: 'glyph' or 'ascii'
  style = 'ascii',

  -- Customize per category. See `:h MiniIcons.config` for details.
  default   = {},
  directory = {},
  extension = {},
  file      = {},
  filetype  = {},
  lsp       = {},
  os        = {},

  -- Control which extensions will be considered during "file" resolution
  use_file_extension = function(ext, file) return true end,
}
