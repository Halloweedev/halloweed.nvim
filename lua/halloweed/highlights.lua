
local M = {}

function M.setup(colors)
  local highlights = {
    Normal       = { fg = colors.fg, bg = colors.bg },
    NormalNC     = { fg = colors.fg, bg = colors.menu },
    CursorLine   = { bg = colors.gray },
    CursorLineNr = { fg = colors.orange },
    LineNr       = { fg = colors.darker_gray },
    VertSplit    = { fg = colors.gray },
    Visual       = { bg = colors.gray },
    Search       = { fg = colors.black, bg = colors.yellow },
    Comment      = { fg = colors.darker_gray, italic = true },
    Constant     = { fg = colors.orange },
    String       = { fg = colors.green },
    Character    = { fg = colors.green },
    Number       = { fg = colors.orange },
    Boolean      = { fg = colors.orange },
    Float        = { fg = colors.orange },
    Identifier   = { fg = colors.cyan },
    Function     = { fg = colors.blue },
    Statement    = { fg = colors.red },
    Conditional  = { fg = colors.red },
    Repeat       = { fg = colors.red },
    Label        = { fg = colors.yellow },
    Operator     = { fg = colors.fg },
    Keyword      = { fg = colors.red },
    Exception    = { fg = colors.red },
    Type         = { fg = colors.purple },
    StorageClass = { fg = colors.purple },
    Structure    = { fg = colors.purple },
    Typedef      = { fg = colors.purple },
    Special      = { fg = colors.yellow },
    Underlined   = { underline = true },
    Todo         = { fg = colors.red, bg = colors.yellow },
    Error        = { fg = colors.red },
    WarningMsg   = { fg = colors.orange },

    -- some UI extras
    Pmenu        = { fg = colors.fg, bg = colors.gray },
    PmenuSel     = { fg = colors.black, bg = colors.orange },
    StatusLine   = { fg = colors.fg, bg = colors.menu },
    Title        = { fg = colors.purple, bold = true },
  }

  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

return M

