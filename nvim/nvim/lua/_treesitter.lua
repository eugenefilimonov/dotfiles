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
