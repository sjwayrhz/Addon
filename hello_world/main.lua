local hello_world = {
    name = "Hello World",
    version = "0.1",
    author = "Aac",
    desc = "Learning Lua Script"
  }

local buffIdsToAlert = {
    [2923] = true,
    [2924] = true,
    [7656] = true,
    [13771] = true,
    [13772] = true
}

local function OnUpdate()
  local targetBuffCount = api.GetUnitBuffCount("target")
  -- If we do not have a target, we end early.
  if targetBuffCount == nil then
    return
  end

  for i = 1, targetBuffCount, 1 do
    local buff = api.GetUnitBuff("target", i)
    if buffIdsToAlert[buff.buff_id] == true then 
      api.Log:Info("Target has retribution!!")
    end    
  end
end

local function OnLoad()
  Canvas = api.Interface:CreateEmptyWindow("BuffAlerterCanvas")
  Canvas:Show(true)
  -- Anchors are a way to place things on screen. What we do here is anchor our Canvas to the CENTER of UIParent (the screen)
  Canvas:AddAnchor("CENTER", "UIParent", 0, 0)

  MyLabel = Canvas:CreateChildWidget("label", "label", 0, true)
  MyLabel:Show(true)
  MyLabel:SetText("Hello Addon!")
  -- Here, we anchor the label to the TOP LEFT of our CANVAS. We then give it an offset from the TOPLEFT (of 0,0) so that's it's centered.
  MyLabel:AddAnchor("TOPLEFT", Canvas, "TOPLEFT", 0, 0)

  api.On("UPDATE", OnUpdate)
end

local function OnUnload()
    if Canvas ~= nil then
      Canvas:Show(false)
      Canvas = nil
    end
  end



hello_world.OnLoad = OnLoad
hello_world.OnUnload = OnUnload

return hello_world