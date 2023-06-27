local wk = require("which-key")
local opts = {
  mode = "n",     -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
  expr = false,   -- use `expr` when creating keymaps
}

wk.register({
  f = {
    name = "files",
    f = "Find files",
    b = "Open buffers",
    d = "Find in git files",
    g = "Live grep all files",
    s = "Live grep with args",
    h = "Open recent files",
    e = "File browser home dir",
    c = "File browser in current directory",
    t = "Document symbols"
  },
  v = {
    name = "Code explore and troubleshooting",
    D = "TroubleToggle lsp go to type definition",
    d = "TroubleToggle lsp go to definition",
    r = "TroubleToggle lsp show references",
    q = "TroubleToggle quick fix",
    t = "TroubleToggle document diagnostics",
    h = "LSP hover",
    i = "LSP go to implementation",
    f = "LSP buffer format",
    c = "LSP code actions",
    p = "Diagnostic go to prev",
    n = "Diagnostic go to next",
  }
}, opts)
