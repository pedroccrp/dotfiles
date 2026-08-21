local helpers = require("helpers")

local Comment = helpers.safe_require("Comment")
if not Comment then
  return
end

Comment.setup()
