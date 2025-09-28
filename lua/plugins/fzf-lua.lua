return  {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require("fzf-lua").setup({ "hide", fzf_colors = true, })
  end,
  keymap = {
    builtin = {
      ["<C-k>"] = "preview-page-up",
      ["<C-j>"] = "preview-page-down"
    }
  },
  keys = {
    { '<leader>fa', function() require("fzf-lua").builtin() end, desc = "Start searching" },
    { '<leader>ff', function() require("fzf-lua").files() end, desc = "Search Files" },
    { '<leader>fc', function() require("fzf-lua").files({ cwd = "~/.config/nvim" }) end, desc = "Search Config" },
    { '<leader>fr', function() require('fzf-lua').live_grep({cwd = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h')}) end, desc = "Start live grep in the open file directory" },
    { '<leader>/', function() require('fzf-lua').live_grep() end, desc = "Start live grep on cwd" },
    { '<leader>fo', function() require('fzf-lua').oldfiles() end, desc = "Search recent files." },
    { '<leader>fr', function() require('fzf-lua').live_grep({cwd = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h')}) end, desc = "Start live grep in the open file directory" },
    { '<leader><leader>', function() require('fzf-lua').resume() end, desc = "Resume last find" },
    { '<leader>fd', function() require('fzf-lua').diagnostics_document() end, desc = "List diagnostics" },
    { '<leader>fb', function() require("fzf-lua").buffers() end, desc = "Search Buffers" },
  },
}
