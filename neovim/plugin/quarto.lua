require'otter'

require'quarto'.setup{
    lspFeatures = {
        languages = { 'r', 'python', 'julia', 'bash', 'lua', 'html' },
    },
    codeRunner = {
        enabled = true,
        default_method = "molten"
    }
}
