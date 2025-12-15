return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		columns = {
			"icon",
		},
		keymaps = {
			["<C-l>"] = false,
			["<C-h>"] = false,
			["L"] = "actions.refresh",
			["<leader>fr"] = {
				function()
					local path = require("oil").get_current_dir(0)
					local entry = require("oil").get_cursor_entry()
					if entry and entry.type == "directory" then
						local full_path = path .. entry.parsed_name
						require("fzf-lua").live_grep({ cwd = full_path })
					else
						require("fzf-lua").live_grep({ cwd = path })
					end
				end,
				mode = "n",
				nowait = true,
				desc = "Fzf live grep in current oil directory",
			},
			["gd"] = {
				function()
					require("fzf-lua").fzf_exec("fd --type d --hidden --follow --exclude .git", {
						prompt = "Oil Change Dir> ",
						preview = "ls -oha --color=always {-1}",
						actions = {
							["default"] = function(selected)
								if selected and selected[1] then
									require("oil").open(selected[1])
								end
							end,
						},
					})
				end,
				desc = "Fzf switch directory",
				mode = "n",
			},
			["K"] = {
				function()
					local oil = require("oil")
					local entry = oil.get_cursor_entry()
					local dir = oil.get_current_dir()
					if not entry or not dir then
						return
					end

					-- Get full path and file stats
					local path = dir .. entry.name
					local stat = vim.uv.fs_stat(path) -- Use vim.loop.fs_stat if < 0.10.0
					if not stat then
						return
					end

					-- Format the content for the popup
					local lines = {}
					table.insert(lines, "   " .. entry.name)
					table.insert(
						lines,
						"──────────────────────────────"
					)
					table.insert(lines, " Size:      " .. math.ceil(stat.size / 1024) .. " KB")
					table.insert(lines, " Mode:      " .. string.format("%o", stat.mode)) -- Octal permission
					table.insert(lines, " Created:   " .. os.date("%Y-%m-%d %H:%M:%S", stat.birthtime.sec))
					table.insert(lines, " Modified:  " .. os.date("%Y-%m-%d %H:%M:%S", stat.mtime.sec))

					-- Create a floating window
					local buf = vim.api.nvim_create_buf(false, true)
					vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

					local width = 0
					for _, line in ipairs(lines) do
						width = math.max(width, #line)
					end

					local win = vim.api.nvim_open_win(buf, true, {
						relative = "cursor",
						width = width + 2,
						height = #lines,
						row = 1,
						col = 0,
						style = "minimal",
						border = "rounded",
					})

					-- Close popup on 'q', 'Esc', or 'K'
					local close_win = function()
						vim.api.nvim_win_close(win, true)
					end
					vim.keymap.set("n", "q", close_win, { buffer = buf })
					vim.keymap.set("n", "<Esc>", close_win, { buffer = buf })
					vim.keymap.set("n", "K", close_win, { buffer = buf })
				end,
				desc = "Show file metadata details",
				mode = "n",
			},
		},
		delete_to_trash = true,
	},
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	lazy = false,
}
