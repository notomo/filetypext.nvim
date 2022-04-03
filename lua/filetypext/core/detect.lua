local Detect = {}

function Detect.file_names(base_name, filetype, fallback_filetype, mapping)
  if not filetype or filetype == "" then
    filetype = fallback_filetype
  end

  local names = mapping[filetype] or {}
  if not names[1] then
    return { ("%s.%s"):format(base_name, filetype) }
  end

  return vim.tbl_map(function(name)
    return name:format(base_name)
  end, names)
end

return Detect
