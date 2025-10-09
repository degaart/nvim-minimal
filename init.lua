vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug('morhetz/gruvbox')
Plug('nvim-mini/mini.pick')
Plug('neovim/nvim-lspconfig')
Plug('mason-org/mason.nvim')
Plug('nvim-treesitter/nvim-treesitter', { ['branch'] = 'master', ['do'] = ':TSUpdate' })
Plug('saghen/blink.cmp', { ['tag'] = 'v1.7.0' })
Plug('nvim-tree/nvim-tree.lua')
Plug('folke/which-key.nvim')
vim.call('plug#end')

vim.o.number = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.makeprg = 'cmake --build build'
vim.o.fileformats = 'unix,dos,mac'
vim.o.exrc = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.g.mapleader = ' '

vim.lsp.enable({ 'clangd', 'lua_ls' })
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
            }
        }
    }
})
vim.lsp.config('clangd', {
    cmd = { 'clangd',
        '--background-index',
        '--header-insertion=never',
        '--completion-style=detailed',
        '--function-arg-placeholders',
        '--fallback-style=llvm'
    }
})

vim.cmd('colorscheme gruvbox')
require('mini.pick').setup()
require('mason').setup()
require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'cpp', 'lua', 'vim' },
    highlight = { enable = true }
}
require('blink.cmp').setup({
    completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
    },
    keymap = { preset = 'super-tab', ['<C-y>'] = { "select_and_accept" } },
})
vim.api.nvim_set_hl(0, "SnippetTabstop", { bg = "NONE" })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client ~= nil and client:supports_method('testDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})
vim.o.completeopt = 'noselect'

require("nvim-tree").setup()

-- vim.keymap.set('n', '<leader>r', ':update<CR> :source<CR>')
-- vim.keymap.set('n', '<leader>w', ':wa<CR>')
-- vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>mf', ':Pick files<CR>')
vim.keymap.set('n', '<leader>mb', ':Pick buffers<CR>')
vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format)
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>x', '"+d')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>c', '"+y')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>v', '"+p')
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<leader>n', '<cmd>tabnext<CR>')
vim.keymap.set('n', '<leader>p', '<cmd>tabprevious<CR>')
vim.keymap.set('n', '<leader>N', '<cmd>cnext<CR>')
vim.keymap.set('n', '<leader>P', '<cmd>cprevious<CR>')
vim.keymap.set('n', '<leader>o', '<cmd>copen<CR>')
vim.keymap.set('n', '<leader>c', '<cmd>cclose<CR>')
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<F7>', ':update<CR> :make<CR>')
vim.keymap.set('n', '<F5>', ':make run<CR>')
vim.keymap.set('n', '<S-Insert>', '"+p')
vim.keymap.set('i', '<S-Insert>', '<C-r>+')
vim.keymap.set('n', 'grd', vim.lsp.buf.declaration)
vim.keymap.set('n', 'grD', vim.lsp.buf.definition)
vim.keymap.set('n', 'grr', vim.lsp.buf.rename)
vim.keymap.set('n', 'grR', vim.lsp.buf.references)
vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>ft', ':NvimTreeToggle<CR>')
vim.keymap.set('t', '<C-space>', "<C-\\><C-n>",{silent = true})


if vim.g.neovide then
  vim.o.guifont = 'Cascadia Mono:h11'
  vim.g.neovide_position_animation_length = 0.1
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_theme = 'dark'
  vim.g.neovide_remember_window_size = false
  vim.g.neovide_input_ime = false
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_short_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_cursor_vfx_mode = ''
  vim.keymap.set('n', '<leader>+', ':let g:neovide_scale_factor=g:neovide_scale_factor+0.1<CR>')
  vim.keymap.set('n', '<leader>-', ':let g:neovide_scale_factor=g:neovide_scale_factor-0.1<CR>')
  vim.keymap.set('n', '<leader>=', ':let g:neovide_scale_factor=1.0<CR>')
end

