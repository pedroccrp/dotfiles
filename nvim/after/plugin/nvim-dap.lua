local dap = require("dap")
local ui = require("dapui")
local dap_virtual = require("nvim-dap-virtual-text")

ui.setup()
dap_virtual.setup()

dap.configurations.dart = {
  {
    type = "dart",
    request = "launch",
    name = "Launch dart",
    dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/bin/dart", -- ensure this is correct
    flutterSdkPath = "/opt/flutter/bin/flutter", -- ensure this is correct
    program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
    cwd = "${workspaceFolder}",
  },
  {
    type = "flutter",
    request = "launch",
    name = "Launch flutter",
    dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/bin/dart", -- ensure this is correct
    flutterSdkPath = "/opt/flutter/bin/flutter", -- ensure this is correct
    program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
    cwd = "${workspaceFolder}",
  },
}

dap.adapters.dart = {
  type = "executable",
  command = "dart", -- if you're using fvm, you'll need to provide the full path to dart (dart.exe for windows users), or you could prepend the fvm command
  args = { "debug_adapter" },
  -- windows users will need to set 'detached' to false
  options = {
    detached = false,
  },
}
dap.adapters.flutter = {
  type = "executable",
  command = "flutter", -- if you're using fvm, you'll need to provide the full path to flutter (flutter.bat for windows users), or you could prepend the fvm command
  args = { "debug_adapter" },
  -- windows users will need to set 'detached' to false
  options = {
    detached = false,
  },
}

-- Keymaps
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>dd", dap.disconnect)
vim.keymap.set("n", "<leader>?", function()
  require("dapui").eval(nil, { enter = true })
end)

-- Set proper UI
dap.listeners.before.attach.dapui_config = function()
  ui.open()
end
dap.listeners.before.launch.dapui_config = function()
  ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  ui.close()
end

-- Customize breakpoint symbol and color
vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })

vim.fn.sign_define(
  "DapBreakpoint",
  { text = "•", texthl = "blue", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
  "DapBreakpointCondition",
  { text = "•", texthl = "blue", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
  "DapBreakpointRejected",
  { text = "•", texthl = "orange", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define("DapStopped", { text = "•", texthl = "green", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
vim.fn.sign_define(
  "DapLogPoint",
  { text = "•", texthl = "yellow", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
