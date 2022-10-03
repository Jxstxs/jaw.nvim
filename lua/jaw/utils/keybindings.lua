local M = {}

-- checks if a key is already inside of the currently used keymap
-- @param: cmtbl: table: the currently used keymap with given mode
-- @param: spk: table: the plugin keybinding to check for
-- @return bool: true when found; false when not
M.checkKeyExists = function (cmtbl, spk)
    for _, cm in pairs(cmtbl) do
        if cm.lhs == string.gsub(spk.lhs, "<leader>", vim.g.mapleader) then
            return true
        end
    end
    return false
end

-- sorts out already used keybindings
-- @param keytable: table: the keys to check for
-- @return table: the available keys
M.returnAvailableKeys = function(keytable)
    local available_keys = {}
    local current_maps = { n = vim.api.nvim_get_keymap("n"), v = vim.api.nvim_get_keymap("v") }
    local sorted_plug_keys = { n = {}, v = {} }

    -- sort keys to specific mode table
    for _, tbl in pairs(keytable) do
        for _, mode in pairs(tbl.modes) do
            table.insert(sorted_plug_keys[mode], tbl)
        end
    end

    -- check for existing keys
    for _, mode in pairs({"n", "v"}) do
        for _, spk in pairs(sorted_plug_keys[mode]) do
            if M.checkKeyExists(current_maps[mode], spk) then
                print("[jaw] WARN: the Lhs: " .. spk.lhs .. " is already used in Mode: ".. mode .. ".")
            else
                table.insert(available_keys, spk)
            end
        end
    end

    return available_keys
end

-- sets the given keybinding in its given modes
-- @param: keytable: the keybinding to set
M.setKeys = function(keytable)
    for _, mode in pairs(keytable.modes) do
        local rhs
        if mode == "v" then
            rhs = string.format(":'<,'>%s<CR>", keytable.rhs)
        elseif mode == "n" then
            rhs = string.format(":%s<CR>", keytable.rhs)
        end
        vim.keymap.set(mode, keytable.lhs, rhs, {}) -- need to think of opts handling
    end
end

return M
