vim.keymap.set("n", "<leader>l", ":nohlsearch<CR><C-L>")

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-a>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
