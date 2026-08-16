return {
  {
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
          "html",
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
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({
        finder = {
          keys = {
            toggle_or_open = "<CR>",
          },
        },
      })

      vim.keymap.set("n", "<leader>lr", ":Lspsaga rename<CR>")
      vim.keymap.set("n", "<leader>ld", ":Lspsaga goto_definition<CR>")
      vim.keymap.set("n", "<leader>lc", ":Lspsaga code_action<CR>")
      vim.keymap.set("n", "<leader>lh", ":Lspsaga hover_doc<CR>")
      vim.keymap.set("n", "<leader>lR", ":Lspsaga finder<CR>")
      vim.keymap.set("n", "<leader>ln", ":Lspsaga diagnostic_jump_next<CR>")
      vim.keymap.set("n", "<leader>lp", ":Lspsaga diagnostic_jump_prev<CR>")
    end,
  },
}
