local M = {}

function M.setup(opts)
	require("suthema.config").setup(opts)
	require("suthema.themes").discover_themes()
	require("suthema.state").load_settings()

	local state = require("suthema.state")
	if state.get_current_theme() then
		require("suthema.themes").apply_theme(state.get_current_theme())
	elseif state.get_default_theme() then
		require("suthema.themes").apply_theme(state.get_default_theme())
	end

	require("suthema.utils").setup_keymaps()
end

return M
