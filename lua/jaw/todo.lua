local M = {}

local config = require("jaw.config").config
local utils  = require("jaw.utils")

M.insert = function()
    local lines = utils.getVisualSelection()

    -- check if the table is empty
    -- TODO: better non visual selection check
    if lines[1][1] ~= 0 and lines[1][2] ~= {} then
        for _, value in ipairs(lines) do
            if not utils.checkTodoLine(value[2][1]) then
                vim.fn.setline(value[1], string.format(config.system["todo-insert"].template, value[2][1]))
            end
        end
        -- clear the marks
        vim.api.nvim_buf_del_mark(0, "<")
        vim.api.nvim_buf_del_mark(0, ">")
    else
        -- gets the current line and sets it
        local current_line = vim.api.nvim_get_current_line()
        vim.api.nvim_set_current_line(string.format(config.system["todo-insert"].template, current_line))
    end
end

M.toggle = function() end

return M
