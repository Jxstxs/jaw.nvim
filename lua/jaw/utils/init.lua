local M = {}

local path = require("plenary.path")

local config = require("jaw.config").config
local e = require("jaw.config").ENUMS

-- checks if a choice is pro or contra
-- @param choices: string: a filed of the choices table
-- @param choice: string: the input given by the user
-- @return int: e.CHOICE_CHECK_PRO when the choice is pro; e.CHOICE_CHECK_CON when its contra; e.CHOICE_CHECK_NONE when nether
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

-- gets the selected lines via the visual selection
-- @return table: the lines inside the selection
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
