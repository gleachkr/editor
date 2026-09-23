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
vim.lsp.enable("jsonls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("nil_ls")
vim.lsp.enable("ocamllsp")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("texlab")
vim.lsp.enable("ts_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("ruff")
vim.lsp.enable("zls")


vim.lsp.config("quint", {
    cmd = { "quint-language-server", "--stdio" },
    filetypes = { "quint" },
    root_markers = { ".git" },
})
vim.lsp.enable("quint")

vim.lsp.config("auf", {
    cmd = { "abc", "lsp" },
    filetypes = { "aufbau", "metamath_zero" },
    root_markers = { ".git" },
})
vim.lsp.enable("auf")
