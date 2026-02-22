-- Azzie's Neovim Config
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader key (before lazy)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core config
require("config.options")
require("config.keymaps")

-- Load plugins
require("lazy").setup("plugins", {
  change_detection = { notify = false },
})

require('cord').setup {
    -- Your configuration options go here
    enabled = true,
    display = {
        theme = 'atom', -- default, atom, catppuccin, minecraft, void, classic
        flavor = 'dark',
        view = 'full',
        swap_fields = false,
        swap_icons = false,
    },
    editor = {
        client = 'neovim',
        tooltip = 'The Superior Text Editor',
        icon = nil,
    },
    idle = {
        enabled = true,
        timeout = 1000000,
        -- timeout = 1,
        show_status = true,
        ignore_focus = true,
        unidle_on_focus = true,
        smart_idle = true,
        details = '',
        state = nil,
        tooltip = '💤',
        icon = nil,
    },
    buttons = nil,
    -- buttons = {
    --   {
    --     label = 'View Repository',
    --     url = function(opts) return opts.repo_url end,
    --   },
    -- },
}
-- require("keymaps")
-- require("options")
-- require("plugins.lazy")
-- require("plugins.keymaps")

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

vim.keymap.set({ 'n', 'v', 'x' }, 'W', '8k')
vim.keymap.set({ 'n', 'v', 'x' }, 'S', '8j')
vim.keymap.set({ 'n', 'v', 'x' }, 'A', 'b')
vim.keymap.set({ 'n', 'v', 'x' }, 'D', 'e')
