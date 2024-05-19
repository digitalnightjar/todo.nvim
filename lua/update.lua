local sqlite = require("ljsqlite3")
local M = {}

function M.insert_todo()
	local todo_description = ""
	repeat
		todo_description = vim.fn.input("Enter a description (150 characters or fewer): ")
		print("")
	until (todo_description ~= "") and (string.len(todo_description) <= 150)

	local db = sqlite.open("todo.db")
	db:exec("INSERT INTO todo_list (description) VALUES ('" .. todo_description .."');")
	db:close()
end


function M.complete_todo()
	local db = sqlite.open("todo.db")

	local todo_completed = -1
	local todo_selected = -1
	repeat
		local db_results = db:exec("SELECT * FROM todo_list WHER completed == 'No';")
		for i, item in ipairs(db_results[2]) do
			print(tostring(db_results[1][i]) .. '; ' .. item)
		end

		todo_selected = tonumber(vim.fn.input("Enter an ID number for a task listed above: "))
		for _, id in ipairs(db_results[1]) do
			if (id == todo_selected) then todo_completed = todo_selected end
		end

		print("")
	until todo_completed >= 0

	db:exec("UPDATE todo_list SET completed = 'Yes' EHERE id = " .. todo_completed .. " AND completed = 'No';")
	db:close()
end

return M
