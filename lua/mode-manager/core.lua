-- lua/mode-manager/core.lua

local M = {}

M.config = {}

--- Filters plugins based on the current mode
function M.filter_plugins(get_current_mode)
    local current_mode = get_current_mode()
    if current_mode == "Normal" or not M.config.modes or not M.config.modes[current_mode] then
        return
    end

    local disabled_plugins = M.config.modes[current_mode]
    if not disabled_plugins then return end

    local lazy_config = require("lazy.core.config")
    for _, plugin in ipairs(lazy_config.plugins) do
        local plugin_name = plugin[1] or plugin.name
        for _, disabled_name in ipairs(disabled_plugins) do
            if plugin_name == disabled_name then
                plugin.enabled = false
                vim.notify("Disabled plugin: " .. plugin_name .. " (mode: " .. current_mode .. ")", vim.log.levels.INFO)
            end
        end
    end
end

return M