-- Import all plugin spec files
-- Each file returns a table of plugin specs
return {
  require("plugins.core"),
  require("plugins.ui"),
  require("plugins.navigation"),
  require("plugins.editing"),
  require("plugins.utils"),
  require("plugins.git"),
  require("plugins.ai"),
  require("plugins.flutter"),
}
