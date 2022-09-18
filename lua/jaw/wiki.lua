local M = {}

local config = require("jaw.config").config
local e = require("jaw.config").ENUMS
-- local utils = require "jaw.utils"

local Job = require "plenary.job"

M.new = function()
    local on_confirm = function(input)
        if input ~= nil then
            local cgr = config.create_git_repo
            local cmd, args = nil, nil

            if cgr == e.PROMPT then
                -- local choice = nil
                -- -- get input
                --
                -- local cc = utils.checkChoice("wiki-new", choice)
                -- if cc == e.CHOICE_CHECK_PRO then
                --     cgr = e.ALWAYS
                -- elseif cc == e.CHOICE_CHECK_CON then
                --     cgr = e.ALWAYS
                -- elseif cc == e.CHOICE_CHECK_NONE then
                --     vim.api.nvim_notify(config.system["wiki-new"].output.no_input, 0, {})
                --     return
                -- end
                -- vim.api.nvim_notify("[jaw] Aborting.. not Implemented yet", 0, {})
                print "[jaw] Aborting.. not Implemented yet"
                return
            end

            if cgr == e.ALWAYS then
                cmd = "git"
                args = { "init", input }
            elseif cgr == e.NEVER then
                cmd = "mkdir"
                args = { "-m", "-p", input }
            end

            Job:new({
                command = cmd,
                args = args,
                cwd = "/usr/bin",
                on_stderr = config.system["wiki-new"].output.error,
                on_stdout = config.system["wiki-new"].output.stdout,
            }):sync()

            Job:new({
                command = config.shell,
                args = { config.new_wiki_template },
                cwd = "/usr/bin",
                on_stderr = config.system["wiki-new"].output.error,
                on_stdout = config.system["wiki-new"].output.stdout,
            }):sync()
        else
            vim.api.nvim_notify(config.system["wiki-new"].output.no_input, 0, {})
        end
    end

    vim.ui.input({
        prompt = config.system["wiki-new"].input.prompt,
        default = config.system["wiki-new"].input.default,
    }, on_confirm)
end

M.use = function() end

M.add = function() end

M.export = function() end

return M
