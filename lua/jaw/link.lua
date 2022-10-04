local M = {}

local config = require("jaw.config").config
local utils = require("jaw.utils")
local link_utils = require("jaw.utils.link")
local select_utils = require("jaw.utils.select")

M.instert = function()
    local lines = utils.getVisualSelection()

    -- check if the table is empty
    -- TODO: better non visual selection check
    if lines[1][1] ~= 0 and lines[1][2] ~= {} then
        for _, value in ipairs(lines) do
            if not utils.checkEmptyLine(value[2][1]) then
                if not link_utils.checkLinkLine(value[2][1]) then
                    local selected_path = select_utils.get_path()
                    vim.fn.setline(value[1], string.format(config.system["link"].template, value[2][1], selected_path))
                else
                    print(config.system["link"].already_link)
                end
            end
        end
        -- clear the marks
        vim.api.nvim_buf_del_mark(0, "<")
        vim.api.nvim_buf_del_mark(0, ">")
    else
        -- gets the current line and sets it
        local current_line = vim.api.nvim_get_current_line()
        if not link_utils.checkLinkLine(current_line) then
            local selected_path = select_utils.get_path()
            vim.api.nvim_set_current_line(string.format(config.system["link"].template, current_line, selected_path))
        else
            print(config.system["link"].already_link)
        end
    end
end

M.follow = function() end

return M
