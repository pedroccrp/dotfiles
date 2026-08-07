local helpers = require("helpers")

local treesitter_context = helpers.safe_require("treesitter-context")

if not treesitter_context then
  return
end

treesitter_context.setup({
  max_lines = 3,
  multiline_threshold = 5,
  trim_scope = "outer",
})
