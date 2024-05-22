local sqlite = require("ljsqlite3")
local popup = require("plenary.popup")

-- Creates an object for the module.
local M = {}

local width = 100
local height = 50
local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
local bufnr = vim.api.nvim_create_buf(false, false)

local function create_todolist_window()
	local todo_win_id, win = popup.create(bufnr, {
        title = "Todos",
        highlight = "TodosWindow",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        borderchars = borderchars,
    })

    vim.api.nvim_win_set_option(
        win.border.win_id,
        "winhl",
        "Normal:TodosBorder"
    )

    return {
        bufnr = bufnr,
        win_id = todo_win_id,
    }
end

local function list_results_popup(win_title, list_items)
	local win_id, win = popup.create(bufnr, {
		title = win_title,
		highlight = "TodosWindow",
        	line = math.floor(((vim.o.lines - height) / 2) - 1),
        	col = math.floor((vim.o.columns - width) / 2),
        	minwidth = width,
        	minheight = height,
        	borderchars = borderchars,
	})
	for _, item in ipairs(list_items) do
		vim.api.nvim_echo({{item}},false,{})
		-- Append to list of results
		-- Open the popup and print the results
	end

	vim.api.nvim_win_set_option(
        win.border.win_id,
        "winhl",
        "Normal:TodosBorder"
    )

        vim.api.nvim_buf_set_lines(bufnr, 0, #db_results[2], false, db_results[2])

    return {
        bufnr = bufnr,
        win_id = todo_win_id,
    }
end

-- Fetches todo tasks from the database and
-- prints the output.
function M.fetch_todos()
    	local db = sqlite.open("todo.db")
    	local db_results = db:exec("SELECT * FROM todo_list WHERE completed == 'No';")
    	db:close()
	list_results_popup("Pending Todo Items", db_results);
end

function M.fetch_completed()
	local db = sqlite.open("todo.db");
	local db_results = db:exec("SELECT * FROM todo_list WHERE completed == 'Yes';");
	db:close()
	list_results_popup("Completed Todo Items", db_results);
	local content = {}

end

return M
