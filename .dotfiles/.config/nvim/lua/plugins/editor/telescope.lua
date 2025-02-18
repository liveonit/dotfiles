return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
          require('telescope').load_extension 'fzf'
        end,
      },
      {
        'nvim-telescope/telescope-file-browser.nvim',
        config = function()
          require('telescope').load_extension 'file_browser'
        end,
      },
      {
        'camgraff/telescope-tmux.nvim',
        keys = {
          {
            '<leader>m',
            ':Telescope tmux sessions<CR>',
            desc = 'T[m]ux sessions - telescope',
            silent = true,
          },
        },
        config = function()
          require('telescope').load_extension 'file_browser'
        end,
      },
    },
    keys = {
      {
        '<leader>tg',
        "<cmd>lua require'telescope.builtin'.live_grep()<CR>",
        desc = 'Live grep all files',
        mode = 'n',
      },
      {
        '<leader>tb',
        '<cmd>Telescope buffers<CR>',
        desc = 'Open Buffers',
        mode = 'n',
      },
      {
        '<leader>tt',
        "<cmd>lua require'telescope.builtin'.lsp_document_symbols()<CR>",
        desc = 'Document symbols',
        mode = 'n',
      },
      {
        '<leader>t?',
        '<cmd>Telescope current_buffer_fuzzy_find<CR>',
        desc = 'Fuzzy find in current buffer',
        mode = 'n',
      },
      {
        '<leader>ts',
        '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>',
        desc = 'Live grep with args',
        mode = 'n',
      },
      {
        '<leader>tf',
        "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<CR>",
        desc = 'Find files',
        mode = 'n',
      },
      {
        '<leader>td',
        "<cmd>lua require'telescope.builtin'.git_files()<CR>",
        desc = 'Find in git files',
        mode = 'n',
      },
      {
        '<leader>th',
        "<cmd>lua require'telescope.builtin'.oldfiles()<CR>",
        desc = 'Open recent files',
        mode = 'n',
      },
      {
        '<leader>te',
        '<cmd>Telescope file_browser \'cwd=<C-R>=expand("%:p:h")\'<CR>',
        desc = 'File browser home dir',
        mode = 'n',
      },
      {
        '<leader>tc',
        '<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>',
        desc = 'File browser in current directory',
        mode = 'n',
      },
    },
    config = function()
      -- Telescope --
      local is_telescope_installed, telescope = pcall(require, 'telescope')
      local is_telescope_actions_installed = pcall(require, 'telescope.actions')
      local is_trouble_installed, trouble =
        pcall(require, 'trouble.sources.telescope')
      local is_action_layout, action_layout =
        pcall(require, 'telescope.actions.layout')
      local fb_actions = require 'telescope._extensions.file_browser.actions'

      if
        not is_telescope_installed
        or not is_trouble_installed
        or not is_telescope_actions_installed
        or not is_action_layout
      then
        print(
          string.format(
            'is_telescope_installed: %s, is_trouble_installed: %s, is_telescope_actions_installed: %s, is_action_layout: %s',
            tostring(is_telescope_installed),
            tostring(is_trouble_installed),
            tostring(is_telescope_actions_installed),
            tostring(is_action_layout)
          )
        )
        return
      end

      telescope.setup {
        defaults = {
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
          },
          mappings = {
            i = {
              ['?'] = action_layout.toggle_preview,
              ['<C-t>'] = trouble.open,
            },
            n = { ['<C-t>'] = trouble.open },
          },
          prompt_prefix = ' ',
          selection_caret = ' ',
          entry_prefix = '  ',
          initial_mode = 'normal',
          selection_strategy = 'reset',
          sorting_strategy = 'ascending',
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = {
              prompt_position = 'top',
              preview_width = 0.50,
              results_width = 0.5,
            },
            vertical = { mirror = false },
            width = 0.90,
            height = 0.80,
            preview_cutoff = 100,
          },
          file_sorter = require('telescope.sorters').get_fuzzy_file,
          file_ignore_patterns = {
            'node_modules/',
            'plugged/',
            '.git/',
            '.next/',
            '.venv/',
          },
          generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
          path_display = { 'truncate' },
          winblend = 0,
          color_devicons = true,
          use_less = true,
          extensions = {
            fzf = {
              fuzzy = true,
              override_generic_sorter = true,
              override_file_sorter = true,
              case_mode = 'smart_case',
            },
          },
          set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
          file_previewer = require('telescope.previewers').vim_buffer_cat.new,
          grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
          qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
          -- Developer configurations: Not meant for general override
          buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
        },
        extensions = {
          file_browser = {
            -- path
            -- cwd
            cwd_to_path = false,
            grouped = false,
            files = true,
            add_dirs = true,
            -- depth = 5,
            auto_depth = true,
            select_buffer = false,
            hidden = { file_browser = true, folder_browser = true },
            -- respect_gitignore
            -- browse_files
            -- browse_folders
            hide_parent_dir = false,
            collapse_dirs = false,
            prompt_path = false,
            quiet = false,
            dir_icon = '',
            dir_icon_hl = 'Default',
            display_stat = { date = true, size = true, mode = true },
            hijack_netrw = false,
            use_fd = true,
            git_status = true,
            mappings = {
              ['i'] = {
                ['<A-c>'] = fb_actions.create,
                ['<S-CR>'] = fb_actions.create_from_prompt,
                ['<A-r>'] = fb_actions.rename,
                ['<A-m>'] = fb_actions.move,
                ['<A-y>'] = fb_actions.copy,
                ['<A-d>'] = fb_actions.remove,
                ['<C-o>'] = fb_actions.open,
                ['<C-g>'] = fb_actions.goto_parent_dir,
                ['<C-e>'] = fb_actions.goto_home_dir,
                ['<C-w>'] = fb_actions.goto_cwd,
                ['<C-t>'] = fb_actions.change_cwd,
                ['<C-f>'] = fb_actions.toggle_browser,
                ['<C-h>'] = fb_actions.toggle_hidden,
                ['<C-s>'] = fb_actions.toggle_all,
                ['<bs>'] = fb_actions.backspace,
              },
              ['n'] = {
                ['c'] = fb_actions.create,
                ['r'] = fb_actions.rename,
                ['m'] = fb_actions.move,
                ['y'] = fb_actions.copy,
                ['d'] = fb_actions.remove,
                ['o'] = fb_actions.open,
                ['g'] = fb_actions.goto_parent_dir,
                ['e'] = fb_actions.goto_home_dir,
                ['w'] = fb_actions.goto_cwd,
                ['t'] = fb_actions.change_cwd,
                ['f'] = fb_actions.toggle_browser,
                ['h'] = fb_actions.toggle_hidden,
                ['s'] = fb_actions.toggle_all,
              },
            },
          },
        },
      }
    end,
  },
}
