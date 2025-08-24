require('options')
require('keymaps')

-- plugins
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local function natural_cmp(left, right)
  local a_is_dir = (left.type == "directory")
  local b_is_dir = (right.type == "directory")

  if a_is_dir and not b_is_dir then
    return true -- 'a' is a directory and comes first
  end
  if not a_is_dir and b_is_dir then
    return false -- 'b' is a directory and comes first
  end

  left = left.name:lower()
  right = right.name:lower()

  if left == right then
    return false
  end

  for i = 1, math.max(string.len(left), string.len(right)), 1 do
    local l = string.sub(left, i, -1)
    local r = string.sub(right, i, -1)

    if type(tonumber(string.sub(l, 1, 1))) == "number" and type(tonumber(string.sub(r, 1, 1))) == "number" then
      local l_number = tonumber(string.match(l, "^[0-9]+"))
      local r_number = tonumber(string.match(r, "^[0-9]+"))

      if l_number ~= r_number then
        return l_number < r_number
      end
    elseif string.sub(l, 1, 1) ~= string.sub(r, 1, 1) then
      return l < r
    end
  end
end

require('lazy').setup({
  {
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
      vim.cmd.colorscheme "kanagawa"

      -- Get the theme's colors
      local colors = require("kanagawa.colors").setup()

      -- Make window separators more visible
      vim.api.nvim_set_hl(0, "VertSplit", { fg = colors.palette.sakuraPink })
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.palette.sakuraPink })

    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Dependency for icons
    name = "nvim-tree",
    event = "VimEnter",
    opts = {
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      view = {
        width = {
          min = 30,
          max = -1,
        },
      },
      git = {
        enable = false,
      },
      diagnostics = {
        enable = false,
      },
      sort_by = function(nodes)
        table.sort(nodes, natural_cmp)
      end,
      filters = {
        git_ignored = true,
        dotfiles = false,
      },
      renderer = {
        symlink_destination = false,
      },
      on_attach = function(bufnr)
        local opts = { buffer = bufnr }
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)
        -- function for left to assign to keybindings
        local lefty = function()
          local node_at_cursor = api.tree.get_node_under_cursor()
          -- if it's a node and it's open, close
          if node_at_cursor.nodes and node_at_cursor.open then
            api.node.open.edit()
            -- else left jumps up to parent
          else
            api.node.navigate.parent()
          end
        end
        -- function for right to assign to keybindings
        local righty = function()
          local node_at_cursor = api.tree.get_node_under_cursor()
          -- if it's a closed node, open it
          if node_at_cursor.nodes and not node_at_cursor.open then
            api.node.open.edit()
          end
        end
        vim.keymap.set("n", "h", lefty, opts)
        vim.keymap.set("n", "<Left>", lefty, opts)
        vim.keymap.set("n", "<Right>", righty, opts)
        vim.keymap.set("n", "l", righty, opts)
      end,
    },
    keys = {
      {
        "<leader>e",
        function()
          require("nvim-tree.api").tree.toggle({ focus = true, find_file = true })
        end,
        desc = "Toggle NvimTree and reveal current file",
      },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)
      local group = vim.api.nvim_create_augroup("NvimTreeAutoReveal", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "VimEnter" }, {
        group = group,
        callback = function()
          if require("nvim-tree.api").tree.is_visible() then
            require("nvim-tree.api").tree.find_file()
          end
        end,
        pattern = "*",
      })

      local augroup = vim.api.nvim_create_augroup("NvimTreeCwd", { clear = true })
      vim.api.nvim_create_autocmd("VimEnter", {
        group = augroup,
        desc = "Set CWD to directory passed as argument",
        callback = function()
          if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
            vim.cmd.cd(vim.fn.fnameescape(vim.fn.argv(0)))
            vim.cmd.NvimTreeToggle()
          end
        end,
        once = true, -- Run this only once on startup
      })
    end,
  },
  {
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
  },
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    'tpope/vim-fugitive'
  }
})
