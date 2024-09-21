-- Set the default colorscheme
vim.cmd([[colorscheme default]])

-- Enable transparency for the UI elements
vim.cmd([[highlight Normal guibg=none ctermbg=none]])
vim.cmd([[highlight NonText guibg=none ctermbg=none]])
vim.cmd([[highlight LineNr guibg=none ctermbg=none]])
vim.cmd([[highlight SignColumn guibg=none ctermbg=none]])

-- Load Packer
vim.cmd([[packadd packer.nvim]])

-- Packer startup function for managing plugins
require('packer').startup(function()
  -- Plugin for LSP configuration
  use 'neovim/nvim-lspconfig'

  -- Plugins for autocompletion and snippets
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'L3MON4D3/LuaSnip'

  -- Language-specific plugins (if needed)
  use 'lervag/vimtex'      -- LaTeX support
end)

-- Setup for nvim-cmp (autocompletion engine)
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- Snippet engine for LSP
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' }, -- LSP completion source
    { name = 'buffer' },   -- Buffer completion source
    { name = 'path' },     -- File path completion source
  },
})

-- Setup LSP servers with nvim-lspconfig
local lspconfig = require('lspconfig')

-- Python (Pyright)
lspconfig.pyright.setup{
  capabilities = require('cmp_nvim_lsp').default_capabilities()
}

-- TypeScript (ts_ls)
lspconfig.ts_ls.setup{
  capabilities = require('cmp_nvim_lsp').default_capabilities()
}


-- HTML
lspconfig.html.setup{
  capabilities = require('cmp_nvim_lsp').default_capabilities()
}

-- CSS
lspconfig.cssls.setup{
  capabilities = require('cmp_nvim_lsp').default_capabilities()
}

-- LaTeX (using texlab)
lspconfig.texlab.setup{
  capabilities = require('cmp_nvim_lsp').default_capabilities()
}

-- Go (gopls)
lspconfig.gopls.setup{
  capabilities = require('cmp_nvim_lsp').default_capabilities()
}

-- Rust (rust-analyzer)
lspconfig.rust_analyzer.setup{
  capabilities = require('cmp_nvim_lsp').default_capabilities()
}

-- C/C++ (clangd)
lspconfig.clangd.setup{
  capabilities = require('cmp_nvim_lsp').default_capabilities()
}

-- C# (omnisharp)
lspconfig.omnisharp.setup{
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  cmd = { "omnisharp" },  -- Adjust the path if necessary
}

-- Swift (sourcekit)
lspconfig.sourcekit.setup{
  capabilities = require('cmp_nvim_lsp').default_capabilities()
}

-- Optional: Diagnostics configuration
vim.diagnostic.config({
  virtual_text = false, -- Disable inline diagnostics
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Show diagnostics in a floating window on hover
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

-- Keybindings for LSP actions
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', { noremap = true, silent = true })

