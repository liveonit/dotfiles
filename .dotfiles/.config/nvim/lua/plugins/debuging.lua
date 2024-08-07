local dap = require("dap")
local utils = require("utils")

-- Set keymaps to control the debugger
vim.keymap.set('n', '<leader>dc', function()
  local launch_config_dir = utils.find_ancestor_with_file("launch.json")
  if launch_config_dir and utils.get_file_extension(vim.fn.expand("%:p")) == "ts" then
    local launch_config = utils.read_and_parse_json_file(launch_config_dir .. "/launch.json")
    if not (utils.table_contains_by_attribute(dap.configurations.typescript, "name", launch_config.name)) then
      dap.configurations.typescript[#dap.configurations.typescript + 1] = launch_config
    end
  end

  if launch_config_dir and utils.get_file_extension(vim.fn.expand("%:p")) == "js" then
    dap.configurations.javascript[#dap.configurations.javascript + 1] = utils.read_and_parse_json_file(launch_config_dir ..
      "/launch.json")
  end

  dap.continue()
end)
vim.keymap.set('n', '<leader>dj', dap.step_over)
vim.keymap.set('n', '<leader>dl', dap.step_into)
vim.keymap.set('n', '<leader>dh', dap.step_out)
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>B', function()
  require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end)
vim.fn.sign_define('DapBreakpoint', { text = '📌', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = '', numhl = '' })


require("mason-nvim-dap").setup({
  ensure_installed = { "python", "cppdbg", "codelldb", "node2", "js", "chrome", "firefox", "bash" },
  automatic_installation = true,
})

-- Setup node-debug2-adapter
dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = {
    require("mason-registry").get_package("node-debug2-adapter"):get_install_path() .. "/out/src/nodeDebug.js",
  },
}

-- Setup firefox-debug-adapter
dap.adapters.firefox = {
  type = "executable",
  command = "node",
  args = {
    require("mason-registry").get_package("firefox-debug-adapter"):get_install_path() .. "/dist/adapter.bundle.js",
  },
}

-- Configuration of the adapters for the respective language
dap.configurations.javascript = {
  {
    name = "Launch Node against current file",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    name = "Launch Node against pick process",
    type = "node2",
    request = "attach",
    processId = require("dap.utils").pick_process,
    console = "integratedTerminal",
  },
  {
    name = "Launch Firefox against localhost",
    request = "launch",
    type = "firefox",
    reAttach = true,
    url = "http://localhost:3000",
    webRoot = "${workspaceFolder}",
    console = "integratedTerminal",
  },
}

dap.configurations.typescript = {
  {
    name = "Lanunch Node",
    type = "node2",
    request = "launch",
    runtimeArgs = { "-r", "ts-node/register" },
    runtimeExecutable = "node",
    args = { "--inspect", "${file}" },
    skipFiles = { "node_modules/**" },
    console = "integratedTerminal",
  }
}

for _, language in pairs({ "javascriptreact", "typescriptreact" }) do
  require('dap').configurations[language] = {
    {
      name = "Launch Firefox against localhost",
      request = "launch",
      type = "firefox",
      reAttach = true,
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      console = "integratedTerminal",
    },
  }
end



local dapui = require("dapui")

dapui.setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
