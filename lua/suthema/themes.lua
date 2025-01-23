local M = {}

function M.discover_themes()
	local state = require("suthema.state")
	local themes = {}
	local seen = {}

	local current_theme = vim.g.colors_name or "default"

	local lazy_plugins = require("lazy.core.config").plugins

	local theme_mappings = {
		["onedarkpro.nvim"] = { "onedark", "onelight", "onedark_vivid", "onedark_dark" },
		["rose-pine"] = { "rose-pine-main", "rose-pine-moon", "rose-pine-dawn" },
		["monoglow.nvim"] = { "monoglow" },
		["monochrome"] = { "monochrome" },
		["tokyonight.nvim"] = {
			"tokyonight",
			"tokyonight-night",
			"tokyonight-storm",
			"tokyonight-day",
			"tokyonight-moon",
		},
		["catppuccin"] = {
			"catppuccin",
			"catppuccin-latte",
			"catppuccin-frappe",
			"catppuccin-macchiato",
			"catppuccin-mocha",
		},
		["nightfox.nvim"] = {
			"nightfox",
			"dayfox",
			"dawnfox",
			"duskfox",
			"nordfox",
			"terafox",
			"carbonfox",
		},
		["gruvbox-material"] = { "gruvbox-material" },
	}

	for plugin_name, _ in pairs(lazy_plugins) do
		if theme_mappings[plugin_name] then
			for _, theme_name in ipairs(theme_mappings[plugin_name]) do
				if not seen[theme_name] then
					local success = pcall(function()
						vim.cmd.colorscheme(theme_name)
					end)
					if success then
						seen[theme_name] = true
						table.insert(themes, theme_name)
					end
				end
			end
		end
	end

	pcall(vim.cmd.colorscheme, current_theme)

	table.sort(themes)

	state.set_theme_list(themes)
	return themes
end

function M.apply_theme(theme_name)
	local state = require("suthema.state")
	pcall(vim.cmd, "colorscheme " .. theme_name)
	state.set_current_theme(theme_name)
	state.add_to_history(theme_name)
	state.save_settings()
end

function M.next_theme()
	local state = require("suthema.state")
	local themes = state.get_theme_list()
	local current_theme = state.get_current_theme()

	local current_index = vim.fn.index(themes, current_theme)
	local next_index = (current_index + 1) % #themes
	M.apply_theme(themes[next_index + 1])
end

function M.prev_theme()
	local state = require("suthema.state")
	local themes = state.get_theme_list()
	local current_theme = state.get_current_theme()

	local current_index = vim.fn.index(themes, current_theme)
	local prev_index = (current_index - 1)
	if prev_index < 0 then
		prev_index = #themes - 1
	end
	M.apply_theme(themes[prev_index + 1])
end

return M
