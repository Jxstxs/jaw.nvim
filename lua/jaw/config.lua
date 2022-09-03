local M = {}

M.config = {
}

-- Configures Jaw
-- @param opts[table]: the personal configuration
M.setup = function(opts)
    vim.tbl_deep_extend("force", M.config, opts)
end

