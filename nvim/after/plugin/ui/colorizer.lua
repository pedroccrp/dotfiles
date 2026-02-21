local helpers = require("helpers")

local colorizer = helpers.safe_require("colorizer")
if not colorizer then return end

colorizer.setup()
