-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
	local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
	local dir = require("oil").get_current_dir(bufnr)
	if dir then
		return vim.fn.fnamemodify(dir, ":~")
	else
		-- If there is no current directory (e.g. over ssh), just show the buffer name
		return vim.api.nvim_buf_get_name(0)
	end
end

return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		win_options = {
			winbar = "%!v:lua.get_oil_winbar()",
		},
		keymaps = {
			["<C-l>"] = false,
			["<C-h>"] = false,
			["L"] = "actions.refresh",
			["<leader>fr"] = function()
				local path = require("oil").get_current_dir(0)
				local entry = require("oil").get_cursor_entry()
				if entry and entry.type == "directory" then
					local full_path = path .. entry.parsed_name
					require("fzf-lua").live_grep({ cwd = full_path })
				else
					require("fzf-lua").live_grep({ cwd = path })
				end
			end,
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	lazy = false,
}
