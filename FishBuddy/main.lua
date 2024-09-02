local api = require("api")

-- Addon Information
local fishBuddyAddon = {
	name = "FishBuddy",
	author = "Kg",
	version = "0.6.1",
	desc = "QoL improvements for fishing."
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
	["Pink Marlin"] = true, ["Treasure Mimic"] = true,
	["Diamond Shores Draugorc"] = true	
}

-- UI Elements
local fishTrackerCanvas, fishBuffAlertCanvas, fishBuffAlertLabel, fishBuffAlertIcon, fishBuffTimeLeftLabel, targetFishIcon, fishBuffTargetTimeLeftLabel

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
	
	
	--Calculate when to move the anchor for the fish tracker
	local x, y, z = api.Unit:GetUnitScreenPosition("target")

	--If you switch targets default to showing nothing until logic runs
	if (currentFish ~= previousFish) then
		fishTrackerCanvas:Show(false)
		fishBuffAlertCanvas:Show(false)
	end
	
	if (currentFish == nil) then
		fishTrackerCanvas:Show(false)
		fishBuffAlertCanvas:Show(false)
	end
	
	--If we have a valid fish health and it is 0 or less then stop showing the fish buff canvas
	-- set the fish tracker icon to a skull for dead
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
		F_SLOT.SetIconBackGround(targetFishIcon, api.Ability:GetBuffTooltip(156, 1).path)
		if (settings.ShowTimers == true) then
			fishBuffTargetTimeLeftLabel:SetText("Dead")
		end
	end

	if (previousXYZ ~= (x .. "," .. y .. "," .. z)) then
		fishTrackerCanvas:AddAnchor("BOTTOM", "UIParent", "TOPLEFT", x - 20, y - 80)
	end
	
	--If we have no buffs or it is nil hide the canvas
	local buffCount = api.Unit:UnitBuffCount("target")
	if buffCount == nil or buffCount == 0 then
		fishBuffAlertCanvas:Show(false)
	end
	
	--Try to get buff 2 (normal), buff 3 (you're mass fishing), or buff 1 (you bugged the fish)
	local selectedBuff = api.Unit:UnitBuff("target", 2)
	if (selectedBuff == nil) then
		selectedBuff = api.Unit:UnitBuff("target", 3)
		if (selectedBuff == nil) then
			selectedBuff = api.Unit:UnitBuff("target", 1)
		end
	end
	
	--If we have a buff we care about
	if (fishBuffIdsToAlert[selectedBuff.buff_id] ~= nil) then
		previousFish = currentFish
		--Only update the buff time when it is changed
		if (previousBuffTimeRemaining ~= selectedBuff.timeLeft) then
			previousBuffTimeRemaining = selectedBuff.timeLeft
		end
		
		--Setup icons and labels with buff info
		if (settings.ShowBuffsOnTarget == true) then
			F_SLOT.SetIconBackGround(targetFishIcon, selectedBuff.path)
		else
			F_SLOT.SetIconBackGround(targetFishIcon, api.Ability:GetBuffTooltip(26, 1).path)
		end
		F_SLOT.SetIconBackGround(fishBuffAlertIcon, selectedBuff.path)
		fishBuffAlertLabel:SetText(fishBuffIdsToAlert[selectedBuff.buff_id])
		if (settings.ShowTimers == true) then
			fishBuffTimeLeftLabel:SetText(string.format("%.1f", (previousBuffTimeRemaining / 1000)) .. "s")
			if (settings.ShowBuffsOnTarget == true) then
				fishBuffTargetTimeLeftLabel:SetText(string.format("%.1f", (previousBuffTimeRemaining / 1000)) .. "s")
			else
				fishBuffTargetTimeLeftLabel:SetText("")
			end
		end

		--Handle if time is left on a buff or not
		if (selectedBuff.timeLeft > 0) then
			if (fishNamesToAlert[currentFishName] ~= nil) then
				fishBuffAlertCanvas:Show(true)
			end
			if z < 0 or z > 100 then
				fishTrackerCanvas:Show(false)
			else
				if (fishNamesToAlert[currentFishName] ~= nil) then
					fishTrackerCanvas:Show(true)
				end
			end
		else
			--Should never get here unless you are lagging
			if (settings.ShowWait == true) then
				F_SLOT.SetIconBackGround(fishBuffAlertIcon, api.Ability:GetBuffTooltip(6064, 1).path)
				if (settings.ShowTimers == true) then
					fishBuffTimeLeftLabel:SetText("WAIT")
				end
				if (settings.ShowBuffsOnTarget == true) then
					F_SLOT.SetIconBackGround(targetFishIcon, api.Ability:GetBuffTooltip(6064, 1).path)
					if (settings.ShowTimers == true) then
						fishBuffTargetTimeLeftLabel:SetText("WAIT")
					end
				end
				fishBuffAlertLabel:SetText("WAIT")
			end
		end
	else 
		--No buff we care about shown
		if (settings.ShowWait == true) then
			F_SLOT.SetIconBackGround(fishBuffAlertIcon, api.Ability:GetBuffTooltip(6064, 1).path)
			if (settings.ShowTimers == true) then
				fishBuffTimeLeftLabel:SetText("WAIT")
			end
			if (settings.ShowBuffsOnTarget == true) then
				F_SLOT.SetIconBackGround(targetFishIcon, api.Ability:GetBuffTooltip(6064, 1).path)
				if (settings.ShowTimers == true) then
					fishBuffTargetTimeLeftLabel:SetText("WAIT")
				end
			end
			fishBuffAlertLabel:SetText("WAIT")
		end
	end
end

-- Load function to initialize the UI elements
local function OnLoad()
	api.Log:Info("Loading " .. fishBuddyAddon.name .. " by " .. fishBuddyAddon.author)

	settings = api.GetSettings(fishBuddyAddon.name)
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
	fishBuffAlertLabel:SetText("FishBuddy")
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

fishBuddyAddon.OnLoad = OnLoad
fishBuddyAddon.OnUnload = OnUnload

return fishBuddyAddon
