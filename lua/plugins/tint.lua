return {
  'levouh/tint.nvim',
  config = function()
    require('tint').setup({
      tint = -20, -- A number between -100 and 100. Negative darkens, positive lightens.
      filetypes = { -- List of filetypes to exclude from tinting
        'NvimTree',
        'lazy',
        'mason',
        'toggleterm',
      },
    })
  end,
}
