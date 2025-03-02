-- Pull in the wezterm API
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config = {
    color_scheme = 'Tokyo Night',
    -- color_scheme = 'Monokai Remastered',
-- color_scheme = 'Monokai (base16)',
-- color_scheme = 'Catppuccin Mocha',
    -- color_scheme = 'Tomorrow Night Bright',
    -- color_scheme = 'Rosé Pine (Gogh)',

    window_background_opacity = 0.96,

    -- Spawn a fish shell in login mode (mac only, TODO change)
    default_prog = { '/opt/homebrew/bin/fish', '-l' },
    launch_menu = {
      {
        label = 'fish',
        args = { '/opt/homebrew/bin/fish', '-l' },
      },
      {
        label = 'bash',
        args = { '/bin/bash', '-l' },
      }
    },

    use_fancy_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    show_new_tab_button_in_tab_bar = true,
    window_close_confirmation = 'NeverPrompt',
    window_decorations = 'RESIZE',
    window_frame = {
        font_size = 17
    },

    -- Tab/window settings
    front_end = "WebGpu",
    font_size = 15.5,
    max_fps = 120,


    window_padding = { top = '5px', bottom = '0px' },
}

-- Cmd + , to open config in neovim
-- (hardcoded in editor because lol...)
config.keys = {
  {
    label = 'Open Wezterm config',
    key = ',',
    mods = 'CMD',
    action = wezterm.action.SpawnCommandInNewTab {
      cwd = wezterm.home_dir,
      args = { '/opt/homebrew/bin/nvim', wezterm.config_file },
    },
  },
-- CMD+SHIFT+R to rename tab
  {
    key = 'R',
    mods = 'CMD|SHIFT',
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, _, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  -- other keys
	-- TODO - CMD+P and then key tables to do pane stuff
	-- Make Page up/down work
	{ key = 'PageUp', action = wezterm.action.ScrollByPage(-1) },
	{ key = 'PageDown', action = wezterm.action.ScrollByPage(1) },

	{
		-- Split pane vertically
		key = 's',
		mods = 'CMD',
		action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
	},
	{
		key = 'w',
		mods = 'CMD',
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = 'h',
		mods = 'CMD',
		action = wezterm.action.ActivatePaneDirection('Left'),
	},
	{
		key = 'l',
		mods = 'CMD',
		action = wezterm.action.ActivatePaneDirection('Right'),
	},
	{
		key = 'j',
		mods = 'CMD',
		action = wezterm.action.ActivatePaneDirection('Down'),
	},
	{
		key = 'k',
		mods = 'CMD',
		action = wezterm.action.ActivatePaneDirection('Up'),
	},
	{
		-- Move pane to new tab
		key = 'N',
		mods = 'CMD',
		action = wezterm.action_callback(function(win, pane)
			local tab, win = pane:move_to_new_tab()
		end),
	},
	{
		key = 'Tab',
		mods = 'CTRL',
		action = wezterm.action.ActivateLastTab,
	},

	-- Jump word to the left
	{
		key = 'LeftArrow',
		mods = 'OPT',
		action = wezterm.action.SendKey({
		key = 'b',
		mods = 'ALT',
		}),
	},
	-- Jump word to the right
	{
		key = 'RightArrow',
		mods = 'OPT',
		action = wezterm.action.SendKey({ key = 'f', mods = 'ALT' }),
	},
	-- Go to beginning of line
	{
		key = 'LeftArrow',
		mods = 'CMD',
		action = wezterm.action.SendKey({
		key = 'a',
		mods = 'CTRL',
		}),
	},
	-- Go to end of line
	{
		key = 'RightArrow',
		mods = 'CMD',
		action = wezterm.action.SendKey({ key = 'e', mods = 'CTRL' }),
	},
	-- Case-insensitive search
	{
		key = 'f',
		mods = 'CMD',
		action = wezterm.action.Search({ CaseInSensitiveString = '' }),
	},
	-- Disable some default hotkeys
	{
		key = 'Enter',
		mods = 'OPT',
		action = wezterm.action.DisableDefaultAssignment,
	},
	-- Rename tab title
	{
		key = 'R',
		mods = 'CMD|SHIFT',
		action = wezterm.action.PromptInputLine {
			description = 'Enter new name for tab',
			action = wezterm.action_callback(function(window, _, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		},
	},
}

-- Mouse
config.mouse_bindings = {
  -- Change the default click behavior so that it only selects
  -- text and doesn't open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelection('ClipboardAndPrimarySelection'),
  },

  -- Open links on Cmd+click
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CMD',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}

-- Maximise on startup (TODO: add aerospace check)

-- local mux = wezterm.mux
-- wezterm.on('gui-startup', function(cmd)
--   local _, _, window = mux.spawn_window(cmd or {})
--   window:gui_window():maximize()
-- end)


-- Add powerbar
-- wezterm.on('update-status', function(window)
--   -- Grab the current window's configuration, and from it the
--   -- palette (this is the combination of your chosen colour scheme
--   -- including any overrides).
--   local color_scheme = window:effective_config().resolved_palette
--   local bg = color_scheme.background
--   local fg = color_scheme.foreground
--
--   window:set_right_status(wezterm.format({
--     { Background = { Color = bg } },
--     { Foreground = { Color = fg } },
--     { Text = ' ' .. wezterm.hostname() .. ' ' },
--   }))
-- end)





return config
