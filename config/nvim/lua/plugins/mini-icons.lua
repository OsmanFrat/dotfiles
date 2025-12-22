
return {
  'nvim-mini/mini.icons',
  version = false,
  opts = {
    -- Icon style: 'glyph' or 'ascii'
    style = 'glyph',

    -- Customize per category
    default   = {},
    directory = {},
    extension = {},
    file      = {},
    filetype  = {},
    lsp       = {},
    os        = {},

    -- Control which extensions will be considered during "file" resolution
    use_file_extension = function(ext, file)
    -- use_file_extension = function(md, markdown)
      return true
    end,
  },
}

