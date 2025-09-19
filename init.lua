local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug('morhetz/gruvbox')
Plug('nvim-mini/mini.pick')
Plug('neovim/nvim-lspconfig')
Plug('mason-org/mason.nvim')
Plug('nvim-treesitter/nvim-treesitter', { ['branch'] = 'master', ['do'] = ':TSUpdate' })
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

vim.cmd('colorscheme gruvbox')
require('mini.pick').setup()
require('mason').setup()
require('nvim-treesitter.configs').setup {
	ensure_installed = { 'c', 'cpp', 'lua', 'vim' },
	highlight = { enable = true }
}

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client ~= nil and client:supports_method('testDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd('set completeopt+=noselect')

-- vim.keymap.set('n', '<leader>r', ':update<CR> :source<CR>')
-- vim.keymap.set('n', '<leader>w', ':wa<CR>')
-- vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>mf', ':Pick files<CR>')
vim.keymap.set('n', '<leader>mb', ':Pick buffers<CR>')
vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format)
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>x', '"+d<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>c', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>v', '"+p<CR>')
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
vim.keymap.set('n', '<F7>', '<cmd>make<CR>')
vim.keymap.set('n', '<F5>', '<cmd>make run<CR>')
vim.keymap.set('n', '<S-Insert>', '"+p')
vim.keymap.set('i', '<S-Insert>', '<C-r>+')

