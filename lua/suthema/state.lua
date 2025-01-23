local M = {}

local state = {
	current_theme = nil,
	default_theme = nil,
	theme_list = {},
	history = {},
	history_index = 1,
}

function M.save_settings()
	local config = require("suthema.config").get()
	local file = io.open(config.save_file, "w")
	if file then
		local data = vim.fn.json_encode({
			current_theme = state.current_theme,
			default_theme = state.default_theme,
			history = state.history,
		})
		file:write(data)
		file:close()
	end
end

function M.load_settings()
	local config = require("suthema.config").get()
	local file = io.open(config.save_file, "r")
	if file then
		local content = file:read("*all")
		file:close()
		local data = vim.fn.json_decode(content)
		state.current_theme = data.current_theme
		state.default_theme = data.default_theme
		state.history = data.history or {}
	end
end

-- Add getters and setters
function M.get_current_theme()
	return state.current_theme
end
function M.set_current_theme(theme)
	state.current_theme = theme
end
function M.get_default_theme()
	return state.default_theme
end
function M.set_default_theme(theme)
	state.default_theme = theme
end
function M.get_theme_list()
	return state.theme_list
end
function M.set_theme_list(list)
	state.theme_list = list
end
function M.get_history()
	return state.history
end

function M.add_to_history(theme_name)
	table.insert(state.history, 1, theme_name)
	if #state.history > 10 then
		table.remove(state.history)
	end
	state.history_index = 1
end

return M
