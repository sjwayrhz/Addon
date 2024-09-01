local zeal_alert_addon = {
	name = "Zeal Alert",
	author = "Aguru",
	version = "1.0",
	desc = "An addon that prints a big message when Zeal is up."
}

-- Changing this ID will change the buff displayed & tracked
local buffIdToTrack = 495

local trackedBuffInfo = {}

local function OnUpdate()
	if trackedBuffInfo == nil then
		return
	end
	
	local buffCount = api.Unit:UnitBuffCount("player")
	for i = 1, buffCount, 1 do
  	local buff = api.Unit:UnitBuff("player", i)
		if buff.buff_id == trackedBuffInfo.buff_id then
			canvas:Show(true)
			return
		end
  end

	canvas:Show(false)
end

local function OnLoad()
	canvas = api.Interface:CreateEmptyWindow("zealAlert")
	canvas:Show(true)

	zealLabel = canvas:CreateChildWidget("label", "label", 0, true)
	zealLabel:SetText("ZEAL IS UP")
	zealLabel:AddAnchor("TOPLEFT", canvas, "TOPLEFT", 0, 22)
	zealLabel.style:SetFontSize(44)

	zealIcon = CreateItemIconButton("zealIcon", canvas)
	zealIcon:Show(true)
	F_SLOT.ApplySlotSkin(zealIcon, zealIcon.back, SLOT_STYLE.BUFF)
	zealIcon:AddAnchor("TOPLEFT", canvas, "TOPLEFT", -24, -60)

	trackedBuffInfo = api.Ability:GetBuffTooltip(buffIdToTrack)
	
  F_SLOT.SetIconBackGround(zealIcon, trackedBuffInfo.path)
	zealLabel:SetText(string.format("%s IS UP", trackedBuffInfo.name))

	canvas:AddAnchor("CENTER", "UIParent", 0, -300)
  api.On("UPDATE", OnUpdate)
end

local function OnUnload()
	if canvas ~= nil then
		canvas:Show(false)
		canvas = nil
	end
end

zeal_alert_addon.OnLoad = OnLoad
zeal_alert_addon.OnUnload = OnUnload

return zeal_alert_addon
