vim.opt.number = true
vim.opt.history = 50
vim.opt.ruler = true

-- Tab stuff
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.clipboard:append("unnamedplus")
vim.opt.spell = true

-- Search configuration
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true

-- scroll a bit extra horizontally and vertically when at the end/bottom
vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 8

-- open new split panes to right and below (as you probably expect)
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Highlight trailing characters
vim.opt.listchars = {
  tab = "»·",
  trail = "·",
}
vim.opt.list = true
vim.keymap.set("n", "<leader>l", ":nohlsearch<CR><C-L>")
vim.keymap.set('n', '<leader>pp', ":GpChatToggle popup<CR>")

vim.cmd("set nobackup")
vim.cmd("set noswapfile")
vim.cmd("set nojoinspaces")

vim.o.background = "dark"
vim.cmd 'colorscheme gruvbox'
