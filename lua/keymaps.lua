local M = vim.keymap.set

-- Basic
M('n', '<leader>nr', '<cmd>source %<cr>', { desc = "Source current buffer" })
M('i', 'kj', '<esc>')

M('n', '<leader>|', '<cmd>vsplit<cr>', { desc = 'Split window vertically' })
M('n', '<leader>-', '<cmd>split<cr>', { desc = 'Split window horizontally' })
M('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
M('n', '<C-j>', '<C-w>j', { desc = 'Move to below window' })
M('n', '<C-k>', '<C-w>k', { desc = 'Move to above window' })
M('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
M('n', '<leader>wd', '<cmd>close<cr>', { desc = 'Close window' })
M("n", "<C-Up>", ":resize +2<CR>", { noremap = true, silent = true, desc = 'Increase height' })
M("n", "<C-Down>", ":resize -2<CR>", { noremap = true, silent = true, desc = 'Decrease height' })
M("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true, desc = 'Increase width' })
M("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true, desc = 'Decrease width' })
M("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
M("n", "<C-a>", 'mzggVG"+y`zzz', { desc = "Copy whole file" })
M("n", "J", "mzJ`z", { desc = "Merge bottom line" })
M("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "Scroll up" })
M("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Scroll down" })
M("n", "<leader>bd", "<cmd>bdelete<cr>", { noremap = true, desc = "Close Buffer" })
M('n', '<esc><esc>', ':noh<CR>', { silent = true, nowait = true })


-- Copy file paths
M("n", "<leader>xp", function()
  local file_path = vim.fn.expand("%")
  vim.fn.setreg("+", file_path)
  print("Copied file path: " .. file_path)
end, { desc = "Copy file path"})

local function toggle_diagnostics_virtual_text()
  local new_config = not vim.diagnostic.config().virtual_text
  vim.diagnostic.config({
    virtual_text = new_config,
    -- You can also toggle other diagnostic displays here, like signs
    -- signs = new_config,
  })
end

M('n', '<leader>d', toggle_diagnostics_virtual_text, { desc = "Toggle diagnostics" })

