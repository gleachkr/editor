vim.cmd [[ColorScheme pencil]]
vim.opt_local.background="light"
vim.opt_local.spell=true
vim.opt_local.so=10
vim.opt_local.lsp=5

vim.keymap.set("n", "<localleader>f",
    vim.fn["pandoc#formatting#ToggleAutoformat"],
    { desc = "Toggle pandoc autoformat" }
)
