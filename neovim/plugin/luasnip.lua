local types = require("luasnip.util.types")

local luasnip = require 'luasnip'

luasnip.config.setup({
    store_selection_keys = '<c-s>',
    history = true,
    update_events = { "TextChanged", "TextChangedI" },
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "●", "DiagnosticWarn" } },
                hl_mode = "combine"
            }
        },
        [types.insertNode] = {
            active = {
                virt_text = { { "●", "DiagnosticInfo" } },
                hl_mode = "combine"
            }
        }
    },
})

vim.keymap.set('i','<C-j>', function()
    if luasnip.jumpable(1) then luasnip.jump(1) end
end)

vim.keymap.set('i','<S-C-j>', function()
    if luasnip.jumpable(-1) then luasnip.jump(-1) end
end)

require 'luasnip.loaders.from_vscode'.lazy_load()
