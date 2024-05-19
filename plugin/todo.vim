" Title:        Example Plugin
" Description:  A plugin to provide an example for creating Neovim plugins.
" Last Change:  8 November 2021
" Maintainer:   Example User <https://github.com/example-user>

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.
if exists("g:loaded_todo_nvim")
	finish
endif

let g:loaded_todo_nvim = 1

let s:lua_rocks_deps_loc = expand("<sfile>:h:r") . "/../lua/todo.nvim/deps"

" Defines a package path for Lua. This facilitates importing the
" Lua modules from the plugin's dependency directory.
exe "lua package.path = package.path .. ';" . s:lua_rocks_deps_loc . "/lua-?/init.lua'"

" Exposes the plugin's functions for use as commands in Neovim.
command! -nargs=0 FetchTodos lua require("todo.nvim").fetch_todos()
command! -nargs=0 InsertTodo lua require("todo.nvim").insert_todo()
command! -nargs=0 CompleteTodo lua require("todo.nvim").complete_todo()
