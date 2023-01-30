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
    ["typescript.tsx"] = { "%s.tsx" },
    ["typescriptreact"] = { "%s.tsx" },
    text = { "%s.txt" },
    gomod = { "go.mod" },
    ocaml = { "%s.ml" },
    terraform = { "%s.tf" },
    autohotkey = { "%s.ahk" },
    gitignore = { ".gitignore" },
  },
  filetype = nil,
  bufnr = nil,
}

local _filetype = function(filetype, bufnr)
  if filetype then
    return filetype
  end
  if bufnr then
    return vim.bo[bufnr].filetype
  end
  return nil
end

function M.new(raw_opts)
  vim.validate({ raw_opts = { raw_opts, "table", true } })
  raw_opts = raw_opts or {}
  local opts = vim.tbl_deep_extend("force", M.default, raw_opts)
  opts.filetype = _filetype(opts.filetype, opts.bufnr)
  vim.validate({
    base_name = { opts.base_name, "string" },
    fallback_filetype = { opts.fallback_filetype, "string" },
    mapping = { opts.mapping, "table" },
    filetype = { opts.filetype, "string", true },
  })
  return opts
end

return M
