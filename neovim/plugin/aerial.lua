require("aerial").setup({
  -- Priority list of preferred backends for aerial.
  -- This can be a filetype map (see :help aerial-filetype-map)
  backends = {
      lectic = { "lsp" }
  },
  filter_kind = {
          "Class",
          "Constructor",
          "Enum",
          "Function",
          "Interface",
          "Module",
          "Method",
          "String",
          "Event",
  },
  show_guides = true,
  layout = {
      max_width = 0.35
  }
})
