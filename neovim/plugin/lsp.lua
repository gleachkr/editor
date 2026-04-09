--setup neodev

require("lazydev").setup()

vim.lsp.enable("racket_langserver")
vim.lsp.enable("bashls")
vim.lsp.enable("clangd")
vim.lsp.enable("cssls")
vim.lsp.enable("dafny")
vim.lsp.enable("hls")
vim.lsp.enable("html")
vim.lsp.enable("eslint")
vim.lsp.enable("jedi_language_server")
vim.lsp.enable("jsonls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("nil_ls")
vim.lsp.enable("ocamllsp")
vim.lsp.enable("pylsp")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("texlab")
vim.lsp.enable("ts_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("zls")


vim.api.nvim_create_autocmd("FileType", {
    callback = function() vim.lsp.start({
        name = 'quint',
        cmd = {'quint-language-server', '--stdio'},
        root_dir = vim.fs.dirname(nil)
    }) end,
    pattern = "quint"
})


vim.api.nvim_create_autocmd("FileType", {
    callback = function() vim.lsp.start({
        name = 'auf',
        cmd = {'abc', 'lsp'},
        root_dir = vim.fs.dirname(nil)
    }) end,
    pattern = {"aufbau", "metamath_zero"}
})
