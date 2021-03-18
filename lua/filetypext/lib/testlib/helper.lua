local M = {}

M.root = require("filetypext.lib.path").find_root()

function M.before_each()
  require("filetypext.lib.module").cleanup()
  vim.cmd("filetype on")
  vim.cmd("syntax enable")
end

function M.after_each()
  vim.cmd("tabedit")
  vim.cmd("tabonly!")
  vim.cmd("silent! %bwipeout!")
  vim.cmd("filetype off")
  vim.cmd("syntax off")
end

function M.set_lines(lines)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(lines, "\n"))
end

return M
