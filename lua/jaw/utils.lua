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

M.checkPath = function (_path)
    return path:new(_path):exists()
end

return M
