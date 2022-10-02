local M = {}

M.ENUMS = {
    ALWAYS = 1,
    PROMPT = 2,
    NEVER = 3,
    CHOICE_CHECK_PRO = 4,
    CHOICE_CHECK_CON = 5,
    CHOICE_CHECK_NONE = 6,
    TODO_STATE_CHECKED = 7,
    TODO_STATE_NON_CHECKED = 8,
}

M.config = {
    system = {
        ["wiki-new"] = {
            input = {
                prompt = "Path to new Wiki: ",
                default = vim.loop.cwd() .. "/",
            },
            output = {
                path_exists = "[jaw] Aborting.. Path already exists",
                no_input = "[jaw] Aborting.. no input given",
                error = function()
                    print "[jaw] Failed to create Wiki"
                end,
                stdout = function()
                    print "[jaw] Created Wiki successful"
                end,
            },
        },
        ["todo"] = {
            checked_symbol = "x",
            matching = {
                non_checked = "%p%s%p",
                checked = "%p%a%p"
            },
            template = "- [%s] %s",
        }
    },

    -- wikiNew related
    -- Options: always,prompt,never
    create_git_repo = M.ENUMS.ALWAYS,

    -- the Shell command to run the Template file
    shell = "sh",

    -- the Script which creates the base structure
    -- new_wiki_template = os.getenv("HOME") .. "/wiki_template.sh",
    new_wiki_template = "/home/julius/.gits/personal/nvim-plugs/jaw.nvim/wn/wiki-template.sh",

    -- Utils related
    choices = {
        ["wiki-new"] = {
            pro = {},
            con = {},
        },
    },
}

-- Configures Jaw
-- @param opts[table]: the personal configuration
M.setup = function(opts)
    vim.tbl_deep_extend("force", M.config, opts)
end

return M
