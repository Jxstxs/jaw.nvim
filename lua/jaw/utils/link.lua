local M = {}

local config = require("jaw.config").config

M.checkLinkLine = function (line)
    if string.match(line, config.system["link"].check_pattern) then
        return true
    end
    return false
end

return M
