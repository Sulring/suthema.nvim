local M = {}

M.config = {
	save_file = vim.fn.stdpath("data") .. "/suthema.json",
	theme_dir = vim.fn.stdpath("data") .. "/lazy",
	keys = {
		toggle = "<leader>th",
		next = "<leader>tn",
		prev = "<leader>tp",
		set_default = "d",
	},
}

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

function M.get()
	return M.config
end

return M
