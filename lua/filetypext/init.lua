local Command = require("filetypext.command").Command

local M = {}

function M.detect(ctx, opts)
  return Command.new("detect", ctx, opts)
end

return M
