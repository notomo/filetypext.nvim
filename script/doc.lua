local docgen = require("docgen")

local docs = {}
docs.test = function()
  local output = io.open("./doc/filetypext.nvim.txt", "w")
  docgen.write("./lua/filetypext/init.lua", output)
  output:write("vim:tw=78:ts=8:ft=help\n")
  output:close()
end
docs.test()

return docs
