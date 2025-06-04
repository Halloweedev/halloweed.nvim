local M = {}

local palettes = {
    light = {
        bg = "#FFFFFF",
        bg_inactive = "#FAFAFA",
        menu = "#FAFAFA",
        beige = "#FEFBEF",
        fg = "#5C6773",
        red = "#F72B0B",
        black = "#2C2C2C",
        cyan = "#58C1A6",
        orange = "#FF7D1C",
        blue = "#37B3F1",
        green = "#63C82D",
        yellow = "#F2AE49",
        purple = "#8638E5",
        gray = "#F0EFEB",
        darker_gray = "#ABB0B6",
        lighter_gray = "#F8F8F8",
        cursor_lines = "#FFFBFA",

        -- Derived colors (now hardcoded hex values, no longer using util.darken)
        diff_add = "#E6FFED", -- Light green for added lines
        diff_change = "#FFFBE6", -- Light yellow for changed lines
        diff_delete = "#FFE6E6", -- Light red for deleted lines
        diff_text = "#FFF0B3", -- Slightly darker yellow for changed text

        -- Hardcoded darker versions of colors for explicit control
        dark_red = "#D4260A",    -- Slightly darker red
        dark_purple = "#7630C1", -- Slightly darker purple
        dark_yellow = "#E0C845", -- Slightly darker yellow
        dark_cyan = "#4DA891",   -- Slightly darker cyan

        bg_darker_sidebar = "#F5F5F5", -- Slightly darker background for sidebars (explicit hex)
    },
    -- future dark variants here
}

function M.setup(style)
    return palettes[style] or palettes["light"]
end

return M

