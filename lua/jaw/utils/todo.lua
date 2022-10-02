local M = {}

local config = require("jaw.config").config
local e = require("jaw.config").ENUMS

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

return M
