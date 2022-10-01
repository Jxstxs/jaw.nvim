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
M.checkTodoLine = function(line)
    for i = 1, #line, 1 do
        if line[i] ~= " " then
            return false
        end
    end
    return true
end

M.getVisualSelection = function ()
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

return M
