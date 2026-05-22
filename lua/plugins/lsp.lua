local cmp = require 'cmp'

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

-- 下面会用到这个函数
local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),  -- 取消补全，esc也可以退出
    ['<CR>'] = cmp.mapping.confirm({ select = true }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  }),

  sources = cmp.config.sources({
    { name = 'supermaven' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  }),

})

require("lspsaga").setup({
  cmd = "lspsaga",
  opts = {
    finder = {
      keys = {
        toggle_or_open = "<CR>",
      },
    },
  },

  vim.keymap.set("n", "<leader>lr", ":Lspsaga rename<CR>"),
  vim.keymap.set("n", "<leader>ld", ":Lspsaga definition<CR>"),
  vim.keymap.set("n", "<leader>lc", ":Lspsaga code_action<CR>"),
  vim.keymap.set("n", "<leader>lh", ":Lspsaga hover_doc<CR>"),
  vim.keymap.set("n", "<leader>lR", ":Lspsaga finder<CR>"),
  vim.keymap.set("n", "<leader>ln", ":Lspsaga diagnostic_jump_next<CR>"),
  vim.keymap.set("n", "<leader>lp", ":Lspsaga diagnostic_jump_prev<CR>"),
})
