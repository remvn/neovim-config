local colors = {
    bg        = "#3a3a3b",
    fade      = "#898b8d",
    editor_bg = "#303031",
    text      = "#d6d9dc",
    -- white     = "#e2e5e9",
    white     = "#ffffff",
    black     = '#000000',
    green     = '#9db871',
    orange    = '#e18437',
    gray      = '#adadb1',
}

local default = { fg = colors.text, bg = colors.bg }
local theme = {
    normal = {
        a = default,
        b = default,
        c = default,
        x = default,
        y = { fg = colors.fade, bg = colors.editor_bg },
        z = { fg = colors.black, bg = colors.gray },
    },
    insert = {
        y = { fg = colors.green, bg = colors.editor_bg },
        z = { fg = colors.black, bg = colors.green, },
    },
    visual = {
        y = { fg = colors.orange, bg = colors.editor_bg },
        z = { fg = colors.black, bg = colors.orange, },
    },
    command = {
        y = { fg = colors.white, bg = colors.editor_bg },
        z = { fg = colors.black, bg = colors.white, },
    },
}

return theme
