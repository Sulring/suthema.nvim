local M = {}

function M.setup_keymaps()
	local config = require("suthema.config").get()
	local themes = require("suthema.themes")
	local ui = require("suthema.ui")

	vim.keymap.set("n", config.keys.toggle, ui.toggle_theme_selector, { noremap = true, silent = true })
	vim.keymap.set("n", config.keys.next, themes.next_theme, { noremap = true, silent = true })
	vim.keymap.set("n", config.keys.prev, themes.prev_theme, { noremap = true, silent = true })
end

return M
