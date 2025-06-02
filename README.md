# halloweed.nvim

🎨 A minimalist light Neovim colorscheme with a soft, clean, and readable palette.  
Perfect for daytime development, clarity-focused workflows, and those who like their editor bright but not blinding.

![License](https://img.shields.io/github/license/yourname/halloweed.nvim)
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

⚙️ Configuration

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
