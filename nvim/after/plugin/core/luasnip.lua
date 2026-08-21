local helpers = require("helpers")

local luasnip = helpers.safe_require("luasnip")
local luasnip_loaders = helpers.safe_require("luasnip/loaders/from_vscode")

if not luasnip or not luasnip_loaders then
  return
end

luasnip_loaders.lazy_load()
