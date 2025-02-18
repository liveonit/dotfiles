return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      -- These settings are used by some built-in sections
      preset = {
        -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
        ---@type fun(cmd:string, opts:table)|nil
        pick = nil,
        -- Used by the `keys` section to show keymaps.
        -- Set your custom keymaps here.
        -- When using a function, the `items` argument are the default keymaps.
        ---@type snacks.dashboard.Item[]
        keys = {
          {
            icon = ' ',
            key = 'f',
            desc = 'Find File',
            action = ":lua Snacks.dashboard.pick('files')",
          },
          {
            icon = ' ',
            key = 'n',
            desc = 'New File',
            action = ':ene | startinsert',
          },
          {
            icon = ' ',
            key = 'g',
            desc = 'Find Text',
            action = ":lua Snacks.dashboard.pick('live_grep')",
          },
          {
            icon = ' ',
            key = 'r',
            desc = 'Recent Files',
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            icon = ' ',
            key = 'c',
            desc = 'Config',
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          {
            icon = ' ',
            key = 's',
            desc = 'Restore Session',
            section = 'session',
          },
          {
            icon = '󰒲 ',
            key = 'L',
            desc = 'Lazy',
            action = ':Lazy',
            enabled = package.loaded.lazy ~= nil,
          },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
      -- Used by the `header` section
      dashboard = {
        enabled = true,
        preset = {
          -- Used by the `header` section
          header = [[
██╗      ██╗ ██╗   ██╗ ███████╗  ██████╗  ███╗   ██╗ ██╗ ████████╗
██║      ██║ ██║   ██║ ██╔════╝ ██╔═══██╗ ████╗  ██║ ██║ ╚══██╔══╝
██║      ██║ ██║   ██║ █████╗   ██║   ██║ ██╔██╗ ██║ ██║    ██║   
██║      ██║ ╚██╗ ██╔╝ ██╔══╝   ██║   ██║ ██║╚██╗██║ ██║    ██║   
███████╗ ██║  ╚████╔╝  ███████╗ ╚██████╔╝ ██║ ╚████║ ██║    ██║   
╚══════╝ ╚═╝   ╚═══╝   ╚══════╝  ╚═════╝  ╚═╝  ╚═══╝ ╚═╝    ╚═╝   ]],
        },
      },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
}
