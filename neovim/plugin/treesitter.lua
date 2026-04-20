vim.api.nvim_create_autocmd( 'FileType', { pattern = '*',
    callback = function(args)
        if args.match ~= 'tex' then pcall(vim.treesitter.start, args.buf) end
        -- vim.bo[args.buf].syntax = 'on'  -- only if additional legacy syntax is needed
    end
})
