" Change the map leader.
let mapleader=" "

" Switch to normal mode inside terminal mode
tnoremap <silent> jk <C-\><C-n>
" Shortcut to edit mappings.
nnoremap <silent> <leader>ei :e ~/.config/nvim/init.vim<CR>
nnoremap <silent> <leader>ec :e ~/.config/nvim/main.vim<CR>
nnoremap <silent> <leader>ep :e ~/.config/nvim/plugins.vim<CR>
nnoremap <silent> <leader>ef :e ~/.config/nvim/functions.vim<CR>
nnoremap <silent> <leader>em :e ~/.config/nvim/mappings.vim<CR>
" Shortcut to save the current buffer
nnoremap <silent> <C-s> :w<CR>
inoremap <silent> <C-s> <Esc>:w<CR>
vnoremap <silent> <C-s> <Esc>:w<CR>
" Shortcut to quit the current buffer
nnoremap <silent> <C-q> :q<CR>
inoremap <silent> <C-q> <Esc>:q<CR>
vnoremap <silent> <C-q> <Esc>:q<CR>
" Shortcut to save and quit the curren buffer.
nnoremap <silent> <leader>wq :wq<CR>
" Close split but keep buffer
nnoremap <silent> <leader>qs <C-w>q<CR>
" Close buffer but keep split
nnoremap <silent> <leader>qq :bd<CR>
" Close vim without saving
nnoremap <silent> <leader>qa :qa!<CR>
" Save the current buffers and close vim
nnoremap <silent> <leader>qw :xa<CR>
" Toggle the maximization of a Window
nnoremap <silent> <leader>mh :TSBufToggle highlight<CR>
" Shortcut to give execute permissions to a file
nnoremap <silent> <leader>cx :!chmod +x %<CR>
" Shortcut to source NVIM configuration
nnoremap <leader>sc :source ~/.config/nvim/init.vim<CR>
" Replay the last command change
nnoremap <leader>@ @:<CR>
" Replace the text object under the current cursor using lsp.
nnoremap <leader>r :lua require('lsp_rename').lsp_rename()<CR>
" Select and copy the current line.
nnoremap y y$
" Undo break points
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ( (<C-g>u
inoremap ) )<C-g>u
inoremap [ [<C-g>u
inoremap ] ]<C-g>u
inoremap { {<C-g>u
inoremap } }<C-g>u
" Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
" Better block tabbing
vnoremap <silent> < <gv
vnoremap <silent> > >gv
" Disable arrow keys
" noremap <up> <nop>
" noremap <right> <nop>
" noremap <down> <nop>
" noremap <left> <nop>
" Move C-u to C-j
" nnoremap <C-j> <C-d>zz
nnoremap <C-j> <cmd>lua require'neoscroll'.scroll(30, true, 150)<CR>
nnoremap <C-k> <cmd>lua require'neoscroll'.scroll(-30, true, 150)<CR>
vnoremap <C-j> <cmd>lua require'neoscroll'.scroll(30, true, 150)<CR>
vnoremap <C-k> <cmd>lua require'neoscroll'.scroll(-30, true, 150)<CR>
" Configure Telescope
nnoremap <silent> <leader>fg <cmd>lua require'telescope.builtin'.live_grep()<CR>
nnoremap <silent> <leader>fb <cmd>Telescope buffers<CR>
nnoremap <silent> <leader>ft <cmd>lua require'telescope.builtin'.lsp_document_symbols()<CR>
nnoremap <silent> <leader>?  <cmd>Telescope current_buffer_fuzzy_find<CR>
" Find in specific folders or files with ripgrep
" https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md
nnoremap <silent> <leader>fs <cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>
" Browse files
nnoremap <silent> <leader>ff <cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<CR>
nnoremap <silent> <leader>fd <cmd>lua require'telescope.builtin'.git_files()<CR>
nnoremap <silent> <leader>fh <cmd>lua require'telescope.builtin'.oldfiles()<CR>
nnoremap <silent> <leader>fe <cmd>Telescope file_browser 'cwd=<C-R>=expand("%:p:h")'<CR>
nnoremap <silent> <leader>fc <cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>
" Apply quotes under the selected word
nnoremap <silent> <leader>;q bi"<ESC>ea"<ESC>
" Get current path
nnoremap <silent> <leader>pwd :let @+ = expand("%:p")<CR>\|:echo expand("%:p")<CR>
nnoremap <silent> <leader>zf v%zf
" Move between illuminated words.
nnoremap <silent> <leader>nn :lua require("illuminate").goto_next_reference{wrap=true}<CR>
nnoremap <silent> <leader>pp :lua require("illuminate").goto_prev_reference{wrap=true}<CR>
" Toggle concealing characters.
nnoremap <silent> <leader>l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>
" Reset lualine.
nnoremap <silent> <leader>/ :lua require("lualine").setup()<CR>
" Open the Symbols Outline panel
nnoremap <silent> <leader>o :SymbolsOutline<CR>
" Toggle statusline and ruler
"  nnoremap <silent> <leader>h :call ToggleHiddenAll()<CR>
" Go to previous buffer
nnoremap <silent> <leader><leader> <C-^>

" Change camelCase to snake_case
vnoremap <leader>cs :'<,'>SnakeCase<CR>
" Convert snake_case to camelCase
vnoremap  <leader>cc :'<,'>CamelCase<CR>

" Allows better navigation through buffers
nnoremap <silent> <tab> :BufferLineCycleNext<CR>
nnoremap <silent> <s-tab> :BufferLineCyclePrev<CR>

" Reload luasnip snippets
nnoremap <leader><leader>s :lua require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/snippets"})<CR>

" Replace u in visual mode to be the same as y
vnoremap u y

nnoremap <silent> <leader>h  <cmd>WhichKey<cr>

" Commentary shortcuts
nnoremap <silent> <C-c> :Commentary<CR>
vnoremap <silent> <C-c> :Commentary<CR>
inoremap <silent> <C-c> <cmd>Commentary<CR>
