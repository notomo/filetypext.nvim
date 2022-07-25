local file_name = require("filetypext").detect({ filetype = "python" })[1]
vim.cmd.edit(file_name) -- edit scratch.py
