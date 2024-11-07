local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(_, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require ('mason-nvim-dap').setup({
    ensure_installed = {'js'},
    handlers = {},
})

require('mason-tool-installer').setup({
  ensure_installed = {
    "prettier", -- "prettier formatter
    "eslint_d", -- "eslint linter
  },
})

require('mason-lspconfig').setup({
  ensure_installed = {
    "ts_ls",
    -- "solargraph",
    "tailwindcss",
    -- "rubocop"
  },
  handlers = {
    lsp_zero.default_setup,
    tailwindcss = function()
      require('lspconfig').tailwindcss.setup({
        settings = {
          tailwindCSS = {
            rootFontSize = 10
          }
        }
      })
    end,
    --[[ rubocop = function()
      require('lspconfig').rubocop.setup({
        cmd = { "bundle", "exec", "rubocop", "--lsp" },
        root_dir = require('lspconfig').util.root_pattern("Gemfile", ".git", ".")
      })
    end,
    solargraph = function()
      require('lspconfig').solargraph.setup({
        cmd = { os.getenv("HOME") .. "/.asdf/shims/solargraph", "stdio" },
        root_dir = require('lspconfig').util.root_pattern("Gemfile", ".git", "."),
        settings = {
          autoformat = true,
          completion = true,
          diagnostics = true,
          folding = true,
          references = true,
          rename = true,
          symbols = true,
        }
      })
    end, ]]
    tsserver = function()
      require('lspconfig').tsserver.setup({
        on_init = function(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentFormattingRangeProvider = false
        end,
      })
    end,
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT'
            },
            diagnostics = {
              globals = {'vim'},
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
              }
            }
          }
        }
      })
    end,
  },
})

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

require("luasnip.loaders.from_vscode").lazy_load()
require'luasnip'.filetype_extend("ruby", {"rails"})

cmp.setup({
  sources = {
    {name = 'buffer'},
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
        -- that way you will only jump inside the snippet region
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      elseif vim.b._copilot_suggestion ~= nil then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes(vim.fn['copilot#Accept'](), true, true, true), '')
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})


