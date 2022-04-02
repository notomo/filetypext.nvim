local M = {}

---Detect file name from given context.
---@param ctx table: |filetypext.nvim-ctx|
---@param opts table|nil: |filetypext.nvim-opts|
---@return table: detected file names
function M.detect(ctx, opts)
  return require("filetypext.command").detect(ctx, opts)
end

return M
