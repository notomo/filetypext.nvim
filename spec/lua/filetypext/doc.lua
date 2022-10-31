local util = require("genvdoc.util")
local plugin_name = vim.env.PLUGIN_NAME
local full_plugin_name = plugin_name .. ".nvim"

local example_path = ("./spec/lua/%s/example.lua"):format(plugin_name)
dofile(example_path)

require("genvdoc").generate(full_plugin_name, {
  source = { patterns = { ("lua/%s/init.lua"):format(plugin_name) } },
  chapters = {
    {
      name = function(group)
        return "Lua module: " .. group
      end,
      group = function(node)
        if not node.declaration then
          return nil
        end
        return node.declaration.module
      end,
    },
    {
      name = "TYPES",
      body = function(ctx)
        local opts_text
        do
          local descriptions = {
            filetype = [[(string | nil): file type]],
            bufnr = [[(number | nil): the number of a buffer]],
            base_name = [[(string | nil): base file name.
    default: %s]],
            mapping = [[(table | nil): filetype to file name formats.
    default: %s]],
            fallback_filetype = [[(string | nil): filetype for fallback.
    default: %s]],
          }
          local default = require("filetypext.core.option").default
          local keys = vim.tbl_keys(descriptions)
          local lines = util.each_keys_description(keys, descriptions, default)
          opts_text = table.concat(lines, "\n")
        end

        return util.sections(ctx, {
          { name = "Option", tag_name = "opts", text = opts_text },
        })
      end,
    },
    {
      name = "EXAMPLES",
      body = function()
        return util.help_code_block_from_file(example_path)
      end,
    },
  },
})

local gen_readme = function()
  local f = io.open(example_path, "r")
  local exmaple = f:read("*a")
  local content = ([[
# %s

file type -> file names

## Example

```lua
%s```]]):format(full_plugin_name, exmaple)

  local readme = io.open("README.md", "w")
  readme:write(content)
  readme:close()
end
gen_readme()
