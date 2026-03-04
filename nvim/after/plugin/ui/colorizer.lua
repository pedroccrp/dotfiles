local helpers = require("helpers")

local colorizer = helpers.safe_require("colorizer")
if not colorizer then return end

colorizer.setup(nil, {
  names = false, -- "Name" codes like Blue or blue
  RGB = true, -- #RGB hex codes
  RRGGBB = true, -- #RRGGBB hex codes
  RRGGBBAA = true, -- #RRGGBBAA hex codes
  css = { css = true }, -- Enable all CSS features: rgb(), hsl(), etc.
  scss = { css = true }, -- Enable all SCSS features: rgb(), hsl(), etc.
  html = { css = true }, -- Enable all HTML features: rgb(), hsl(), etc.
})
