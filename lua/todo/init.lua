-- Prevent the plugin being loaded more than once
if (vim.g.loaded_todo_plugin ~= nil) then
	return
end

vim.g.loaded_todo_plugin = 1

-- import the plugins additional lua modules
-- local oldreq = require
-- local require = function(s) return oldreq('todo.deps' .. s) end

local fetch = require("todo.fetch")
local update = require("todo.update")
--- Restore old requires
-- require = oldreq

-- Creates an object for the module. All of the module's
-- functions are associated with this object, which is
-- returned when the module is called with `require`.
local M = {}

-- Routes calls made to this module to functions in the
-- plugin's other modules.
M.fetch_todos = fetch.fetch_todos
M.insert_todos = update.insert_todos
M.complete_todos = update.complete_todos


-- Creates the commands that can bell from your remaps
-- This is the lua equivelant of `command! -nargs=0 FetchTodos lua require("").fetch_todos()`
local function setup_autocmds()
	vim.api.nvim_create_user_command('FetchTodos', M.fetch_todos, { nargs='0' })
	vim.api.nvim_create_user_command('InsertTodos', M.insert_todos, { nargs='0' })
	vim.api.nvim_create_user_command('CompleteTodos', M.complete_todos, { nargs='0' })
end

function M.setup()
	-- Do additional setup here.

	-- Setup Commands
	setup_autocmds()
end

return M

