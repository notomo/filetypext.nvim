local ReturnValue = require("filetypext.vendor.misclib.error_handler").for_return_value()

function ReturnValue.detect(ctx, opts)
  vim.validate({
    ctx = { ctx, "table", true },
    opts = { opts, "table", true },
  })
  ctx = ctx or {}
  opts = opts or {}
  return require("filetypext.mapping").Mapping.new(opts):from(ctx.filetype, ctx.bufnr)
end

return ReturnValue:methods()
