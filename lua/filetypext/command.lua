local M = {}

function M.detect(raw_opts)
  local opts = require("filetypext.core.option").new(raw_opts)
  return require("filetypext.core.detect").file_names(
    opts.base_name,
    opts.filetype,
    opts.fallback_filetype,
    opts.mapping
  )
end

return M
