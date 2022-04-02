local M = {}

M.default = {
  filetype = nil,
  bufnr = nil,
}

function M.filetype(raw_ctx)
  vim.validate({ raw_ctx = { raw_ctx, "table", true } })
  raw_ctx = raw_ctx or {}
  local ctx = vim.tbl_deep_extend("force", M.default, raw_ctx)
  vim.validate({
    filetype = { ctx.filetype, "string", true },
    bufnr = { ctx.bufnr, "number", true },
  })
  if ctx.filetype then
    return ctx.filetype
  end
  if ctx.bufnr then
    return vim.bo[ctx.bufnr].filetype
  end
  return nil
end

return M
