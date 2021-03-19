execute 'set runtimepath+=' .. expand('<sfile>:h:h')
execute 'set runtimepath+=' .. expand('<sfile>:h') .. '/plenary.nvim/'
execute 'set runtimepath+=' .. expand('<sfile>:h') .. '/tree-sitter-lua/'
runtime! plugin/plenary.vim
