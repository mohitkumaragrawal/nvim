return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require('lspconfig').gopls.setup({
        cmd = {'gopls', '-remote=auto'},
        settings = {
          gopls = {
            -- Reduce memory usage
            analyses = {
              unusedparams = true,
              staticcheck = true,
            },
            codelenses = {
              gc_details = false, -- Disable gc_details codelens
              generate = false,   -- Disable generate codelens
              regenerate_cgo = false,
              tidy = false,
              upgrade_dependency = false,
              vendor = false,
            },
            hints = {
              assignVariableTypes = false,
              compositeLiteralFields = false,
              compositeLiteralTypes = false,
              constantValues = false,
              functionTypeParameters = false,
              parameterNames = false,
              rangeVariableTypes = false,
            },
            -- Experimental settings to reduce memory
            experimentalPostfixCompletions = false,
            experimentalWorkspaceModule = false,
            gofumpt = false,
            usePlaceholders = false,
            completeFunctionCalls = false,
            directoryFilters = {
              "-polaris/.buildenv",
              "-polaris/.cache",
              "-polaris/node_modules",
              "-polaris/src/src",
              "-polaris/src/.ijwb",
              "-polaris/src/bazel-bin",
              "-polaris/src/bazel-out",
              "-polaris/src/bazel-src",
              "-polaris/src/bazel-testlogs",
              "-**/node_modules",
              "-**/vendor",
              "-**/.git",
              "-**/build",
              "-**/dist",
            },
          }
        }
      })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({})
    end,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    }
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
  }
}
