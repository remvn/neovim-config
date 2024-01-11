vim.opt.background  = 'dark'
vim.g.colors_name   = "darcula-custom"

local lush          = require('lush')
local darcula_solid = require('lush_theme.darcula-solid')
local hsl           = lush.hsl

local bf, it, un    = 'bold', 'italic', 'underline'
local fg            = hsl(210, 7, 82)
local visual        = hsl(220, 54, 28)

local orange        = hsl(27, 61, 50)
local yellow        = hsl(37, 100, 71)
local red           = hsl(1, 77, 62)

---@diagnostic disable: undefined-global
local spec          = lush.extends({ darcula_solid }).with(function(inject_functions)
    local sym = inject_functions.sym
    return {
        DiagnosticError { fg = red },

        sym "@type.builtin" { fg = orange },
        sym "@string.escape" { fg = yellow, gui = bf },
        Visual { bg = visual },    -- Visual mode selection
        VisualNOS { bg = visual }, -- Visual mode selection when Vim is "Not Owning the Selection".

        NvimTreeRootFolder {},
        TelescopePromptCounter { fg = fg },

        -- TODO test this later
        sym "@punctuation.special" { fg = yellow, gui = bf },
    }
end)

lush(spec)
