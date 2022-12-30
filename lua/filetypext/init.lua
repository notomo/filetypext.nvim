local M = {}

---Detect file name.
---@param opts table|nil: |filetypext.nvim-opts|
---@return table: detected file names
function M.detect(opts)
  opts = require("filetypext.core.option").new(opts)
  return require("filetypext.core.detect").file_names(
    opts.base_name,
    opts.filetype,
    opts.fallback_filetype,
    opts.mapping
  )
end

return M
