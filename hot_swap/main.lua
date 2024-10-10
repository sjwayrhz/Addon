local api = require("api")

-- Loadouts
local Dawnsdrop = {
    {name = "Radiant Dawnsdrop Cap"},
    {name = "Radiant Dawnsdrop Jerkin"},
    {name = "Radiant Dawnsdrop Belt"},
    {name = "Radiant Dawnsdrop Guards"},
    {name = "Radiant Dawnsdrop Fists"},
    {name = "Radiant Dawnsdrop Breeches"},
    {name = "Radiant Dawnsdrop Boots"}
}

local glider = {
    {name = "Enhanced Flamefeather Glider: Speed"},
    {name = "Enhanced Skywhisper Glider: Launch Height"},
    {name = "Enhanced Sloth Glider Companion: Launch Height"},    
}

local gear_sets = {
    {
        name = "弓箭手",
        title_id = 178,
        gear = {
            {name = "Hellforged Ranger's Cap"},  
            {name = "Hellforged Ranger's Jerkin"}, 
            {name = "Hellforged Ranger's Breeches"}, 
            {name = "Hellforged Ranger's Fists"},            
            {name = "Dark Warrior's Guards"},
            {name = "Reckless Glory Belt"},
            {name = "Hellforged Ranger's Boots"},
            {name = "Hellkissed Club"},
            {alternative = true, name = "Hellkissed Dagger"},
            {name = "Darukissed Flute"},
        }
    },  
    {
        name  = "Commerce",
        title_id = 618,
        gear = {
            {name = "Hellkissed Nodachi"},
            glider[1]
        }
    },
    {
        name = "Fishing",
        title_id = 87,
        gear = {
            {name = "Ultimate Fishing Rod"},
            glider[2]
        }
    },
    {
        name = "Dawnsdrop",
        gear = {
            Dawnsdrop[1], Dawnsdrop[2], Dawnsdrop[3],
            Dawnsdrop[4], Dawnsdrop[5], Dawnsdrop[6],
            Dawnsdrop[7],
        }
    },
    {
        name = "Soulforged",
        gear = {
            {name = "Soulforged Gauntlets"},            
            {name = "Soulforged Greaves"},
            {name = "Soulforged Cuirass"},
            {name = "Soulforged Sabatons"},
            {name = "Soulforged Fists"},
            {name = "Soulforged Cap"},
            {name = "Soulforged Breeches"},
            {name = "Soulforged Jerkin"},
            {name = "Soulforged Boots"},
            {name = "Hellkissed Katana"},
            {alternative = true, name = "Hellkissed Sword"},
            glider[2],
            {name = "Fortune Pipe"},
        }
    },
    {
        name = "Sleep",
        title_id = 191,
        gear = {
            Dawnsdrop[1],
            {name = "Lullaby Pajama Top"},
            {name = "Lullaby Pajama Bottoms"},
            {name = "Lullaby Pajama Slippers"},
            {name = "Lullaby Pajama Mittens"},
            glider[1],
            {name = "Fortune Pipe"},
        }
    }
}
-- DISPLAY module
local DISPLAY = {}

local buttons = {}
local gear_to_process = {}

local function SwitchTitle(title_id)
    api.Player:ChangeAppellation(title_id)
end

local function EquipItemFromSlot(slot, equip_alternate_slot)
    api.Bag:EquipBagItem(slot, equip_alternate_slot)
end

