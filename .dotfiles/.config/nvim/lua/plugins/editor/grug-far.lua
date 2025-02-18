return {
  {
    'MagicDuck/grug-far.nvim',
    opts = { headerMaxWidth = 80 },
    cmd = 'GrugFar',
    keys = {
      {
        '<leader>rg',
        function()
          local grug = require 'grug-far'
          local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
          grug.open {
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
            },
          }
        end,
        mode = { 'n' },
        desc = 'Replace',
      },
      {
        '<leader>rg',
        function()
          local grug = require 'grug-far'
          local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
          grug.with_visual_selection {
            prefills = {
              filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
            },
          }
        end,
        mode = { 'v' },
        desc = 'Replace',
      },
      {
        '<leader>rb',
        function()
          local grug = require 'grug-far'
          grug.open {
            prefills = {
              paths = vim.fn.expand '%',
            },
          }
        end,
        mode = { 'n' },
        desc = 'Replace in current buffer',
      },
      {
        '<leader>rb',
        function()
          local grug = require 'grug-far'
          grug.with_visual_selection {
            prefills = {
              paths = vim.fn.expand '%',
            },
          }
        end,
        mode = { 'v' },
        desc = 'Replace in current buffer',
      },
    },
  },
}
