local M = {}

local config = require("jaw.config").config
local e = require("jaw.config").ENUMS

M.get_path = function()
    local path = nil

    if config.select_path == e.TELESCOPE_INPUT then
        print("[jaw] not implemented")
        path = "TELESCOPE_INPUT"
    elseif config.select_path == e.VIM_INPUT then
        vim.ui.input({
            default = config.system["get-path"].input.default,
            prompt = config.system["get-path"].input.prompt,
        }, function (input)
            if input ~= nil then
                -- WARN: not working (returns nil before the user is able to type stuff in)
                path = input
            end
        end)
    elseif config.select_path == e.NONE_INPUT then
        path = ""
    end

    return path
end

return M
