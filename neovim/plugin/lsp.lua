-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    -- Mappings.
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', '<LocalLeader>ca', vim.lsp.buf.code_action, opts)
end

--setup neodev

require("lazydev").setup()

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local generic = {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    }
}

require 'lspconfig'.racket_langserver.setup(generic)
require 'lspconfig'.bashls.setup(generic)
require 'lspconfig'.clangd.setup(generic)
require 'lspconfig'.cssls.setup(generic)
require 'lspconfig'.dafny.setup(generic)
require 'lspconfig'.hls.setup(generic)
require 'lspconfig'.html.setup(generic)
require 'lspconfig'.jedi_language_server.setup(generic)
require 'lspconfig'.jsonls.setup(generic)
require 'lspconfig'.lua_ls.setup(generic)
require 'lspconfig'.nil_ls.setup(generic)
require 'lspconfig'.ocamllsp.setup(generic)
require 'lspconfig'.pylsp.setup(generic)
require 'lspconfig'.rust_analyzer.setup(generic)
require 'lspconfig'.texlab.setup(generic)
require 'lspconfig'.ts_ls.setup(generic)

vim.api.nvim_create_autocmd("FileType", {
    callback = function() vim.lsp.start({
        name = 'quint',
        cmd = {'quint-language-server', '--stdio'},
        root_dir = vim.fs.dirname()
    }) end,
    pattern = "quint"
})
-- require 'coq-lsp'.setup {
--     lsp = {
--         on_attach = on_attach,
--         init_options = {
--             show_notices_as_diagnostics = true,
--         }
--     }
-- }
