local sqlite = require("ljsqlite3")
local M = {}

function M.fetch_todos()
	local db = sqlite.open("todo.db")
	local db_results = db:exec("SELECT * FROM todo_list WHERE completed == 'No';")
	for _, item in ipairs(db_results[2]) do print(item) end
	db:close()
end
return M
