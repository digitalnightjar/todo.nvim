-- Prevent the plugin being loaded more than once
if (vim.g.loaded_todo_plugin ~= nil) then
	return
end
vim.g.loaded_todo_plugin = 1

-- Define the path where LuaRocks dependencies will be cloned
local lua_rocks_deps_loc = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h:r") .. "/deps/"
-- Extend the Lua package path to include the LuaRocks dependencies
package.path = package.path .. ";" .. lua_rocks_deps_loc .. "/lua-?/init.lua"

local fetch = require("todo.fetch")
local update = require("todo.update")

-- Creates an object for the module. All of the module's
-- functions are associated with this object, which is
-- returned when the module is called with `require`.
local M = {}

-- Routes calls made to this module to functions in the
-- plugin's other modules.
M.fetch_todos = fetch.fetch_todos
M.insert_todo = update.insert_todo
M.complete_todo = update.complete_todo

-- Creates the commands that can bell from your remaps
-- This is the lua equivelant of `command! -nargs=0 FetchTodos lua require("").fetch_todos()`
local function setup_autocmds()
	vim.api.nvim_create_user_command('FetchTodos', M.fetch_todos, { nargs='?' })
	vim.api.nvim_create_user_command('InsertTodo', M.insert_todo, { nargs='?' })
	vim.api.nvim_create_user_command('CompleteTodo', M.complete_todo, { nargs='?' })
end

function M.setup()
	-- Do additional setup here.

	-- Setup Commands
	setup_autocmds()
end

return M

