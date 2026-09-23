vim.keymap.set("n", "<Leader>g", "<cmd>ZenMode<CR>", { desc = "Toggle zemmode view" })

require'zen-mode'.setup{
    window = {
        backdrop = 1,
        width = 80,
        options = {
          signcolumn = "no", -- disable signcolumn
          number = false, -- disable number column
          relativenumber = false, -- disable relative numbers
          cursorline = false, -- disable cursorline
          cursorcolumn = false, -- disable cursor column
          foldcolumn = "0", -- disable fold column
          list = false, -- disable whitespace characters
        },
    },
    --fixes issue where BG is gray on certain colorschemes
    on_open = function(_) vim.cmd("hi ZenBg ctermbg=0") end,
}
