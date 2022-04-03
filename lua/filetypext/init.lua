local M = {}

---Detect file name.
---@param opts table|nil: |filetypext.nvim-opts|
---@return table: detected file names
function M.detect(opts)
  return require("filetypext.command").detect(opts)
end

return M
