local api = require("api")

-- Addon Information
local fish_track = {
	name = "fish_track",
	author = "aac",
	version = "0.0.1",
	desc = "test"
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

-- Update event to handle buff updates
local function OnUpdate()
	local currentFish = api.Unit:GetUnitId("target")
	local currentFishName
	if (currentFish ~= nil) then
		currentFishName = api.Unit:GetUnitInfoById(currentFish).name
	end
	
	-- 计算目标鱼的位置
	local x, y, z = api.Unit:GetUnitScreenPosition("target")

	-- 切换目标时隐藏 UI
	if (currentFish ~= previousFish) then
		fishTrackerCanvas:Show(false)
		fishBuffAlertCanvas:Show(false)
	end
	
	if (currentFish == nil) then
		fishTrackerCanvas:Show(false)
		fishBuffAlertCanvas:Show(false)
	end
	
	-- 检查鱼的健康状态
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
	
	-- 检查 Buff 数量
	local buffCount = api.Unit:UnitBuffCount("target")
	if buffCount == nil or buffCount == 0 then
		fishBuffAlertCanvas:Show(false)
		return  -- 直接返回，不处理 Buff
	end
	
	-- 尝试获取 Buff
	local selectedBuff = api.Unit:UnitBuff("target", 2)
	if (selectedBuff == nil) then
		selectedBuff = api.Unit:UnitBuff("target", 3)
		if (selectedBuff == nil) then
			selectedBuff = api.Unit:UnitBuff("target", 1)
		end
	end
	
	-- 不再处理 Buff 的显示，直接返回
	if (selectedBuff and fishBuffIdsToAlert[selectedBuff.buff_id] ~= nil) then
		previousFish = currentFish
		if (previousBuffTimeRemaining ~= selectedBuff.timeLeft) then
			previousBuffTimeRemaining = selectedBuff.timeLeft
		end

		-- 这里可以选择不更新 UI，直接返回
		return
	end
	
	-- 其他逻辑...
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

fish_track.OnLoad = OnLoad
fish_track.OnUnload = OnUnload

return fish_track
