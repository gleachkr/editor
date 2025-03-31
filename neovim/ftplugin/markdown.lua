if vim.fn.win_gettype() ~= "popup" then
    vim.cmd [[ColorScheme pencil]]
end

vim.opt_local.formatoptions='tanqwl'
vim.opt_local.formatlistpat = [[^\s*\([-*+∙∘•]\|\d\+\.\)\s\+]] 
vim.opt_local.background="light"
vim.opt_local.spell=true
vim.opt_local.so=10
vim.opt_local.lsp=5
