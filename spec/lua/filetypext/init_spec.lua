local helper = require("filetypext.lib.testlib.helper")
local filetypext = helper.require("filetypext")

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
    {ctx = {bufnr = 0}, expected = {"scratch.py"}, filetype = "python"},
    {ctx = {bufnr = 0, filetype = "go"}, expected = {"scratch.go"}, filetype = "python"},
    {ctx = {bufnr = 0}, expected = {"scratch.md"}, filetype = ""},
    {
      ctx = {bufnr = 0},
      opts = {fallback_filetype = "text"},
      expected = {"scratch.txt"},
      filetype = "",
    },
  }) do

    local ctx = vim.inspect(c.ctx, {newline = "", indent = ""})
    local opts = vim.inspect(c.opts, {newline = "", indent = ""})
    local expected = vim.inspect(c.expected, {newline = "", indent = ""})
    local case_name = ([[detect(%s, %s) == %s if filetype == `%s`]]):format(ctx, opts, expected, c.filetype)

    it(case_name, function()
      vim.bo.filetype = c.filetype
      local actual = filetypext.detect(c.ctx, c.opts)
      assert.is_same(c.expected, actual)
    end)
  end

end)
