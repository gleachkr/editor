vim.api.nvim_create_autocmd( 'FileType', { pattern = '*',
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
        -- vim.bo[args.buf].syntax = 'on'  -- only if additional legacy syntax is needed
    end
})
