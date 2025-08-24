local keymap = vim.keymap.set

-- Basic
keymap('n', '<leader>nr', '<cmd>source %<cr>')
keymap('i', 'kj', '<esc>')

-- Window management
keymap('n', '<leader>|', '<cmd>vsplit<cr>', { desc = 'Split window vertically' })
keymap('n', '<leader>-', '<cmd>split<cr>', { desc = 'Split window horizontally' })

keymap('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
keymap('n', '<C-j>', '<C-w>j', { desc = 'Move to below window' })
keymap('n', '<C-k>', '<C-w>k', { desc = 'Move to above window' })
keymap('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
keymap('n', '<leader>wd', '<cmd>close<cr>', { desc = 'Close window' })
keymap("n", "<C-Up>", ":resize +2<CR>", { noremap = true, silent = true, desc = 'Increase height' })
keymap("n", "<C-Down>", ":resize -2<CR>", { noremap = true, silent = true, desc = 'Decrease height' })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true, desc = 'Increase width' })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true, desc = 'Decrease width' })


keymap("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
keymap("n", "<C-a>", 'mzggVG"+y`zzz', { desc = "Copy whole file" })
keymap("n", "J", "mzJ`z")

keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

-- Copy file paths
vim.keymap.set("n", "<leader>xp", function()
  local file_path = vim.fn.expand("%")
  vim.fn.setreg("+", file_path)
  print("Copied file path: " .. file_path)
end, {})

