# mode-manager.nvim

A simple mode manager for Neovim that disables specified plugins for different modes using `lazy.nvim`.

This plugin is designed to be non-intrusive and works seamlessly with modern `lazy.nvim` features like `import`.

## Concept

This plugin allows you to define different "modes" (e.g., `Learn`, `Focus`, `Coding`). When you switch to a mode, a list of plugins you've configured for that mode will be disabled the next time you start Neovim.

It works by listening to `lazy.nvim`'s `LazySpecPost` event, which fires after all plugin specifications have been loaded (including from `import` directives) but before they are processed. This allows `mode-manager` to dynamically set `enabled = false` on the correct plugins without interfering with your configuration structure.

**Important:** You must restart Neovim after switching modes for the changes to take effect. The plugin will notify you when you switch modes.

## Installation

Use your favorite plugin manager, like `lazy.nvim`.

## Configuration

Configuration is now extremely simple. Just add `mode-manager.nvim` like any other plugin and pass your configuration to the `opts` table. You **do not** need to wrap your plugin list or change your configuration structure.

Simply add this block to your plugins list (e.g., as a new file in `lua/plugins/mode-manager.lua`):

```lua
-- lua/plugins/mode-manager.lua

return {
    "gilang-arya/mode-manager.nvim",
    opts = {
        modes = {
            -- Define your modes and the plugins to disable
            -- Example: A "Focus" mode for writing, disabling completion and Telescope
            Focus = {
                "hrsh7th/nvim-cmp",
                "nvim-telescope/telescope.nvim",
                "neovim/nvim-lspconfig",
            },

            -- Example: A "Learn" mode for learning new things
            Learn = {
                "nvim-treesitter/nvim-treesitter-textobjects",
                "folke/trouble.nvim",
            },
        },
    },
}
```

That's it. `lazy.nvim` will automatically call the `setup` function with your options.

## Usage

The plugin automatically creates commands based on the modes you define in the `opts` table.

From the configuration example above, the following commands would be created:

- `:ModeFocus` - Switches to the 'Focus' mode.
- `:ModeLearn` - Switches to the 'Learn' mode.
- `:ModeNormal` - Switches back to the default mode where all plugins are enabled.

After running any of these commands, restart Neovim to apply the changes.