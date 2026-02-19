local helpers = require("helpers")

local cmp = helpers.safe_require("cmp")
local luasnip = helpers.safe_require("luasnip")
local luasnip_loaders = helpers.safe_require("luasnip/loaders/from_vscode")
local lspkind = helpers.safe_require("lspkind")

if not cmp or not luasnip or not luasnip_loaders or not lspkind then return end

luasnip_loaders.lazy_load()
vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = {
    { name = "path" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer", keyword_length = 3 },
    { name = "copilot" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<Tab>"] = cmp.mapping.confirm({ select = false }),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<S-Tab>"] = nil,
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 50,
      ellipsis_char = "...",
      show_labelDetails = true,
      symbol_map = {},
      before = function(_, vim_item)
        return vim_item
      end,
    }),
  },
  experimental = {
    ghost_text = false,
  },
})
