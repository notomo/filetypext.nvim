local util = require("genvdoc.util")
local plugin_name = vim.env.PLUGIN_NAME
local full_plugin_name = plugin_name .. ".nvim"

local example_path = ("./spec/lua/%s/example.lua"):format(plugin_name)
local example = vim.trim(util.read_all(example_path))
util.execute(example)

local default_option_as_text = "local all_detect_options = "
  .. util.extract_variable_as_text("./lua/filetypext/core/option.lua", "default", {
    target_node = "expression_list",
  })

require("genvdoc").generate(full_plugin_name, {
  source = { patterns = { ("lua/%s/init.lua"):format(plugin_name) } },
  chapters = {
    {
      name = function(group)
        return "Lua module: " .. group
      end,
      group = function(node)
        if node.declaration == nil or node.declaration.type ~= "function" then
          return nil
        end
        return node.declaration.module
      end,
    },
    {
      name = "STRUCTURE",
      group = function(node)
        if node.declaration == nil or node.declaration.type ~= "class" then
          return nil
        end
        return "STRUCTURE"
      end,
    },
    {
      name = "DEFAULT_OPTION",
      body = function()
        return util.help_code_block(default_option_as_text, { language = "lua" })
      end,
    },
    {
      name = "EXAMPLES",
      body = function()
        return util.help_code_block(example, { language = "lua" })
      end,
    },
  },
})

local gen_readme = function()
  local content = ([[
# %s

file type -> file names

## Example

```lua
%s
```]]):format(full_plugin_name, example)

  util.write("README.md", content)
end
gen_readme()
