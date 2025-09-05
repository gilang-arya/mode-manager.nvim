-- lua/mode-manager/commands.lua

local M = {}

--- Create user commands for switching modes
function M.create_commands(config, switch_mode)
    if not config.modes then return end

    vim.api.nvim_create_user_command("ModeNormal", function()
        switch_mode("Normal")
    end, {})

    for mode_name, _ in pairs(config.modes) do
        vim.api.nvim_create_user_command("Mode" .. mode_name, function()
            switch_mode(mode_name)
        end, {})
    end
end

return M
