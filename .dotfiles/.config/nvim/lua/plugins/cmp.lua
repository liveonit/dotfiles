-- CMP --
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
local cmp = require 'cmp'
local lspkind = require 'lspkind'
local source_mapping = { buffer = "[BUF]", nvim_lsp = "[LSP]", nvim_lua = "[LUA]", path = "[PATH]", vsnip = "[SNIP]" }

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup {
    -- ℹ️  ℹ️  ℹ️  For cmp mappings, see lsp-zero plugin config ℹ️  ℹ️  ℹ️
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },
    completion = { keyword_length = 4, autocomplete = false },
        sources = cmp.config.sources({
        { name = 'nvim_lsp' }, { name = 'nvim_lua' }, { name = "luasnip" }, { name = 'path' },
        { name = 'buffer', default = 5, keyword_length = 5 }
    }),
    experimental = { native_menu = false, ghost_text = true },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            vim_item.with_text = false
            local menu = source_mapping[entry.source.name]
            vim_item.menu = menu
            return vim_item
        end
    },
    window = {
        documentation = cmp.config.window.bordered()
    }
}

-- Use buffer source for `/`.
cmp.setup.cmdline('/', { sources = { { name = 'buffer' } } })

-- User cmdline & path source for `:`
cmp.setup.cmdline(':', { sources = cmp.config.sources({ { name = 'path' }, { name = 'cmdline' } }) })

-- Configure autopairs
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

-- Use cmp as a flexible omnifunc manager
_G.vimrc = _G.vimrc or {}
_G.vimrc.cmp = _G.vimrc.cmp or {}
_G.vimrc.cmp.lsp = function()
    cmp.complete({ config = { sources = { { name = 'nvim_lsp' } } } })
end
_G.vimrc.cmp.snippet = function()
    cmp.complete({ config = { sources = { { name = 'vsnip' } } } })
end

vim.cmd([[
  inoremap <C-x><C-o> <cmd>lua vimrc.cmp.lsp()<CR>
  inoremap <C-x><C-s> <cmd>lua vimrc.cmp.snippet()<CR>
]])

--  see https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
vim.cmd [[
  highlight! link CmpItemMenu Comment
  " gray
  highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#a9b1d6
  " blue
  highlight! CmpItemAbbrMatch guibg=NONE guifg=#7aa2f7
  highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#2ac3de
  " light blue
  highlight! CmpItemKindVariable guibg=NONE guifg=#7dcfff
  highlight! CmpItemKindInterface guibg=NONE guifg=#7dcfff
  highlight! CmpItemKindText guibg=NONE guifg=#7dcfff
  " pink
  highlight! CmpItemKindFunction guibg=NONE guifg=#bb9af7
  highlight! CmpItemKindMethod guibg=NONE guifg=#bb9af7
  " front
  highlight! CmpItemKindKeyword guibg=NONE guifg=#e0af68
  highlight! CmpItemKindProperty guibg=NONE guifg=#e0af68
  highlight! CmpItemKindUnit guibg=NONE guifg=#e0af68
]]
