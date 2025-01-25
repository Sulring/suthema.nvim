# 🎨 suthema.nvim

A minialistic theme manager for Neovim with automatic theme discovery, persistent settings.

## Features
- 🔍 Auto-discovers installed themes
- 🔄 Switch between themes quickly
- 💾 Remembers your last used theme
- ⭐ Set and persist default themes
- 📚 Maintains theme history

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):
```lua
{
    "youruser/suthema.nvim",
    config = function()
        require("suthema").setup({
            -- your configuration
        })
    end,
}
```

## Configuration

```lua
require("suthema").setup({
    keys = {
        toggle = "<leader>th", -- Toggle theme selector
        next = "<leader>tn",   -- Next theme
        prev = "<leader>tp",   -- Previous theme
        set_default = "<C-d>", -- Set as default theme
    },
})
```

## Usage
- `<leader>th`: Open theme selector
- `<leader>tn`: Switch to next theme
- `<leader>tp`: Switch to previous theme
- `<C-d>`: Set current theme as default (in selector)
