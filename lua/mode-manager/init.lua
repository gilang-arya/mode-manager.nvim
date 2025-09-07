-- lua/mode-manager/init.lua

local M = {}

local core = require("mode-manager.core")
local data = require("mode-manager.data")
local commands = require("mode-manager.commands")

function M.setup(opts)
    core.config = opts or {} -- Set config on the core module

    -- Register the filter function to run on LazySpecPost
    vim.api.nvim_create_autocmd("User", {
        pattern = "LazySpecPost",
        callback = function()
            core.filter_plugins(data.get_current_mode)
        end,
    })

    -- Create user commands for switching modes
    commands.create_commands(core.config, data.switch_mode)
end

return M
