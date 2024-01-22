vim.opt.background  = 'dark'
vim.g.colors_name   = "darcula-custom"

local lush          = require('lush')
local darcula_solid = require('lush_theme.darcula-solid')
local hsl           = lush.hsl


-- Base colors
local c0 = hsl(240, 1, 15)
local c1 = c0.lighten(5)
local c2 = c1.lighten(2)
local c3 = c2.lighten(20).sa(10)
local c4 = c3.lighten(10)
local c5 = c4.lighten(20)
local c6 = c5.lighten(70)
local c7 = c6.lighten(80)


-- Background
local bg     = c0 -- base background
local overbg = c1 -- other backgrounds
local subtle = c2 -- out-of-buffer elements


-- Elements
local fg      = hsl(210, 7, 82)
local visual  = hsl(220, 54, 28) -- visual mode
local comment = hsl(0, 0, 54)    -- comments
local folder  = hsl(202, 9, 57)
local treebg  = hsl(220, 3, 19)
local mid     = c2.lighten(10) -- either foreground or background
local faded   = fg.darken(45)  -- non-important text elements
local pop     = c7


-- Color palette
local red     = hsl(1, 77, 62)
local salmon  = hsl(10, 90, 70)
local orange  = hsl(27, 61, 50)
local yellow  = hsl(37, 100, 71)

local green   = hsl(83, 27, 53)
local teal    = hsl(150, 40, 50)
local cyan    = hsl(180, 58, 38)

local blue    = hsl(215, 80, 63).li(10)
local purple  = hsl(279, 30, 62)
local magenta = hsl(310, 40, 70)


-- GUI options
local bold, italic, underline = 'bold', 'italic', 'underline'

---@diagnostic disable: undefined-global
local spec                    = lush.extends({ darcula_solid }).with(function(inject_functions)
    local sym = inject_functions.sym
    return {
        DiagnosticError { fg = red },

        -- Type { fg = orange },
        sym "@type.builtin" { fg = orange },
        sym "@string.escape" { fg = yellow, gui = bold },
        sym "@punctuation.special" { fg = yellow, gui = bold },
        Visual { bg = visual },    -- Visual mode selection
        VisualNOS { bg = visual }, -- Visual mode selection when Vim is "Not Owning the Selection".
        -- MatchParen { fg = yellow, bg = mid, gui = bold },

        -- nvim-tree
        NvimTreeNormal { fg = fg, bg = bg },
        NvimTreeNormalFloat { fg = fg, bg = bg },
        NvimTreeRootFolder { fg = fg, gui = "bold, italic" },
        NvimTreeModifiedFile { fg = yellow },
        NvimTreeFolderIcon { fg = blue },

        NvimTreeGitNew { fg = green }, -- git icon
        NvimTreeGitDeleted { fg = red },
        NvimTreeFileRenamed { fg = yellow },
        NvimTreeFileMerge { fg = yellow },

        NvimTreeFileStaged { fg = fg }, -- file name
        NvimTreeFileNew { fg = green },
        NvimTreeFileIgnored { fg = comment },
        NvimTreeFileDirty { fg = yellow },

        NvimTreeFolderIgnored { fg = comment }, -- folder name
        NvimTreeFolderStaged { fg = blue },
        NvimTreeFolderNew { fg = blue },
        NvimTreeFolderDirty { fg = blue },

        -- telescope
        TelescopePromptCounter { fg = fg },

        -- neo-tree
        NeoTreeTitleBar { fg = comment },
    }
end)

lush(spec)
