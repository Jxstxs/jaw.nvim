local M = {}

local config = require("jaw.config").config
local utils  = require("jaw.utils")
local todo_utils = require("jaw.utils.todo")

M.insert = function(state)
    state = state or " "
    local lines = utils.getVisualSelection()

    -- check if the table is empty
    -- TODO: better non visual selection check
    if lines[1][1] ~= 0 and lines[1][2] ~= {} then
        for _, value in ipairs(lines) do
            if not utils.checkEmptyLine(value[2][1]) then
                vim.fn.setline(value[1], string.format(config.system["todo"].template, state, value[2][1]))
            end
        end
        -- clear the marks
        vim.api.nvim_buf_del_mark(0, "<")
        vim.api.nvim_buf_del_mark(0, ">")
    else
        -- gets the current line and sets it
        local current_line = vim.api.nvim_get_current_line()
        vim.api.nvim_set_current_line(string.format(config.system["todo"].template, state, current_line))
    end
end

M.toggle = function()
    local lines = utils.getVisualSelection()

    -- check if the table is empty
    -- TODO: better non visual selection check
    if lines[1][1] ~= 0 and lines[1][2] ~= {} then
        for _, line in ipairs(lines) do
            if not utils.checkEmptyLine(line[2][1]) then
                local state = todo_utils.checkTodoState(line[2][1]) -- get the state of the todo
                local splitted_line = utils.splitLineBy(line[2][1], "%S+") -- get the line splitted by spaces
                local start, todo_state = todo_utils.parseTodoState(state)
                local todo_text = table.concat(utils.sliceTable(splitted_line, start), " ") -- gets the todo text
                vim.fn.setline(line[1], string.format(config.system["todo"].template, todo_state, todo_text))
            end
        end

        -- clear the marks
        vim.api.nvim_buf_del_mark(0, "<")
        vim.api.nvim_buf_del_mark(0, ">")
    else
        local current_line = vim.api.nvim_get_current_line()
        local state = todo_utils.checkTodoState(current_line) -- get the state of the todo
        local splitted_line = utils.splitLineBy(current_line, "%S+") -- get the line splitted by spaces
        local start, todo_state = todo_utils.parseTodoState(state)
        local todo_text = table.concat(utils.sliceTable(splitted_line, start), " ") -- gets the todo text
        vim.api.nvim_set_current_line(string.format(config.system["todo"].template, todo_state, todo_text))
    end
end

return M
