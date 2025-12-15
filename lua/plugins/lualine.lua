local function generate_winbar_config()
	return {
		lualine_a = {},
		lualine_b = {
			{
				"filetype",
				colored = false, -- Displays filetype icon in color if set to true
				icon_only = true, -- Display only an icon for filetype
			},
		},
		lualine_c = {
			{
				"filename",
				symbols = {
					modified = "", -- Text to show when the file is modified.
					readonly = "", -- Text to show when the file is non-modifiable or readonly.
					unnamed = " ", -- Text to show for unnamed buffers.
					newfile = "+", -- Text to show for new created file before first write
				},
				cond = function()
					-- Only show this 'filename' component if the filetype is NOT 'oil'
					return vim.bo.filetype ~= "oil"
				end,
			},
			{
				function()
					if vim.bo.filetype == "oil" then
						return require("oil").get_current_dir(0)
					end
					return ""
				end,
			},
		},
		lualine_y = {},
		lualine_z = {
			{
				"location",
			},
		},
	}
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "rebelot/kanagawa.nvim" },
	config = function()
		require("lualine").setup({
			options = {
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = true,
				disabled_filetypes = {
					winbar = {
						"NvimTree",
					},
				},
				always_show_tabline = true,
			},
			sections = {
				lualine_a = { {
					"mode",
					fmt = function(str)
						return str:sub(1, 1)
					end,
				} },
				lualine_b = { {
					"branch",
					fmt = function(str)
						return str:sub(1, 10)
					end,
				} },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = {},
				lualine_y = {},
				lualine_z = { { "tabs", mode = 2 } },
			},
			winbar = generate_winbar_config(),
			inactive_winbar = generate_winbar_config(),
			tabline = {
				lualine_a = {
					{
						"buffers",
						mode = 0,
						icons_enabled = false,
						max_length = 1e3,
						symbols = {
							modified = "",
							alternate_file = "",
						},
						buffers_color = {
							-- Color for the current buffer you are looking at
							active = { fg = "#C8C093", bg = "#2D4F67", gui = "bold" },

							-- Color for other buffers in the background
							inactive = { fg = "#727169", bg = "#16161D" },
						},
						fmt = function(name)
							local max_len = 20 -- Truncate if name is longer than 20 chars
							if #name > max_len then
								-- Keep first 8 chars .. "..." .. last 9 chars
								return string.sub(name, 1, 8) .. "..." .. string.sub(name, -9)
							end
							return name
						end,
					},
				},
			},
		})
	end,
}
