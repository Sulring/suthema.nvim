local M = {}

function M.create_window()
    local state = require("suthema.state")
    local config = require("suthema.config").get()

    local width = 60
    local height = 20
    local bufnr = vim.api.nvim_create_buf(false, true)

    local win_opts = {
        relative = "editor",
        width = width,
        height = height,
        col = math.floor((vim.o.columns - width) / 2),
        row = math.floor((vim.o.lines - height) / 2),
        style = "minimal",
        border = "rounded",
        title = " Theme Switcher",
        title_pos = "center",
    }

    local win = vim.api.nvim_open_win(bufnr, true, win_opts)

    -- Populate buffer
    local lines = {}
    local themes = state.get_theme_list()
    local current_theme = state.get_current_theme()
    local default_theme = state.get_default_theme()

    for _, theme in ipairs(themes) do
        local prefix = theme == current_theme and "* " or "  "
        local default = theme == default_theme and " (default)" or ""
        table.insert(lines, string.format("%s%s%s", prefix, theme, default))
    end

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    vim.bo[bufnr].modifiable = false
    vim.bo[bufnr].bufhidden = "wipe"

    -- Set keymaps
    local keymap_opts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "<CR>", function()
        local line = vim.api.nvim_win_get_cursor(win)[1]
        local theme = themes[line]
        require("suthema.themes").apply_theme(theme)
        vim.api.nvim_win_close(win, true)
    end, keymap_opts)

    vim.keymap.set("n", config.keys.set_default, function()
        local line = vim.api.nvim_win_get_cursor(win)[1]
        state.set_default_theme(themes[line])
        state.save_settings()
        vim.api.nvim_win_close(win, true)
    end, keymap_opts)

    vim.keymap.set("n", "<Esc>", function()
        vim.api.nvim_win_close(win, true)
    end, keymap_opts)

    vim.keymap.set("n", "q", function()
        vim.api.nvim_win_close(win, true)
    end, keymap_opts)
end

return M
