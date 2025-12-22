
return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-mini/mini.icons',
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        indent = {
            enabled = false,
            render_modes = false,
            per_level = 2,
            skip_level = 1,
            skip_heading = false,
            icon = '▎',
            priority = 0,
            highlight = 'RenderMarkdownIndent',
        },

        bullet = {
            enabled = true,
            render_modes = false,
            icons = { '●', '○', '◆', '◇' },

            ordered_icons = function(ctx)
                local value = vim.trim(ctx.value)
                local index = tonumber(value:sub(1, #value - 1))
                return ('%d.'):format(index > 1 and index or ctx.index)
            end,

            left_pad = 0,
            right_pad = 0,
            highlight = 'RenderMarkdownBullet',
            scope_highlight = {},
            scope_priority = nil,
        },
    },
}

