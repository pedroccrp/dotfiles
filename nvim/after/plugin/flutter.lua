local lsp = require('lsp-zero')
local dart_lsp = lsp.build_options('dartls', {})

require('flutter-tools').setup({
  lsp = {
    capabilities = dart_lsp.capabilities
  },
  dev_log = {
    enabled = false
  }
})
