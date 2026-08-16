return {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({})
      vim.keymap.set("n", "<leader>/", ":ToggleTerm direction=vertical size=40<CR>")
      vim.keymap.set("t", "jk", [[<C-\><C-n>]])
    end,
  },
  "christoomey/vim-tmux-navigator",
}
