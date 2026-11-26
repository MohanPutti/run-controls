-- Copy to ~/.config/run-controls/hammerspoon.lua and edit. install.sh does this for you.
-- Anything returned here overrides the defaults in hammerspoon/init.lua.
return {
  mods = { "alt" },
  -- profiles use keys that do not clash with apps (1-8 by default)
  profiles = {
    -- ["9"] = { name = "Work",     dir = "Default"   },
    -- ["0"] = { name = "Personal", dir = "Profile 1" },
  },
  -- apps = { ["1"] = "iTerm", ["2"] = "Google Chrome" },  -- replace the app list entirely
}
