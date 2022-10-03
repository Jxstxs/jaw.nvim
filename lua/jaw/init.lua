local requirements = {
    "plenary",
}

for _, requirement in ipairs(requirements) do
    local status, _ = pcall(require, requirement)
    if not status then
        vim.api.nvim_notify("[jaw] requirement: " .. requirement .. " is not satisfied", 0, {})
        return nil
    end
end

local M = {
    -- Configuration related
    config = require("jaw.config").config,
    setup = require("jaw.config").setup,

    -- Wiki related
    wikiNew = require("jaw.wiki").new, -- done
    wikiUse = require("jaw.wiki").use,
    wikiAdd = require("jaw.wiki").add,
    wikiExport = require("jaw.wiki").export,

    -- History related
    historySet = require("jaw.history").set,
    historyMove = require("jaw.history").move,
    historyClear = require("jaw.history").clear,

    -- Link related
    linkInsert = require("jaw.link").instert,
    linkFollow = require("jaw.link").follow,

    -- Goto related
    gotoPage = require("jaw.goto").page,
    gotoHeading = require("jaw.goto").heading,
    gotoLink = require("jaw.goto").link,
    gotoTag = require("jaw.goto").tag,

    -- Tag related
    tagInsert = require("jaw.tag").insert,

    -- Todo related
    todoInsert = require("jaw.todo").insert, -- done
    todoToggle = require("jaw.todo").toggle, -- done

    -- Select related
    selectHistory = require("jaw.select").history,
    selectLink = require("jaw.select").link,
    selectTag = require("jaw.select").tag,
}

return M
