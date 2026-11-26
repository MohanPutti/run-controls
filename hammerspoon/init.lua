require("hs.ipc")  -- lets the `hs` CLI talk to Hammerspoon (debugging, reload)
-- Hammerspoon: app and Chrome-profile hotkeys. Optional; installed with `install.sh --with-hammerspoon`.
-- Personal choices (keys, profiles) go in ~/.config/run-controls/hammerspoon.lua, not here.

local cfg = {
  mods = { "alt" },
  apps = {
    ["1"] = "iTerm",
    ["2"] = "Google Chrome",
    ["3"] = "Visual Studio Code",
    ["4"] = "Slack",
    ["5"] = "Claude",
    ["6"] = "Docker",
    ["7"] = "WhatsApp",
    ["8"] = "Pritunl",
  },
  -- Chrome profiles: key -> { name = "<name shown in the window title>", dir = "<profile folder>" }
  -- Folder is "Default", "Profile 1", ... (see chrome://version -> Profile Path)
  profiles = {},
  reload = "r",
  wmods = { "ctrl", "alt" },  -- window management
}

local ok, user = pcall(dofile, os.getenv("HOME") .. "/.config/run-controls/hammerspoon.lua")
if ok and type(user) == "table" then
  for k, v in pairs(user) do cfg[k] = v end
end

-- Focus the app, or launch it. Pressing again while it is frontmost hides it.
local function toggleApp(name)
  local front = hs.application.frontmostApplication()
  if front and front:name() == name then front:hide() return end
  hs.application.launchOrFocus(name)
end

-- Chrome puts the profile name at the end of each window title.
local function chromeProfile(p)
  local chrome = hs.application.get("Google Chrome")
  if chrome then
    for _, w in ipairs(chrome:allWindows()) do
      if w:title():find(p.name, 1, true) then w:focus() return end
    end
  end
  hs.execute(string.format('open -na "Google Chrome" --args --profile-directory="%s"', p.dir), true)
end

for key, app in pairs(cfg.apps) do
  hs.hotkey.bind(cfg.mods, key, function() toggleApp(app) end)
end
for key, p in pairs(cfg.profiles) do
  hs.hotkey.bind(cfg.mods, key, function() chromeProfile(p) end)
end
hs.hotkey.bind(cfg.mods, cfg.reload, hs.reload)

-- Window management: ctrl+alt + arrows (halves), return (maximize), c (center), n (next screen)
local function place(unit)
  return function()
    local w = hs.window.focusedWindow()
    if w then w:moveToUnit(unit) end
  end
end
hs.hotkey.bind(cfg.wmods, "left",   place({ 0,   0, 0.5, 1 }))
hs.hotkey.bind(cfg.wmods, "right",  place({ 0.5, 0, 0.5, 1 }))
hs.hotkey.bind(cfg.wmods, "up",     place({ 0,   0, 1,   0.5 }))
hs.hotkey.bind(cfg.wmods, "down",   place({ 0,   0.5, 1, 0.5 }))
hs.hotkey.bind(cfg.wmods, "return", place({ 0,   0, 1,   1 }))
hs.hotkey.bind(cfg.wmods, "c",      place({ 0.15, 0.1, 0.7, 0.8 }))
hs.hotkey.bind(cfg.wmods, "n", function()
  local w = hs.window.focusedWindow()
  if w then w:moveToScreen(w:screen():next(), true, true) end
end)
hs.alert.show("Hammerspoon loaded")
