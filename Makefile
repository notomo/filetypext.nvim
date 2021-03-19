test:
	vusted --shuffle
.PHONY: test

doc: ./script/plenary.nvim ./script/tree-sitter-lua/parser/lua.so
	mkdir -p ./doc/
	nvim --headless --noplugin -u script/doc.vim -c "luafile ./script/doc.lua" -c 'quitall!'
	cat ./doc/filetypext.nvim.txt
.PHONY: doc

./script/tree-sitter-lua:
	git clone https://github.com/tjdevries/tree-sitter-lua.git $@

./script/tree-sitter-lua/parser/lua.so: ./script/tree-sitter-lua
	$(MAKE) -C ./script/tree-sitter-lua build_parser
	mkdir -p ./script/tree-sitter-lua/parser
	cp ./script/tree-sitter-lua/build/parser.so $@

./script/plenary.nvim:
	git clone https://github.com/nvim-lua/plenary.nvim.git $@
