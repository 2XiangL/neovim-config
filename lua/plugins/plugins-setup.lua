local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local basic_plugins = {
  "2XiangL/remove-ctrl-m.nvim",
  "folke/tokyonight.nvim",
  "windwp/nvim-autopairs",
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  "numToStr/Comment.nvim",
  "L3MON4D3/LuaSnip",
  "nvim-lualine/lualine.nvim",
  "nvim-treesitter/nvim-treesitter",
  "akinsho/bufferline.nvim",
  "lewis6991/gitsigns.nvim",
  "akinsho/toggleterm.nvim",
  "christoomey/vim-tmux-navigator",
  'nmac427/guess-indent.nvim',
}

local plugin_telescope = {
  'nvim-telescope/telescope.nvim', version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- optional but recommended
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  }
}

local plugin_mason = {
  "mason-org/mason.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "clangd",
        "pyright",
        "rust_analyzer",
        "ts_ls",
        "jdtls",
        "cssls",
        "html"
      },
      handlers = {
        function(server_name)
          local capabilities = require("cmp_nvim_lsp").default_capabilities()
          vim.lsp.config(server_name, {
            capabilities = capabilities,
          })
          vim.lsp.enable(server_name)
        end,
      },
    })

    vim.diagnostic.config({
      update_in_insert = true,
      virtual_text = true,
      signs = true,
      underline = true,
    })
  end,
}

local plugin_nvim_cmp = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
  },
}

local lspsaga = {
  'nvimdev/lspsaga.nvim'
}

local claude_code = {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  keys = {
    { "<leader>c", nil, desc = "AI/Claude Code" },
    { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<leader>cs",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
    },
    -- Diff management
    { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
}

local supermaven = {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      color = {
        suggestion_color = '#ffffff',
      },
      keymaps = {
        accept_suggestion = "<C-h>",
        clear_suggestion = "<C-k>",
        accept_word = "<C-j>",
      }
    })
  end,
}


require("lazy").setup({
  basic_plugins,
  plugin_telescope,
  plugin_mason,
  plugin_nvim_cmp,
  lspsaga,
  claude_code,
  supermaven,
})
