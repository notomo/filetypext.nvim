local M = {}

M.default = {
  base_name = "scratch",
  fallback_filetype = "markdown",
  mapping = {
    python = { "%s.py" },
    make = { "Makefile", "%s.mk" },
    dockerfile = { "Dockerfile" },
    rust = { "%s.rs" },
    ruby = { "%s.rb" },
    markdown = { "%s.md" },
    javascript = { "%s.js" },
    typescript = { "%s.ts" },
    text = { "%s.txt" },
  },
}

function M.new(raw_opts)
  vim.validate({ raw_opts = { raw_opts, "table", true } })
  raw_opts = raw_opts or {}
  local opts = vim.tbl_deep_extend("force", M.default, raw_opts)
  vim.validate({
    base_name = { opts.base_name, "string" },
    fallback_filetype = { opts.fallback_filetype, "string" },
    mapping = { opts.mapping, "table" },
  })
  return opts
end

return M
