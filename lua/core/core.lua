vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("n", "tj", ":bprev<cr>")
vim.keymap.set("n", "tk", ":bnext<cr>")
vim.keymap.set("n", "tn", ":tabnew<cr>")

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.cursorline = true
vim.opt.mouse:append("a")
vim.opt.clipboard:append("unnamedplus")
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

vim.g.mapleader = " "
