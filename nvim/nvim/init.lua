-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
  print('Done.')
end

vim.opt.rtp:prepend(lazypath)

-- PLUGIN setup
require("lazy").setup("plugins")
require("_lsp_zero")
require("_telescope")
require("_treesitter")
require("_nvim_tree")
require("_noice")
require("_lualine")
require("_gruvbox")
require("Comment").setup()

-- General Vim/Nvim Configs
require("_configs")
require("_vim_diag")
