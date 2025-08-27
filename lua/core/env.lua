vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, vim.g.path_separator)
  .. vim.g.path_delimiter
  .. vim.env.PATH

