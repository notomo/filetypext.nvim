local Mapping = require("filetypext.mapping").Mapping
local messagelib = require("filetypext.lib.message")

local M = {}

local Command = {}
Command.__index = Command
M.Command = Command

function Command.new(name, ...)
  local args = {...}
  local f = function()
    return Command[name](unpack(args))
  end

  local ok, result = xpcall(f, debug.traceback)
  if not ok then
    return messagelib.error(result)
  end
  return result
end

function Command.detect(ctx, opts)
  vim.validate({ctx = {ctx, "table", true}, opts = {opts, "table", true}})
  ctx = ctx or {}
  opts = opts or {}
  return Mapping.new(opts):from(ctx.filetype)
end

return M
