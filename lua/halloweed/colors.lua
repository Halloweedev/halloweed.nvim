
local M = {}

local util = require('halloweed.util')

local palettes = {
    light = {
        bg = "#FAFAFA",
        menu = "#FEFBEF",
        fg = "#5C6773",
        red = "#F72B0B",
        black = "#2C2C2C",
        cyan = "#58C1A6",
        orange = "#FF6700",
        gray = "#F0EFEB",
        blue = "#5262AD",
        green = "#63C82D",
        yellow = "#FFDB4D",
        purple = "#8638E5",
        darker_gray = "#ABB0B6",
    },
    -- future dark variants here
}

-- Add derived colors after base palette is declared to avoid circular refs
palettes.light.cursorline_bg = util.darken(palettes.light.bg, 0.05)
palettes.light.light_orange = util.lighten(palettes.light.orange, 0.2)

function M.setup(style)
    return palettes[style] or palettes["light"]
end

return M

