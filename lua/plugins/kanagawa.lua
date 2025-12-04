return {
	{
		"rebelot/kanagawa.nvim",
		opts = {
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
			commentStyle = { italic = false },
			keywordStyle = { italic = false },
			overrides = function(colors)
				local theme = colors.theme
				local makeDiagnosticColor = function(color)
					local c = require("kanagawa.lib.color")
					return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
				end
				return {
					NormalFloat = { bg = "none" },
					FloatTitle = { bg = "none" },
					FloatBorder = { bg = "NONE", fg = colors.palette.oniViolet },
					DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
					DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
					DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
					DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency,,
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = "#C0A36E" },
					BlinkCmpMenuBorder = { fg = "", bg = "" },
					CursorLineNr = { fg = colors.palette.sakuraPink, bg = "NONE" },
					-- IblIndent = { fg = colors.palette.sumiInk5, bg = "NONE" },
					-- IblWhitespace = { fg = colors.palette.sumiInk5, bg = "NONE" },
					-- Visual = { fg = "#ffffff", bg = colors.palette.autumnRed },
					CursorLine = { fg = "NONE", bg = colors.palette.sumiInk4 },
					IblIndent = { fg = colors.palette.sumiInk4, bg = "NONE" },
					IblWhitespace = { fg = colors.palette.sumiInk4, bg = "NONE" },
					IblScope = { fg = colors.palette.sumiInk5, bg = "NONE" },
				}
			end,
		},
		lazy = false,
		priority = 1000,
		config = function(_, opts)
			require("kanagawa").setup(opts)
			vim.cmd.colorscheme("kanagawa")
		end,
	},
	{
		"folke/tokyonight.nvim",
	},
}
