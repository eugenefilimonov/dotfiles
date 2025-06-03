require("nvim-treesitter.configs").setup({
  -- A list of parser names, or "all"
  ensure_installed = {
    "bash",
    "git_rebase",
    "gitcommit",
    "lua",
    "javascript",
    "typescript",
    "yaml",
    "sql",
    "html",
    "vim",
    "ruby",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})

local api = require("nvim-tree.api")

local function opts(desc)
  return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end

vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
vim.keymap.set("n", "<C-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
