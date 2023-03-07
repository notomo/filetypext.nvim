local M = {}

--- See |filetypext.nvim-DEFAULT_OPTION| for all default options.
--- @class FiletypextDetectOption
--- @field base_name string? base file name.
--- @field bufnr integer? the number of a buffer
--- @field fallback_filetype string? filetype for fallback.
--- @field filetype string? file type
--- @field mapping table<string,string[]>? filetype to file name formats.

--- Detect file name.
--- @param opts FiletypextDetectOption?: |FiletypextDetectOption|
--- @return string[] # detected file names
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
