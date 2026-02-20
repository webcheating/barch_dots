require("keymaps")
require("options")
require("plugins.lazy")
require("plugins.keymaps")

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.keymap.set({ 'n', 'v', 'x' }, 'w', 'k', { noremap = true })
vim.keymap.set({ 'n', 'v', 'x' }, 'a', 'h', { noremap = true })
vim.keymap.set({ 'n', 'v', 'x' }, 's', 'j', { noremap = true })
vim.keymap.set({ 'n', 'v', 'x' }, 'd', 'l', { noremap = true })
vim.keymap.set('n', 'q', 'i', { noremap = true })
vim.keymap.set('n', 'c', 'a', { noremap = true })
vim.keymap.set('n', 'C', 'a', { noremap = true })

-- vim.keymap.set('n', 'W', '<C-u>')
-- vim.keymap.set('n', 'S', '<C-d>')
-- vim.keymap.set('v', 'w', 'k')
-- vim.keymap.set('v', 'a', 'h')
-- vim.keymap.set('v', 's', 'j')
-- vim.keymap.set('v', 'd', 'l')

vim.keymap.set({ 'n', 'v', 'x' }, 'W', '5k')
vim.keymap.set({ 'n', 'v', 'x' }, 'S', '5j')
vim.keymap.set({ 'n', 'v', 'x' }, 'A', 'b')
vim.keymap.set({ 'n', 'v', 'x' }, 'D', 'e')
