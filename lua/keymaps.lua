local M = vim.keymap.set

-- Basic
M("n", "<leader>nr", "<cmd>source %<cr>", { desc = "Source current buffer" })
M("i", "kj", "<esc>")

M("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split window vertically" })
M("n", "<leader>-", "<cmd>split<cr>", { desc = "Split window horizontally" })
M("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
M("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
M("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
M("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
M("n", "<leader>wd", "<cmd>close<cr>", { desc = "Close window" })
M("n", "<C-Up>", ":resize +2<CR>", { noremap = true, silent = true, desc = "Increase height" })
M("n", "<C-Down>", ":resize -2<CR>", { noremap = true, silent = true, desc = "Decrease height" })
M("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true, desc = "Increase width" })
M("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true, desc = "Decrease width" })
M("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
M("n", "<C-a>", 'mzggVG"+y`zzz', { desc = "Copy whole file" })
M("n", "J", "mzJ`z", { desc = "Merge bottom line" })
M("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "Scroll up" })
M("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Scroll down" })
M("n", "<leader>bd", "<cmd>bdelete<cr>", { noremap = true, desc = "Close Buffer" })

M("n", "<esc><esc>", ":noh<CR>", { silent = true, nowait = true })
M("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
M('n', 'j', 'gj', { desc = "Move down" })
M('n', 'k', 'gk', { desc = "Move down" })

M("n", "gd", vim.lsp.buf.definition, {})
M("n", "gr", vim.lsp.buf.references, {})
M("n", "<leader>cr", vim.lsp.buf.rename, {})

-- Copy file paths
M("n", "<leader>xp", function()
	local file_path = vim.fn.expand("%")
	vim.fn.setreg("+", file_path)
	print("Copied file path: " .. file_path)
end, { desc = "Copy file path" })

local function toggle_diagnostics_virtual_text()
	local new_config = not vim.diagnostic.config().virtual_text
	vim.diagnostic.config({
		virtual_text = new_config,
		-- You can also toggle other diagnostic displays here, like signs
		-- signs = new_config,
	})
end

M("n", "<leader>d", toggle_diagnostics_virtual_text, { desc = "Toggle diagnostics" })

-- LSP configs
M("n", "K", function()
	vim.lsp.buf.hover()
end, { desc = "Hover doc" })

M("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", { desc = "Hover doc" })
M("n", "L", "<cmd>bnext<cr>", {})
M("n", "H", "<cmd>bprev<cr>", {})
M("n", "<leader>bd", "<cmd>bdelete<cr>", {})

M("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- DAP
M("n", "<F5>", '<cmd>lua require("dap").continue()<cr>', { desc = "DAP: Continue" })
M("n", "<F6>", '<cmd>lua require("dap").terminate()<cr>', { desc = "DAP: Terminate" })
M("n", "<F10>", '<cmd>lua require("dap").step_over()<cr>', { desc = "DAP: Step Over" })
M("n", "<F11>", '<cmd>lua require("dap").step_into()<cr>', { desc = "DAP: Step Into" })
M("n", "<F12>", '<cmd>lua require("dap").step_out()<cr>', { desc = "DAP: Step Out" })
M("n", "<leader>b", '<cmd>lua require("dap").toggle_breakpoint()<cr>', { desc = "DAP: Toggle Breakpoint" })
M(
	"n",
	"<leader>B",
	'<cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<cr>',
	{ desc = "DAP: Set Conditional Breakpoint" }
)
M(
	"n",
	"<leader>lp",
	'<cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<cr>',
	{ desc = "DAP: Set Logpoint" }
)
M("n", "<leader>dr", '<cmd>lua require("dap").repl.open()<cr>', { desc = "DAP: Open REPL" })
M("n", "<leader>dl", '<cmd>lua require("dap").run_last()<cr>', { desc = "DAP: Run Last" })
M("n", "<leader>du", '<cmd>lua require("dapui").toggle()<cr>', { desc = "DAP: Toggle UI" })

-- Toggle format on save
M("n", "<leader>fs", "<cmd>FormatOnSaveToggle<cr>", { desc = "Toggle format on save" })


M({"n", "v"}, "<leader>ac", "<CMD>Augment chat<CR>", { desc = "Augment chat" })
