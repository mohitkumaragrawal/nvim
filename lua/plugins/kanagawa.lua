return {
  "rebelot/kanagawa.nvim",
  opts = {
    colors = {
      theme = {
        wave = {
          ui = {
            float = {
              bg = "none",
            },
          },
        },
        dragon = {
          syn = {
            parameter = "yellow",
          },
        },
        all = {
          ui = {
            bg_gutter = "none",
          },
        },
      },
    },
    commentStyle = { italic = false },
    keywordStyle = { italic = false },
  },
  lazy = false,
  config = function(_, opts)
    require("kanagawa").setup(opts)
    vim.cmd.colorscheme "kanagawa-wave"

    -- Get the theme's colors
    local colors = require("kanagawa.colors").setup()

    -- Make window separators more visible
    vim.api.nvim_set_hl(0, "VertSplit", { fg = colors.palette.sakuraPink })
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.palette.sakuraPink })
  end,
}
