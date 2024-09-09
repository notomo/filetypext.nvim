local helper = require("filetypext.test.helper")
local filetypext = helper.require("filetypext")
local assert = require("assertlib").typed(assert)

describe("filetypext", function()
  before_each(helper.before_each)
  after_each(helper.after_each)

  for _, c in ipairs({
    { opts = { filetype = "python" }, expected = { "scratch.py" } },
    { opts = { filetype = "make" }, expected = { "Makefile", "scratch.mk" } },
    {
      opts = { filetype = "make", mapping = { make = { "%s.mk" } } },
      expected = { "scratch.mk" },
    },
    { opts = { filetype = "go" }, expected = { "scratch.go" } },
    { opts = {}, expected = { "scratch.md" } },
    { expected = { "scratch.md" } },
    { opts = { base_name = "test" }, expected = { "test.md" } },
  }) do
    local opts = vim.inspect(c.opts, { newline = "", indent = "" })
    local expected = vim.inspect(c.expected, { newline = "", indent = "" })
    local case_name = ([[detect(%s) == %s]]):format(opts, expected)

    it(case_name, function()
      local actual = filetypext.detect(c.opts)
      assert.same(c.expected, actual)
    end)
  end

  for _, c in ipairs({
    { opts = { bufnr = 0 }, expected = { "scratch.py" }, filetype = "python" },
    { opts = { bufnr = 0, filetype = "go" }, expected = { "scratch.go" }, filetype = "python" },
    { opts = { bufnr = 0 }, expected = { "scratch.md" }, filetype = "" },
    {
      opts = { bufnr = 0, fallback_filetype = "text" },
      expected = { "scratch.txt" },
      filetype = "",
    },
  }) do
    local opts = vim.inspect(c.opts, { newline = "", indent = "" })
    local expected = vim.inspect(c.expected, { newline = "", indent = "" })
    local case_name = ([[detect(%s) == %s if filetype == `%s`]]):format(opts, expected, c.filetype)

    it(case_name, function()
      vim.bo.filetype = c.filetype
      local actual = filetypext.detect(c.opts)
      assert.same(c.expected, actual)
    end)
  end
end)
