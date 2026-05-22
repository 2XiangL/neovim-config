require("remove-ctrl-m").setup({})

require("nvim-autopairs").setup({})

require("nvim-tree").setup({
  vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
})

require("Comment").setup({})

require("bufferline").setup({
  options = {
    diagnostics = "nvim_lsp",
    offsets = {{
      filetype = "NvimTree",
      text = "File Explorer",
      highlight = "Directory",
      text_align = "left"
    }},
  },
})

require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
})

require('lualine').setup({
	options = {
		theme = 'tokyonight',
		globalstatus = true
	}
})

require("toggleterm").setup({
  vim.keymap.set("n", "<leader>/", ":ToggleTerm direction=vertical size=40<CR>"),
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts),
})

require("nvim-treesitter").setup {
  ensure_installed = {
    "lua", "vim", "vimdoc", "python", "javascript", "typescript",
    "rust", "go", "java", "cpp", "c", "html", "css", "json"
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- 也适用于其他括号如 HTML 标签
    max_file_lines = 1000,
  }
}

require("guess-indent").setup({})
