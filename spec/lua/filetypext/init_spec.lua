local helper = require("filetypext.lib.testlib.helper")
local filetypext = setmetatable({}, {
  __index = function(_, k)
    return require("filetypext")[k]
  end,
})

describe("filetypext", function()

  before_each(helper.before_each)
  after_each(helper.after_each)

  for _, c in ipairs({
    {ctx = {filetype = "python"}, expected = {"scratch.py"}},
    {ctx = {filetype = "make"}, expected = {"Makefile", "scratch.mk"}},
    {ctx = {filetype = "make"}, opts = {mapping = {make = {"%s.mk"}}}, expected = {"scratch.mk"}},
    {ctx = {filetype = "go"}, expected = {"scratch.go"}},
    {ctx = {}, expected = {"scratch.md"}},
    {expected = {"scratch.md"}},
    {opts = {base_name = "test"}, expected = {"test.md"}},
  }) do

    local ctx = vim.inspect(c.ctx, {newline = "", indent = ""})
    local opts = vim.inspect(c.opts, {newline = "", indent = ""})
    local expected = vim.inspect(c.expected, {newline = "", indent = ""})
    local case_name = ([[detect(%s, %s) == %s]]):format(ctx, opts, expected)

    it(case_name, function()
      local actual = filetypext.detect(c.ctx, c.opts)
      assert.is_same(c.expected, actual)
    end)
  end

  for _, c in ipairs({
    {ctx = {bufnr = 0}, expected = {"scratch.py"}},
    {ctx = {bufnr = 0, filetype = "go"}, expected = {"scratch.go"}},
  }) do

    local ctx = vim.inspect(c.ctx, {newline = "", indent = ""})
    local opts = vim.inspect(c.opts, {newline = "", indent = ""})
    local expected = vim.inspect(c.expected, {newline = "", indent = ""})
    local case_name = ([[detect(%s, %s) == %s in python buffer]]):format(ctx, opts, expected)

    it(case_name, function()
      vim.bo.filetype = "python"
      local actual = filetypext.detect(c.ctx, c.opts)
      assert.is_same(c.expected, actual)
    end)
  end

end)
