local Mapping = {}
Mapping.__index = Mapping

function Mapping.new(opts)
  local tbl = {
    _base_name = opts.base_name,
    _fallback_filetype = opts.fallback_filetype,
    _mapping = opts.mapping,
  }
  return setmetatable(tbl, Mapping)
end

function Mapping.from(self, filetype)
  if not filetype or filetype == "" then
    filetype = self._fallback_filetype
  end

  local names = self._mapping[filetype] or {}
  if not names[1] then
    return { ("%s.%s"):format(self._base_name, filetype) }
  end

  return vim.tbl_map(function(name)
    return name:format(self._base_name)
  end, names)
end

return Mapping
