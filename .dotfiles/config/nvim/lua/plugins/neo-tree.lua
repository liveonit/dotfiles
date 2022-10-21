-- Neo Tree --
-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- If you want icons for diagnostic errors, you'll need to define them somewhere:
vim.fn.sign_define("DiagnosticSignError", {text = " ", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn", {text = " ", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo", {text = " ", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint", {text = "", texthl = "DiagnosticSignHint"})

require("neo-tree").setup({
    default_source = "filesystem",
    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    -- popup_border_style is for input and confirmation dialogs.
    -- Configurtaion of floating window is done in the individual source sections.
    -- "NC" is a special style that works well with NormalNC set
    popup_border_style = "rounded", -- "double", "none", "rounded", "shadow", "single" or "solid"
    use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
    close_floats_on_escape_key = true,
    enable_diagnostics = true,
    enable_git_status = true,
    git_status_async = false,
    open_files_in_last_window = true, -- false = open files in top left window
    log_level = "info", -- "trace", "debug", "info", "warn", "error", "fatal"
    log_to_file = false, -- true, false, "/path/to/file.log", use :NeoTreeLogs to show the file
    default_component_configs = {
        indent = {
            indent_size = 2,
            padding = 2,
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander"
        },
        icon = {folder_closed = "", folder_open = "", folder_empty = "", default = "*"},
        name = {trailing_slash = false, use_git_status_colors = true},
        git_status = {
            symbols = {
                -- Change type
                added = "✚",
                deleted = "✖",
                modified = "",
                renamed = "",
                -- Status type
                untracked = "",
                ignored = "",
                unstaged = "",
                staged = "",
                conflict = ""
            }
        }
    },
    window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
        -- possible options. These can also be functions that return these options.
        position = "left", -- left, right, float, current
        -- Mappings for tree window. See `:h nep-tree-mappings` for a list of built-in commands.
        -- You can also create your own commands by providing a function instead of a string.
        mappings = {
            ["<space>"] = "toggle_node",
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["c"] = "close_node",
            ["z"] = "close_all_nodes",
            ["R"] = "refresh",
            ["%"] = "add",
            ["d"] = "add_directory",
            ["D"] = "delete",
            ["R"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["C"] = "copy", -- takes text input for destination
            ["m"] = "move", -- takes text input for destination
            ["q"] = "close_window"
        }
    },
    renderers = {
        directory = {
            {"indent"}, {"icon"}, {"current_filter"}, {"name"}, {"clipboard"}, {"diagnostics", errors_only = true},
            {"git_status"}
        },
        file = {
            {"indent"}, {"icon"}, {"name", use_git_status_colors = true}, {"bufnr"}, {"clipboard"}, {"diagnostics"},
            {"git_status"}
        }
    },
    nesting_rules = {},
    filesystem = {
        window = {
            mappings = {
                ["H"] = "toggle_hidden",
                ["/"] = "fuzzy_finder",
                -- ["/"] = "filter_as_you_type", -- this was the default until v1.28
                ["f"] = "filter_on_submit",
                ["<C-x>"] = "clear_filter",
                ["-"] = "navigate_up",
                ["."] = "set_root"
            }
        },
        bind_to_cwd = false, -- true creates a 2-way binding between vim's cwd and neo-tree's root
        -- The renderer section provides the renderers that will be used to render the tree.
        --   The first level is the node type.
        --   For each node type, you can specify a list of components to render.
        --       Components are rendered in the order they are specified.
        --         The first field in each component is the name of the function to call.
        --         The rest of the fields are passed to the function as the "config" argument.
        filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
                ".DS_Store", "thumbs.db"
                -- "node_modules"
            },
            never_show = { -- remains hidden even if visible is toggled to true
                ".DS_Store"
                -- "thumbs.db"
            }
        },
        find_by_full_path_words = false, -- `false` means it only searches the tail of a path.
        -- `true` will change the filter into a full path
        -- search with space as an implicit ".*", so
        -- `fi init`
        -- will match: `./sources/filesystem/init.lua
        -- find_command = "fd", -- this is determined automatically, you probably don't need to set it
        -- find_args = {  -- you can specify extra args to pass to the find command.
        --  fd = {
        --  "--exclude", ".git",
        --  "--exclude",  "node_modules"
        --  }
        -- },
        ---- or use a function instead of list of strings
        -- find_args = function(cmd, path, search_term, args)
        --  if cmd ~= "fd" then
        --    return args
        --  end
        --  --maybe you want to force the filter to always include hidden files:
        --  table.insert(args, "--hidden")
        --  -- but no one ever wants to see .git files
        --  table.insert(args, "--exclude")
        --  table.insert(args, ".git")
        --  -- or node_modules
        --  table.insert(args, "--exclude")
        --  table.insert(args, "node_modules")
        --  --here is where it pays to use the function, you can exclude more for
        --  --short search terms, or vary based on the directory
        --  if string.len(search_term) < 4 and path == "/home/cseickel" then
        --    table.insert(args, "--exclude")
        --    table.insert(args, "Library")
        --  end
        --  return args
        -- end,
        search_limit = 50, -- max number of search results when using filters
        follow_current_file = true, -- This will find and focus the file in the active buffer every time
        -- the current file is changed while the tree is open.
        hijack_netrw_behavior = "disabled", -- netrw disabled, opening a directory opens neo-tree
        -- in whatever position is specified in window.position
        -- "open_current",-- netrw disabled, opening a directory opens within the
        -- window like netrw would, regardless of window.position
        -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
        use_libuv_file_watcher = false -- This will use the OS level file watchers to detect changes
        -- instead of relying on nvim autocmd events.
    },
    buffers = {
        bind_to_cwd = false,
        window = {mappings = {["-"] = "navigate_up", ["."] = "set_root", ["x"] = "buffer_delete"}}
    },
    git_status = {
        window = {
            mappings = {
                ["gA"] = "git_add_all",
                ["gu"] = "git_unstage_file",
                ["ga"] = "git_add_file",
                ["gr"] = "git_revert_file",
                ["gc"] = "git_commit",
                ["gp"] = "git_push",
                ["gg"] = "git_commit_and_push"
            }
        }
    }
})