function DISPLAY.CreateDisplay(settings, gear_sets)
    local canvas_x = settings.x or 500
    local canvas_y = settings.y or 20
    
    local Canvas = api.Interface:CreateEmptyWindow("hotSwapWindow", "UIParent")
    Canvas.bg = Canvas:CreateNinePartDrawable(TEXTURE_PATH.HUD, "background")
    Canvas.bg:SetTextureInfo("bg_quest")
    Canvas.bg:SetColor(0, 0, 0, 0.5)
    Canvas.bg:AddAnchor("TOPLEFT", Canvas, 0, 0)
    Canvas.bg:AddAnchor("BOTTOMRIGHT", Canvas, 0, 0)
    
    if canvas_x ~= 500 and canvas_y ~= 20 then
        Canvas:AddAnchor("TOPLEFT", "UIParent", canvas_x, canvas_y)
    else
        Canvas:AddAnchor("LEFT", "UIParent", canvas_x, canvas_y)
    end
    
    if settings.hidden then
        Canvas:SetExtent(200, 35)
    else
        Canvas:SetExtent(200, 35 + (#gear_sets * 50))
    end
    Canvas:Show(true)

    function Canvas:OnDragStart(arg)
        if arg == "LeftButton" and api.Input:IsShiftKeyDown() then
          Canvas:StartMoving()
          api.Cursor:ClearCursor()
          api.Cursor:SetCursorImage(CURSOR_PATH.MOVE, 0, 0)
        end
    end
    Canvas:SetHandler("OnDragStart", Canvas.OnDragStart)
    
    function Canvas:OnDragStop()
        current_x, current_y = Canvas:GetOffset()
        settings.x = current_x
        settings.y = current_y
        api.SaveSettings()
        Canvas:StopMovingOrSizing()
        api.Cursor:ClearCursor()
    end
    Canvas:SetHandler("OnDragStop", Canvas.OnDragStop)
    Canvas:RegisterForDrag("LeftButton")
    
    local closeBtn = Canvas:CreateChildWidget("button", "hotSwap.closeBtn", 0, true)
    closeBtn:Show(true)
    closeBtn:AddAnchor("TOPRIGHT", Canvas, -10, 5)
    api.Interface:ApplyButtonSkin(closeBtn, BUTTON_BASIC.MINUS)
    
    local showBtn = Canvas:CreateChildWidget("button", "hotSwap.openBtn", 0, true)
    showBtn:Show(false)
    showBtn:AddAnchor("TOPRIGHT", Canvas, -10, 5)
    api.Interface:ApplyButtonSkin(showBtn, BUTTON_BASIC.PLUS)
    
    if settings.hidden then
       showBtn:Show(true)
       closeBtn:Show(false)
    else
        showBtn:Show(false)
        closeBtn:Show(true)
    end
    
    closeBtn:SetHandler("OnClick", function()
        closeBtn:Show(false)
        showBtn:Show(true)
        for button_num = 1, #buttons do
            buttons[button_num]:Show(false)
        end
        Canvas:SetExtent(200, 35)
        settings.hidden = true
        api.SaveSettings()
    end)
    
    showBtn:SetHandler("OnClick", function()
        closeBtn:Show(true)
        showBtn:Show(false)
        for button_num = 1, #buttons do
            buttons[button_num]:Show(true)
        end
        Canvas:SetExtent(200, 35 + (#buttons * 50))
        settings.hidden = false
        api.SaveSettings()
    end)
    
    return Canvas
end

function DISPLAY.createButton(Canvas, set, x, y, last_button, settings)
    local button = Canvas:CreateChildWidget("button", set.name .. "_button", 0, true)
    
    table.insert(buttons, button)
    
    button:Show(true)
    button:AddAnchor("TOPLEFT", Canvas, x, y)
    button:SetText(set.name)
    
    api.Interface:ApplyButtonSkin(button, BUTTON_BASIC.DEFAULT)
    
    local button_width = button:GetWidth()
    local canvas_width = Canvas:GetWidth()
    local canvas_height = Canvas:GetHeight()
    
    if button_width > canvas_width - 50 then
        Canvas:SetExtent(button_width + 50, canvas_height)
    end
    
    if settings.hidden then
        button:Show(false)
    end
    
    button:SetHandler("OnClick", function()
        if set.title_id ~= nil then
            SwitchTitle(set.title_id) 
        end

        local ignored_numbers = {}

        for slot_num = 1, 150 do
            local item = api.Bag:GetBagItemInfo(1, slot_num)
            if item ~= nil then
                for gear_pos = 1, #set.gear do
                    local do_skip = false

                    for ignored_num = 1, #ignored_numbers do
                        if gear_pos == ignored_numbers[ignored_num] then
                            do_skip = true
                            break
                        end
                    end

                    if not do_skip then
                        local gear_item = set.gear[gear_pos]
                        if item.name == gear_item.name then
                            table.insert(gear_to_process, {
                                gear_item = gear_item,
                                pos = slot_num
                            })
                        end
                    end
                end
            end
        end
    end)

    return button
end

local delay = 0

function DISPLAY.Update()
    if #gear_to_process > 0 then
        if delay == 25 then
            local item_to_equip = table.remove(gear_to_process, 1)
            if #gear_to_process == 0 then
                for i = 1, #buttons do
                    buttons[i]:Enable(true)
                end
            end
            
            local gearItem = item_to_equip.gear_item
            EquipItemFromSlot(item_to_equip.pos, gearItem.alternative or false)
            delay = 0
        end
    end
    
    if delay < 25 then
        delay = delay + 1
    end
end

function DISPLAY.Destroy()
    for i = 1, #buttons do
        buttons[i]:Show(false)
    end
end


-- Main script
local hot_swap = {
    name = "Hot Swap",
    version = "0.1.4",
    author = "MikeTheShadow",
    desc = "A plugin to hotswap gear and titles."
}

local Canvas

local function OnLoad()
    local settings = api.GetSettings("hot_swap")
    Canvas = DISPLAY.CreateDisplay(settings, gear_sets)
    
    local startX = 20
    local startY = 20
    local buttonSpacing = 30
    local offset = 0
    
    for i = 1, #gear_sets do
        local set = gear_sets[i]
        local last_button = DISPLAY.createButton(Canvas, set, startX, startY + offset, last_button, settings)
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

api.On("UPDATE", OnUpdate)

return hot_swap