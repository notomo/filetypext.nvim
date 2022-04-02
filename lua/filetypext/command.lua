local ReturnValue = require("filetypext.vendor.misclib.error_handler").for_return_value()

function ReturnValue.detect(ctx, raw_opts)
  vim.validate({ ctx = { ctx, "table", true } })
  ctx = ctx or {}
  local opts = require("filetypext.core.option").new(raw_opts)
  return require("filetypext.core.mapping").Mapping.new(opts):from(ctx.filetype, ctx.bufnr)
end

return ReturnValue:methods()
