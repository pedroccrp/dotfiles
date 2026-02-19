local helpers = require("helpers")

local web_devicons = helpers.safe_require("nvim-web-devicons")
if not web_devicons then return end

web_devicons.setup {}
