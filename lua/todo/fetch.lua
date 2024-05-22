local sqlite = require("ljsqlite3")
local popup = require("plenary.popup")

-- Creates an object for the module.
local M = {}

local function create_todolist_window()
	local width = 100
	local height = 100
	local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
	local bufnr = vim.api.nvim_create_buf(false, false)
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

-- Fetches todo tasks from the database and
-- prints the output.
function M.fetch_todos()
    local db = sqlite.open("todo.db")

    local db_results = db:exec("SELECT * FROM todo_list WHERE completed == 'No';")
    for _, item in ipairs(db_results[2]) do print(item) end
    db:close()

    create_todolist_window()
end

return M
