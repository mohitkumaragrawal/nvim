return  {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    {
      '<leader>ff',
      function() 
        require("fzf-lua").files()
      end,
      desc = "Search Files" 
    },
    {
      '<leader>fc',
      function() 
        require("fzf-lua").files({ cwd = "~/.config/nvim" })
      end,
      desc = "Search Config"
    },
    {
      '<leader>fr',
      function()
        require('fzf-lua').live_grep({cwd = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h')})
      end,
      desc = "Start live grep in the open file directory"
    },
    {
      '<leader>/',
      function()
        require('fzf-lua').live_grep()
      end,
      desc = "Start live grep on cwd"
    }
  },
}
