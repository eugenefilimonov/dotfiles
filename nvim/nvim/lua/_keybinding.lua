
vim.keymap.set("n", "<leader>l", ":nohlsearch<CR><C-L>")
vim.keymap.set('n', '<leader>pp', ":GpChatToggle popup<CR>")

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-a>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
