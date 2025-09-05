-- lua/mode-manager/data.lua

local M = {}

M.data_path = vim.fn.stdpath("data") .. "/mode_manager.mode"

--- Reads the active mode from the data file
function M.get_current_mode()
    local file = io.open(M.data_path, "r")
    if file then
        local mode = file:read("*a")
        file:close()
        if mode and mode ~= "" then
            return mode
        end
    end
    return "Normal"
end

--- Saves the new mode to the data file
function M.switch_mode(mode)
    local file = io.open(M.data_path, "w")
    if file then
        file:write(mode)
        file:close()
        vim.notify("Mode set to: " .. mode .. ". Restart Neovim to apply changes.", vim.log.levels.INFO)
    end
end

return M
