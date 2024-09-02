-- Addon Information
local fish_track = {
	name = "fish_track",
	author = "Aac",
	version = "0.0.1",
	desc = "track the fish"
}

-- Buff IDs and corresponding alert messages (removed the alert canvas)
local fishBuffIdsToAlert = {
    [5264] = "Stand Firm Right",
    [5265] = "Stand Firm Left",
    [5266] = "Reel In",
    [5267] = "Give Slack",
    [5508] = "Big Reel In"
}

local fishNamesToAlert = {
    ["Marlin"] = true, ["Blue Marlin"] = true, ["Tuna"] = true, ["Blue Tuna"] = true, ["Sunfish"] = true,
    ["Sailfish"] = true, ["Sturgeon"] = true, ["Pink Pufferfish"] = true,
    ["Carp"] = true, ["Arowana"] = true, ["Pufferfish"] = true, ["Eel"] = true,
    ["Pink Marlin"] = true, ["Treasure Mimic"] = true,
    ["Diamond Shores Draugorc"] = true	
}

-- UI Elements
local fishTrackerCanvas, targetFishIcon, fishBuffTargetTimeLeftLabel

-- Variables
local previousBuffTimeRemaining = 0
local previousXYZ = "0,0,0"
local previousFish
local settings

-- Update event to handle buff updates
local function OnUpdate()
    local currentFish = api.Unit:GetUnitId("target")
    local currentFishName
    if (currentFish ~= nil) then
        currentFishName = api.Unit:GetUnitInfoById(currentFish).name
    end

    -- Calculate when to move the anchor for the fish tracker
    local x, y, z = api.Unit:GetUnitScreenPosition("target")

    -- If you switch targets default to showing nothing until logic runs
    if (currentFish ~= previousFish) then
        fishTrackerCanvas:Show(false)
    end

    if (currentFish == nil) then
        fishTrackerCanvas:Show(false)
    end

    -- Check fish health
    local fishHealth = api.Unit:UnitHealth("target")
    if (fishHealth ~= nil and fishHealth <= 0) then
        if (settings.ShowTimers == true) then
            fishBuffTargetTimeLeftLabel:SetText("Dead")
        end
        F_SLOT.SetIconBackGround(targetFishIcon, api.Ability:GetBuffTooltip(156, 1).path)  -- Set to skull icon for dead fish
        fishTrackerCanvas:Show(true)  -- Show fish tracker
    end

    if (previousXYZ ~= (x .. "," .. y .. "," .. z)) then
        fishTrackerCanvas:AddAnchor("BOTTOM", "UIParent", "TOPLEFT", x - 20, y - 80)
    end

    -- Buff logic (removed fishBuffAlertCanvas handling)
    local buffCount = api.Unit:UnitBuffCount("target")
    if buffCount == nil or buffCount == 0 then
        return
    end

    local selectedBuff = api.Unit:UnitBuff("target", 2) or api.Unit:UnitBuff("target", 3) or api.Unit:UnitBuff("target", 1)

    -- Handle the buffs as needed...
    -- (Retain logic for buffs, if necessary)

    previousFish = currentFish
end

-- Load function to initialize the UI elements
local function OnLoad()
    api.Log:Info("Loading " .. fish_track.name .. " by " .. fish_track.author)

    settings = api.GetSettings(fish_track.name)
    local needsFirstSave = false
    if (settings.ShowBuffsOnTarget == nil) then
        settings.ShowBuffsOnTarget = false
        needsFirstSave = true
    end

    if (settings.ShowWait == nil) then
        settings.ShowWait = true
        needsFirstSave = true
    end
    
    if (settings.ShowTimers == nil) then
        settings.ShowTimers = true
        needsFirstSave = true
    end
    
    if (needsFirstSave == true) then
        api.SaveSettings()
    end

    fishTrackerCanvas = api.Interface:CreateEmptyWindow("fishTarget")
    fishTrackerCanvas:Show(false)

    targetFishIcon = CreateItemIconButton("targetFishIcon", fishTrackerCanvas)
    targetFishIcon:AddAnchor("TOPLEFT", fishTrackerCanvas, "TOPLEFT", 0, 0)
    targetFishIcon:Show(true)
    
    if (settings.ShowTimers == true) then
        fishBuffTargetTimeLeftLabel = fishTrackerCanvas:CreateChildWidget("label", "fishBuffTargetTimeLeftLabel", 0, true)
        if (settings.ShowBuffsOnTarget == true) then
            fishBuffTargetTimeLeftLabel:SetText("0.0s")
        end
        fishBuffTargetTimeLeftLabel:AddAnchor("CENTER", targetFishIcon, "CENTER", 0, 0)
        fishBuffTargetTimeLeftLabel.style:SetFontSize(18)
        fishBuffTargetTimeLeftLabel.style:SetAlign(ALIGN_LEFT)
        fishBuffTargetTimeLeftLabel.style:SetShadow(true)
    end
    
    api.On("UPDATE", OnUpdate)
end

-- Unload function to clean up
local function OnUnload()
    if fishTrackerCanvas ~= nil then
        fishTrackerCanvas:Show(false)
        fishTrackerCanvas = nil
    end
end

fish_track.OnLoad = OnLoad
fish_track.OnUnload = OnUnload

return fish_track