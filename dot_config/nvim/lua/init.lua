require('Comment').setup()
require('mason').setup()
require('mason-lspconfig').setup()
require('telescope').load_extension('aerial')
require('telescope').load_extension('dap')

require('dap-go').setup()
require('dapui').setup()
require('nvim-dap-virtual-text').setup{
  enabled = true,
}

require('go')

require('gitsigns').setup()
require('lsp_signature').setup()

-- more mappings
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }

local global_keybinds = {
  ["gD"] = "<cmd>lua vim.lsp.buf.declaration()<CR>",
  -- ["gd"] = "<cmd>lua vim.lsp.buf.definition()<CR>", -- leaving this here in case telescope doesnt work
  ["K"] = "<cmd>lua vim.lsp.buf.hover()<CR>",
  ["<C-k>"] = "<cmd>lua vim.lsp.buf.signature_help()<CR>",
  ["<space>wa"] = "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
  ["<space>wr"] = "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
  ["<space>wl"] = "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
  ["<space>rn"] = "<cmd>lua vim.lsp.buf.rename()<CR>",
  ["<space>ca"] = "<cmd>lua vim.lsp.buf.code_action()<CR>",
  ["<space>f"] = "<cmd>lua vim.lsp.buf.formatting()<CR>",
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local base_on_attach = function(client, bufnr)
  for key, action in pairs(global_keybinds) do
    vim.api.nvim_buf_set_keymap(bufnr, 'n', key, action, opts)
  end
end

-- local sumneko_lua_on_attach = function(client, bufnr)

-- I want to put this elsewhere but idk rn
require('aerial').setup({
  on_attach = function(bufnr)
    vim.api.nvim_set_keymap('n', '<space>a', '<cmd>Telescope aerial<CR>', opts)
  end
})

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  'golangci_lint_ls',
  'gopls',
  'tsserver',
  'pyright',
  'rust_analyzer',
  'sumneko_lua',
  'kotlin_language_server',
  'vimls',
  'hls',
  'jdtls',
  'html',
  'marksman',
  'terraformls',
  'tflint',
}

local lspconfig = require'lspconfig'

for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = base_on_attach,
  }
end
