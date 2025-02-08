hs.hotkey.bind({"cmd"}, ";", function()
  -- pass true for the second param to not pick up browser window titles
  -- and other oddities
  local term = hs.application.find("Alacritty", true)
  if not term then
    application.launchOrFocus("Alacritty")
  else
    if term:isFrontmost() then
      term:hide()
    else
      term:activate()
    end
  end
end)
