return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
    opts = {
      spec = {
        {
          '<leader>a',
          group = 'AI',
          icon = { icon = '󱚦', color = 'cyan' },
        },
        {
          '<leader>b',
          group = 'Buffers',
          icon = { icon = '', color = 'yellow' },
        },
        {
          '<leader>c',
          group = 'Code',
          mode = { 'n', 'x' },
          icon = { icon = '', color = 'green' },
        },
        {
          '<leader>d',
          group = 'Debug',
          icon = { icon = '', color = 'red' },
        },
        {
          '<leader>f',
          group = 'Find',
          icon = { icon = '󰈞', color = 'yellow' },
        },
        {
          '<leader>g',
          group = 'Git',
          icon = { icon = '󰊢', color = 'orange' },
        },
        {
          '<leader>h',
          group = 'C[h]atGpt',
          icon = { icon = '󱚦', color = 'cyan' },
        },
        {
          '<leader>gb',
          group = 'Buff/Blame',
          icon = { icon = '󰊢', color = 'orange' },
        },
        {
          '<leader>gd',
          group = 'Diff/Deleted',
          icon = { icon = '󰊢', color = 'orange' },
        },
        {
          '<leader>gh',
          group = 'Hunks',
          icon = { icon = '󰊢', color = 'orange' },
        },
        {
          '<leader>o',
          group = 'Overseer',
          icon = { icon = '', color = 'red' },
        },
        {
          '<leader>r',
          group = 'Replace',
          icon = { icon = '', color = 'blue' },
        },
        {
          '<leader>s',
          group = 'Search',
          icon = { icon = '', color = 'yellow' },
        },
        {
          '<leader>t',
          group = 'Telescope',
          icon = { icon = ' ', color = 'green' },
        },

        {
          '<leader>T',
          group = 'Test',
          icon = { icon = '󰙨', color = 'purple' },
        },
        {
          'gz',
          group = 'Surround',
          mode = { 'n', 'v' },
          icon = { icon = '', color = 'red' },
        },
      },
    },
  },
}
