# halloweed.nvim

🎨 A minimalist light Neovim colorscheme with a soft, clean, and readable palette.  
Perfect for daytime development, clarity-focused workflows, and those who like their editor bright but not blinding.

![License](https://img.shields.io/github/license/halloweedev/halloweed.nvim)
![Neovim](https://img.shields.io/badge/Neovim-0.7%2B-blueviolet)

---

## ✨ Features

- Beautiful soft-light theme inspired by modern UI minimalism  
- Support for terminal colors  
- Treesitter, LSP, and basic plugin highlights  
- Easy to extend and override  
- Fast and lightweight (pure Lua)

---

## 📦 Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "yourname/halloweed.nvim",
  name = "halloweed",
  lazy = false,
  priority = 1000,
  config = function()
    require("halloweed").setup()
    vim.cmd("colorscheme halloweed")
  end
}

Using packer.nvim

use {
  "yourname/halloweed.nvim",
  config = function()
    require("halloweed").setup()
    vim.cmd("colorscheme halloweed")
  end
}

---

### ⚙️ Configuration

require("halloweed").setup({
  style = "light",        -- only 'light' supported for now
  transparent = false,    -- don't set background
  term_colors = true,     -- enable terminal colors
})

You can override specific colors or highlight groups via:

require("halloweed").setup({
  colors = {
    red = "#FF0000", -- example override
  },
  highlights = {
    Comment = { fg = "#999999", italic = true },
  }
})

---

### 🖥️ UI + Window Highlights

    Normal: Main window text (foreground) and background when Neovim is focused.
    NormalNC: Same as Normal, but for non-active windows or when Neovim loses focus.
    CursorLine: Highlights the entire line under the cursor (background only).
    CursorLineNr: The line number of the current line. Makes it stand out.
    CursorColumn: Highlights the entire column under the cursor (use with :set cursorcolumn).
    LineNr: Line numbers on the side (non-cursor line).
    VertSplit: The vertical line between split windows (i.e., |).
    Visual: Background when selecting text in visual mode.
    Search: Highlight for search results (e.g., using /).
    StatusLine: The bottom line (shows filename, mode, etc.).
    Title: Used for titles (e.g., :help, plugins, popups).

🧠 Syntax Highlighting

    Comment: Used for code comments.
    Constant: General constants (overrides below if not specified).
    String, Character: Text in quotes (e.g., "hello", 'a').
    Number, Float, Boolean: Numeric literals, booleans like true, false.
    Identifier: Names of variables, properties.
    Function: Function names and calls.
    Statement: Keywords like if, for, return, etc.
    Conditional, Repeat, Label, Operator, Keyword, Exception: Subcategories of Statement.
    Type, StorageClass, Structure, Typedef: Data types (e.g., int, class, struct).
    Special: Anything special (often used for escapes, brackets, etc).
    Underlined: Underlined text, often used in markdown or links.
    Todo: Matches TODO/FIXME comments.

⚠️ Messages and Prompts

    Error: Used for errors.
    WarningMsg: Warnings (e.g., missing file, etc).

🍱 Menus and Popups

    Pmenu: Popup menu (like completion menu).
    PmenuSel: Selected item in that popup.

🧩 File Structure

halloweed.nvim/
├── lua/halloweed/
│   ├── init.lua        -- Main entry
│   ├── colors.lua      -- Color palette definitions
│   ├── highlights.lua  -- Highlight group mappings
│   ├── terminal.lua    -- Terminal color setup
│   └── util.lua        -- Color utility functions

📸 Screenshot

    Coming soon! (Feel free to open a PR with your setup) free to open a PR with your setup)
