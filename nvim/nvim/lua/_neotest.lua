require("neotest").setup({
  adapters = {
    require('neotest-jest')({
      jestCommand = "yarn jest",
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
  }
})

vim.api.nvim_set_keymap("n", '<leader>t', '<cmd>lua require("neotest").run.run()<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", '<leader>tt', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", '<leader>ts', '<cmd>lua require("neotest").summary.toggle()<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", '<leader>to', '<cmd>lua require("neotest").output.open({ enter = true })<cr>', {noremap = true, silent = true})
