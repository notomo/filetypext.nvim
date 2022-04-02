local ReturnValue = require("filetypext.vendor.misclib.error_handler").for_return_value()

function ReturnValue.detect(raw_ctx, raw_opts)
  local filetype = require("filetypext.core.context").filetype(raw_ctx)
  local opts = require("filetypext.core.option").new(raw_opts)
  return require("filetypext.core.mapping").new(opts):from(filetype)
end

return ReturnValue:methods()
