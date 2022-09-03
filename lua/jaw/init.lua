local M = {
    -- Configuration related
    config = require("jaw.config").config,
    setup = require("jaw.config").setup,

    -- Wiki related
    new = require("jaw.wiki").new,
    use = require("jaw.wiki").use,
    add = require("jaw.wiki").add,
    export = require("jaw.wiki").export,

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
    todoInsert = require("jaw.todo").insert,
    todoToggle = require("jaw.todo").toggle,

    -- Select related
    selectHistory = require("jaw.select").history,
    selectLink = require("jaw.select").link,
    selectTag = require("jaw.select").tag,
}

return M
