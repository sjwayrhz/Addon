local api = require("api")

local korean_combat_text_addon = {
	name = "Korean Combat Text",
	author = "Michaelqt",
	version = "0.1",
	desc = "Replace combat text with custom font."
}

local defaultFontPath = "ui/font/pgm-mod.ttf"
local originalFontPath = "ui/font/yoon_firedgothic_b.ttf"

local defaultFontSize = combatTextLocale.fontSize + 2
local originalFontSize = combatTextLocale.fontSize

local function applyCustomFont(labelWidget, fontPath, fontSize)
	labelWidget.style:SetFont(fontPath, fontSize)
	labelWidget.extraStyle:SetFont(fontPath, fontSize)
end 

local function OnLoad()
	local settings = api.GetSettings("korean_combat_text")
	if settings.combatFontPath == nil then 
		settings.combatFontPath = defaultFontPath
	end
	if settings.combatFontSize == nil then
	 	settings.combatFontSize = defaultFontSize
	end

	local combatTextFrame = ADDON:GetContent(UIC.COMBAT_TEXT_FRAME)
	for i, combatText in ipairs(combatTextFrame.combatTexts) do
		applyCustomFont(combatTextFrame.combatTexts[i], settings.combatFontPath, settings.combatFontSize)
	end 
	api.SaveSettings()
end

local function OnUnload()
	local settings = api.GetSettings("korean_combat_text")
	local combatTextFrame = ADDON:GetContent(UIC.COMBAT_TEXT_FRAME)
	for i, combatText in ipairs(combatTextFrame.combatTexts) do
		applyCustomFont(combatTextFrame.combatTexts[i], settings.combatFontPath, settings.combatFontSize)
	end 
end

korean_combat_text_addon.OnLoad = OnLoad
korean_combat_text_addon.OnUnload = OnUnload

return korean_combat_text_addon
