local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    if col == 0 then
        return false
    end

    local text = vim.api.nvim_buf_get_lines(
        0,
        line - 1,
        line,
        true
    )[1]
    return text:sub(col, col):match("%s") == nil
end

local blink = require("blink.cmp")

blink.setup({
    keymap = {
        preset = "none",
        ["<Tab>"] = {
            "select_next",
            function(cmp)
                if has_words_before() then
                    return cmp.show()
                end
            end,
            "fallback",
        },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-Space>"] = { "show", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
    },
    snippets = {
        preset = "luasnip",
    },
    completion = {
        list = {
            selection = {
                preselect = true,
                auto_insert = false,
            },
        },
        menu = {
            auto_show = false,
            draw = {
                components = {
                    label = {
                        width = {
                            fill = true,
                            max = 50,
                        },
                    },
                },
            },
        },
    },
    sources = {
        default = {
            "lsp",
            "snippets",
            "path",
            "buffer",
        },
        per_filetype = {
            lean = {
                "lsp",
                "snippets",
                "path",
                "buffer",
                "latex",
            },
            tla = {
                "lsp",
                "snippets",
                "path",
                "buffer",
                "latex",
            },
            mail = {
                "latex",
                "snippets",
                "lsp",
                "path",
                "buffer",
                "spell",
            },
            markdown = {
                "latex",
                "snippets",
                "lsp",
                "path",
                "buffer",
                "spell",
            },
            text = {
                "latex",
                "snippets",
                "lsp",
                "path",
                "buffer",
                "spell",
            },
            ["markdown.lectic"] = {
                "latex",
                "snippets",
                "lsp",
                "path",
                "buffer",
                "spell",
            },
            gitcommit = {
                "snippets",
                "git",
                "path",
            },
            octo = {
                "snippets",
                "git",
                "path",
            },
        },
        providers = {
            git = {
                name = "Git",
                module = "blink-cmp-git",
            },
            latex = {
                name = "Latex",
                module = "blink-cmp-latex",
                opts = {
                    insert_command = false,
                },
            },
            spell = {
                name = "Spell",
                module = "blink-cmp-spell",
                opts = {
                    keep_all_entries = true,
                    max_entries = 20,
                },
            },
        },
    },
    cmdline = {
        sources = function()
            local cmd_type = vim.fn.getcmdtype()
            if cmd_type == "/" or cmd_type == "?" then
                return { "buffer" }
            end
            if cmd_type == ":" or cmd_type == "@" then
                return { "cmdline" }
            end
            return {}
        end,
    },
    fuzzy = {
        implementation = "rust",
        prebuilt_binaries = {
            download = false,
        },
    },
})

vim.lsp.config("*", {
    capabilities = blink.get_lsp_capabilities(),
})
