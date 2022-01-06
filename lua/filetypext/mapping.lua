local M = {}

local Mapping = {}
Mapping.__index = Mapping
M.Mapping = Mapping

Mapping.default = {
  python = { "%s.py" },
  make = { "Makefile", "%s.mk" },
  dockerfile = { "Dockerfile" },
  rust = { "%s.rs" },
  ruby = { "%s.rb" },
  markdown = { "%s.md" },
  javascript = { "%s.js" },
  typescript = { "%s.ts" },
  text = { "%s.txt" },
}

function Mapping.new(opts)
  vim.validate({ opts = { opts, "table" } })
  vim.validate({
    base_name = { opts.base_name, "string", true },
    mapping = { opts.mapping, "table", true },
  })
  local tbl = {
    _base_name = opts.base_name or "scratch",
    _fallback_filetype = opts.fallback_filetype or "markdown",
    _filetypes = vim.tbl_extend("force", Mapping.default, opts.mapping or {}),
  }
  return setmetatable(tbl, Mapping)
end

function Mapping.from(self, filetype, bufnr)
  vim.validate({ filetype = { filetype, "string", true }, bufnr = { bufnr, "number", true } })
  if filetype then
    filetype = filetype
  elseif bufnr then
    filetype = vim.bo[bufnr].filetype
  else
    filetype = self._fallback_filetype
  end
  if filetype == "" then
    filetype = self._fallback_filetype
  end

  local names = self._filetypes[filetype] or {}
  if not names[1] then
    return { ("%s.%s"):format(self._base_name, filetype) }
  end

  return vim.tbl_map(function(name)
    return name:format(self._base_name)
  end, names)
end

return M
