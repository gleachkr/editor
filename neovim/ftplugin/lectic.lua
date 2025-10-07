--override gO from nvim's markdown.lua from the runtime ftplugin
vim.keymap.del('n', 'gO', { buffer = 0 })
vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol)
