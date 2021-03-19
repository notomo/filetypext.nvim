local Command = require("filetypext.command").Command

---@tag filetypext
local filetypext = {}

---@class filetypext_ctx @ context parameter.
---@field filetype string: file type

---@class filetypext_opts @ optional parameter.
---@field base_name string: base file name (default: scratch)
---@field mapping filetypext_mapping: |filetypext_mapping|

---@class filetypext_mapping @ filetype to file name formats {make = {"%s.mk", "Makefile"}}

---Detect file name from given context.
---@param ctx table: |filetypext_ctx|
---@param opts table: optional |filetypext_opts|
---@return table: detected file names
function filetypext.detect(ctx, opts)
  return Command.new("detect", ctx, opts)
end

return filetypext
