local helpers = require("helpers")

local git_conflict = helpers.safe_require("git-conflict")
if not git_conflict then
  return
end

git_conflict.setup()
