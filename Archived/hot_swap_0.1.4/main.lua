local api = require("api")
local DISPLAY = require("hot_swap/display")
local hot_swap = {
    name = "Hot Swap",
    version = "0.1.4",
    author = "MikeTheShadow",
    desc = "A plugin to hotswap gear and titles."
}

local Canvas

local function OnLoad()

    local settings = api.GetSettings("hot_swap")
    local gear_sets = require("hot_swap/loadouts")
    Canvas = DISPLAY.CreateDisplay(settings,gear_sets)
    
    local startX = 20
    local startY = 20
    local buttonSpacing = 30
    local offset = 0
    
    for i = 1, #gear_sets do
        local set = gear_sets[i]
        local last_button = DISPLAY.createButton(Canvas, set, startX, startY + offset,last_button,settings)
        offset = offset + 50
    end
    
    api.Log:Info("Hot Swap loaded successfully!")
end

hot_swap.OnLoad = OnLoad

local function OnUpdate()
    DISPLAY.Update()
end

local function OnUnload()
    if Canvas ~= nil then
        Canvas:Show(false)
        Canvas = nil
    end
end

hot_swap.OnUnload = OnUnload

api.On("UPDATE",OnUpdate)

return hot_swap
