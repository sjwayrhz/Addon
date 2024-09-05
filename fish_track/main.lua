-- Addon Information
local fish_track = {
	name = "fish_track",
	author = "Aac",
	version = "0.0.2",
	desc = "Track Buff For Fishing"
}

-- Buff IDs and corresponding alert messages
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
	
	-- Calculate target fish position
	local x, y, z = api.Unit:GetUnitScreenPosition("target")

	-- Hide UI when switching targets
	if (currentFish ~= previousFish) then
		fishTrackerCanvas:Show(false)
		fishBuffAlertCanvas:Show(false)
	end
	
	if (currentFish == nil) then
		fishTrackerCanvas:Show(false)
		fishBuffAlertCanvas:Show(false)
	end
	
	-- Check fish health
	local fishHealth = api.Unit:UnitHealth("target")
	if (fishHealth ~= nil and fishHealth <= 0) then
		fishBuffAlertCanvas:Show(false)
		if z < 0 or z > 100 then
			fishTrackerCanvas:Show(false)
		else
			if (fishNamesToAlert[currentFishName] ~= nil) then
				fishTrackerCanvas:Show(true)
			end
		end
		-- Keep the original line for dead fish icon
		F_SLOT.SetIconBackGround(targetFishIcon, api.Ability:GetBuffTooltip(5492, 1).path)
	end

	if (previousXYZ ~= (x .. "," .. y .. "," .. z)) then
		fishTrackerCanvas:AddAnchor("BOTTOM", "UIParent", "TOPLEFT", x - 20, y - 80)
	end
	
	-- Check Buff count
	local buffCount = api.Unit:UnitBuffCount("target")
	if buffCount == nil or buffCount == 0 then
		fishBuffAlertCanvas:Show(false)
		return  -- Return if no Buff
	end
	
	-- Try to get Buff
	local selectedBuff = api.Unit:UnitBuff("target", 2)
	if (selectedBuff == nil) then
		selectedBuff = api.Unit:UnitBuff("target", 3)
		if (selectedBuff == nil) then
			selectedBuff = api.Unit:UnitBuff("target", 1)
		end
	end
	
	-- Process Buff
	if (selectedBuff and fishBuffIdsToAlert[selectedBuff.buff_id] ~= nil) then
		previousFish = currentFish
		if (previousBuffTimeRemaining ~= selectedBuff.timeLeft) then
			previousBuffTimeRemaining = selectedBuff.timeLeft
		end

		-- Update icon
		if (settings.ShowBuffsOnTarget == true) then
			F_SLOT.SetIconBackGround(targetFishIcon, selectedBuff.path)
		else
			-- Use the fishBuffIdsToAlert icon
			F_SLOT.SetIconBackGround(targetFishIcon, api.Ability:GetBuffTooltip(selectedBuff.buff_id, 1).path)
		end
		F_SLOT.SetIconBackGround(fishBuffAlertIcon, selectedBuff.path)

		-- Hide center alert
		fishBuffAlertCanvas:Show(false)  -- Hide center alert

		-- Ensure fish tracking frame is shown
		if (fishNamesToAlert[currentFishName] ~= nil) then
			fishTrackerCanvas:Show(true)
		end
	else 
		-- If no Buff, hide alert
		fishBuffAlertCanvas:Show(false)
	end
end

-- Load function to initialize the UI elements
local function OnLoad()
	api.Log:Info("The author needs political asylum")

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
	
	fishBuffAlertCanvas = api.Interface:CreateEmptyWindow("fishBuffAlertCanvas")
	fishBuffAlertCanvas:AddAnchor("CENTER", "UIParent", 0, -300)
	fishBuffAlertCanvas:Show(false)

	fishBuffAlertLabel = fishBuffAlertCanvas:CreateChildWidget("label", "fishBuffAlertLabel", 0, true)
	fishBuffAlertLabel:SetText("fish_track")
	fishBuffAlertLabel:AddAnchor("TOPLEFT", fishBuffAlertCanvas, "TOPLEFT", 0, 22)
	fishBuffAlertLabel.style:SetFontSize(44)
	fishBuffAlertLabel.style:SetAlign(ALIGN_LEFT)
	fishBuffAlertLabel.style:SetShadow(true)

	fishBuffAlertIcon = CreateItemIconButton("fishBuffAlertIcon", fishBuffAlertCanvas)
	fishBuffAlertIcon:Show(true)
	F_SLOT.ApplySlotSkin(fishBuffAlertIcon, fishBuffAlertIcon.back, SLOT_STYLE.DEFAULT)
	fishBuffAlertIcon:AddAnchor("TOPLEFT", fishBuffAlertCanvas, "TOPLEFT", -24, -60)

	fishBuffTimeLeftLabel = fishBuffAlertCanvas:CreateChildWidget("label", "fishBuffTimeLeftLabel", 0, true)

	if (settings.ShowTimers == true) then
		fishBuffTimeLeftLabel:SetText("0.0s")
		fishBuffTimeLeftLabel:AddAnchor("CENTER", fishBuffAlertIcon, "CENTER", 0, 0)
		fishBuffTimeLeftLabel.style:SetFontSize(18)
		fishBuffTimeLeftLabel.style:SetAlign(ALIGN_LEFT)
		fishBuffTimeLeftLabel.style:SetShadow(true)
	end

	fishTrackerCanvas = api.Interface:CreateEmptyWindow("fishTarget")
	fishTrackerCanvas:Show(false)
	
	targetFishIcon = CreateItemIconButton("targetFishIcon", fishTrackerCanvas)
	targetFishIcon:AddAnchor("TOPLEFT", fishTrackerCanvas, "TOPLEFT", 0, 0)
	targetFishIcon:Show(true)
	F_SLOT.ApplySlotSkin(targetFishIcon, targetFishIcon.back, SLOT_STYLE.DEFAULT)

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
	if fishBuffAlertCanvas ~= nil then
		fishBuffAlertCanvas:Show(false)
		fishBuffAlertCanvas = nil
	end
	if fishTrackerCanvas ~= nil then
		fishTrackerCanvas:Show(false)
		fishTrackerCanvas = nil
	end
end

fish_track.OnLoad = OnLoad
fish_track.OnUnload = OnUnload

return fish_track