local M = {}

local path = require("plenary.path")

local config = require("jaw.config").config
local e = require("jaw.config").ENUMS

M.checkChoice = function(choices, choice)
    for _, value in ipairs(config.choices[choices].pro) do
        if choice == value then
            return e.CHOICE_CHECK_PRO
        end
    end

    for _, value in ipairs(config.choices[choices].con) do
        if choice == value then
            return e.CHOICE_CHECK_CON
        end
    end

    return e.CHOICE_CHECK_NONE
end

-- Checks if a Path exists
-- @param _path: string: path to check
-- @return bool: true when exists; false when not
M.checkPath = function(_path)
    return path:new(_path):exists()
end

-- checks if a line only contains spaces
-- @param line: string: line to check for
-- @retun bool: true when only spaces; false when not
M.checkEmptyLine = function(line)
    for i = 1, #line, 1 do
        if line[i] ~= " " then
            return false
        end
    end
    return true
end

M.getVisualSelection = function()
    -- get the start and end position of the selection
    local start_selection = vim.api.nvim_buf_get_mark(0, "<")[1] -- - 1
    local end_selection = vim.api.nvim_buf_get_mark(0, ">")[1]

    -- get the selected lines
    local lines = {}
    for i = start_selection, end_selection, 1 do
        table.insert(lines, { i, vim.fn.getline(i, i) })
    end

    return lines
end

-- checks the state of the todo
-- @param line: string: the string to check for the state
-- @return int: e.TODO_STATE_CHECKED when its checked; e.TODO_STATE_NON_CHECKED when not; -1 when both not found
M.checkTodoState = function(line)
    if string.match(line, config.system["todo"].matching.checked) then return e.TODO_STATE_CHECKED
    elseif string.match(line, config.system["todo"].matching.non_checked) then return e.TODO_STATE_NON_CHECKED
    else return -1
    end
end

-- checks if a line is a markdown todo (github falvour)
-- @param: string: the string to check if it contains an todo
-- @return bool: true when found; false when not
M.checkTodoLine = function(line)
    -- TODO: implement better ceck
    if M.checkTodoState(line) ~= -1 then
        return true
    end
    return false
end

-- decides where to star the slice and which text to put into the template
-- @param state: int: the state of the current todo line
-- @return int: where to start the slice
-- @return string: which character to put inside the template
M.parseTodoState = function(state)
    local start
    local state_text

    if state == e.TODO_STATE_CHECKED then
        start = 3
        state_text = " "
    elseif state == e.TODO_STATE_NON_CHECKED then
        start = 4
        state_text = config.system["todo"].checked_symbol
    end

    return start, state_text
end

-- splits a string by pattern
-- @param line: string: the string to split
-- @param pattern: string: the pattern to split the string
-- @return table: the splitted string
M.splitLineBy = function(line, pattern)
    local splits = {}
    for split in string.gmatch(line, pattern) do
        table.insert(splits, split)
    end

    return splits
end

-- slices a table from _start to _end
-- @param tbl: table: the table to slice
-- @param _start: int: the starting position of the slice
-- @param _end: int: the end position of the slice
-- @return table: the sliced table
M.sliceTable = function(tbl, _start, _end)
    _start = _start or 1
    _end = _end or #tbl

    if _start >= _end then return nil end

    local slice = {}
    for index, value in ipairs(tbl) do
        if index >= _start and index <= _end then
            table.insert(slice, value)
        end
    end

    return slice
end

return M
