" Specify a directory for plugins call plug#begin('~/.config/nvim/plugged')
" Configure your plugins here.
" Hint: Make sure you use single quotes.

call plug#begin('~/.config/nvim/plugged')

Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " Show color square at the end of a color reference
Plug 'folke/tokyonight.nvim', { 'branch': 'main' } " UI theme
Plug 'folke/trouble.nvim' " A pretty list for showing diagnostics, references, telescope results, quickfix and location lists

" CMP and LSP Support
Plug 'hrsh7th/cmp-buffer' " source for buffer words.
Plug 'hrsh7th/cmp-cmdline' " source for vim's cmdline.
Plug 'hrsh7th/cmp-nvim-lsp' " source for neovim's built-in language server client.
Plug 'hrsh7th/cmp-nvim-lua' " source for neovim Lua API
Plug 'hrsh7th/cmp-path' " source for filesystem paths
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip' " lua completion source for nvim-cmp
Plug 'hrsh7th/nvim-cmp' " A completion engine plugin for neovim written in Lua. Completion sources are installed from external repositories and 'sourced'.
Plug 'neovim/nvim-lspconfig' " Required
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}
Plug 'rafamadriz/friendly-snippets'

Plug 'sindrets/diffview.nvim' " Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
Plug 'nvim-lualine/lualine.nvim' " A blazing fast and easy to configure Neovim statusline written in Lua.
Plug 'nvim-telescope/telescope.nvim' " Is a highly extendable fuzzy finder over lists.
Plug 'nvim-telescope/telescope-live-grep-args.nvim' " Live grep args picker for telescope.nvim.
Plug 'nvim-treesitter/nvim-treesitter' " Sintax highlight
Plug 'nvim-treesitter/nvim-treesitter-textobjects' " dependency for nvim-treesitter
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' } " A vim plugin wrapper for prettier, pre-configured with custom default prettier settings.
Plug 'tpope/vim-commentary' " Comment stuff out
Plug 'tpope/vim-fugitive' " Git plugin for Vim
Plug 'tribela/vim-transparent'
Plug 'windwp/nvim-autopairs' " A super powerful autopair plugin for Neovim that supports multiple characters.
Plug 'akinsho/bufferline.nvim', { 'tag': '*' } " A snazzy 💅 buffer line (with tabpage integration) for Neovim built using lua.
Plug 'junegunn/fzf' " fzf is a general-purpose command-line fuzzy finder.
Plug 'junegunn/fzf.vim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'RRethy/vim-illuminate' " automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching
Plug 'folke/which-key.nvim' " displays a popup with possible key bindings of the command you started typing
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lua/plenary.nvim' " required by file-browser
Plug 'nvim-telescope/telescope-file-browser.nvim' " is a file browser extension for telescope.nvim

" Plug 'github/copilot.vim'
" Plug 'zbirenbaum/copilot.lua'
" Plug 'zbirenbaum/copilot-cmp'

Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mxsdev/nvim-dap-vscode-js'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'SmiteshP/nvim-navic'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

Plug 'nvim-pack/nvim-spectre'

Plug 'folke/todo-comments.nvim'

" Don't configure any plugin under this line.
call plug#end()

" Disable automatic folding on vim-markdown
let g:vim_markdown_folding_disabled = 1

" Disable default GitGutter mappings
let g:gitgutter_map_keys = 0

" Configure editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Configure Markdown Preview
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1

" Convert the current colorscheme into an fzf configuration line
let g:fzf_colors =
\ { 'fg':         ['fg', 'Normal'],
  \ 'bg':         ['bg', 'Normal'],
  \ 'preview-bg': ['bg', 'NormalFloat'],
  \ 'hl':         ['fg', 'Comment'],
  \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':        ['fg', 'Statement'],
  \ 'info':       ['fg', 'PreProc'],
  \ 'border':     ['fg', 'Ignore'],
  \ 'prompt':     ['fg', 'Conditional'],
  \ 'pointer':    ['fg', 'Exception'],
  \ 'marker':     ['fg', 'Keyword'],
  \ 'spinner':    ['fg', 'Label'],
  \ 'header':     ['fg', 'Comment'] }

" Configure vim-hexokinase
let g:Hexokinase_highlighters = ['virtual']

" Configure Neo-Tree
let g:neo_tree_remove_legacy_commands = 1
