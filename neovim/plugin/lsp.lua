--setup neodev

require("lazydev").setup()

vim.lsp.enable("racket_langserver")
vim.lsp.enable("bashls")
vim.lsp.enable("clangd")
vim.lsp.enable("cssls")
vim.lsp.enable("dafny")
vim.lsp.enable("hls")
vim.lsp.enable("html")
vim.lsp.enable("jedi_language_server")
vim.lsp.enable("jsonls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("nil_ls")
vim.lsp.enable("ocamllsp")
vim.lsp.enable("pylsp")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("texlab")
vim.lsp.enable("ts_ls")
vim.lsp.enable('pyright')

vim.api.nvim_create_autocmd("FileType", {
    callback = function() vim.lsp.start({
        name = 'quint',
        cmd = {'quint-language-server', '--stdio'},
        root_dir = vim.fs.dirname()
    }) end,
    pattern = "quint"
})


vim.api.nvim_create_autocmd("FileType", {
    callback = function() vim.lsp.start({
        name = 'lectic',
        cmd = {'lectic', 'lsp'},
        root_dir = vim.fs.root(0, { ".git", "lectic.yaml" }) or vim.fn.getcwd(),
        single_file_support = true,
    }) end,
    pattern = { "lectic", "lectic.markdown", "markdown.lectic" }
})

-- require 'coq-lsp'.setup {
--     lsp = {
--         on_attach = on_attach,
--         init_options = {
--             show_notices_as_diagnostics = true,
--         }
--     }
-- }
