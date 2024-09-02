-- Addon Information
local fish_track = {
	name = "fish_track",
	author = "Aac",
	version = "0.0.1",
	desc = "track the fish"
}


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
	["Pink Marlin"] = true, ["Treasure Mimic"] = true
}

-- UI Elements
local fishTrackerCanvas, fishBuffAlertCanvas, fishBuffAlertLabel, fishBuffAlertIcon, fishBuffTimeLeftLabel, targetFishIcon, fishBuffTargetTimeLeftLabel

-- Variables
local previousBuffTimeRemaining = 0
local previousXYZ = "0,0,0"
local previousFish
local settings

local function OnUpdate()
	local currentFish = api.Unit:GetUnitId("target")
	local currentFishName
	if (currentFish ~= nil) then
		currentFishName = api.Unit:GetUnitInfoById(currentFish).name
	end
	
	local x, y, z = api.Unit:GetUnitScreenPosition("target")

	if (currentFish ~= previousFish) then
		fishTrackerCanvas:Show(false)
	end
	
	if (currentFish == nil) then
		fishTrackerCanvas:Show(false)
	end
	
	local fishHealth = api.Unit:UnitHealth("target")
	if (fishHealth ~= nil and fishHealth <= 0) then
		fishTrackerCanvas:Show(false)
		if z >= 0 and z <= 100 and fishNamesToAlert[currentFishName] then
			fishTrackerCanvas:Show(true)
		end
		F_SLOT.SetIconBackGround(targetFishIcon, api.Ability:GetBuffTooltip(156, 1).path)
	end

	if (previousXYZ ~= (x .. "," .. y .. "," .. z)) then
		fishTrackerCanvas:AddAnchor("BOTTOM", "UIParent", "TOPLEFT", x - 20, y - 80)
	end
	
	local buffCount = api.Unit:UnitBuffCount("target")
	if buffCount == nil or buffCount == 0 then
		fishTrackerCanvas:Show(false)
	end
	
	local selectedBuff = api.Unit:UnitBuff("target", 2) or api.Unit:UnitBuff("target", 3) or api.Unit:UnitBuff("target", 1)

	if (fishBuffIdsToAlert[selectedBuff.buff_id] ~= nil) then
		previousFish = currentFish
		if (previousBuffTimeRemaining ~= selectedBuff.timeLeft) then
			previousBuffTimeRemaining = selectedBuff.timeLeft
		end
		
		F_SLOT.SetIconBackGround(targetFishIcon, selectedBuff.path)
		
		if (selectedBuff.timeLeft > 0) then
			if (fishNamesToAlert[currentFishName] ~= nil) then
				fishTrackerCanvas:Show(true)
			end
		else
			-- Handle waiting state
			F_SLOT.SetIconBackGround(targetFishIcon, api.Ability:GetBuffTooltip(6064, 1).path)
		end
	else 
		-- No buff we care about shown
		F_SLOT.SetIconBackGround(targetFishIcon, api.Ability:GetBuffTooltip(6064, 1).path)
	end
end

-- Load function to initialize the UI elements
local function OnLoad()
	api.Log:Info(fish_track.name .. " loaded successfully ")

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
