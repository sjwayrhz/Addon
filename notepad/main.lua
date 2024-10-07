local showBtn, noteWindow

local lastSaveTime = -1
local textEdit

local function OnUpdate(dt)
	if lastSaveTime ~= -1 and lastSaveTime < api.Time:GetUiMsec() then
		lastSaveTime = -1
		local settings = api.GetSettings("notepad")
		settings.text = textEdit:GetText()
		api.SaveSettings()
	end
end


local function OnLoad()
  showBtn = api.Interface:CreateWidget("button", "notePadShowBtn", api.rootWindow)
	showBtn:Show(true)
	showBtn:AddAnchor("TOPRIGHT", "UIParent", -270, 3)
	api.Interface:ApplyButtonSkin(showBtn, BUTTON_BASIC.PLUS)

	noteWindow = api.Interface:CreateWindow("notesWindow", "笔记本")
	noteWindow:Show(false)

	textEdit = W_CTRL.CreateMultiLineEdit("noteEdit", noteWindow)
	local wW, wH = noteWindow:GetExtent()
	textEdit:SetExtent(wW - 20, wH - 54)
	textEdit:AddAnchor("TOPLEFT", noteWindow, 10, 44)

	function showBtn:OnClick()
		noteWindow:Show(true)
	end
	showBtn:SetHandler("OnClick", showBtn.OnClick)

	local settings = api.GetSettings("notepad")

	local message = settings.text or ""

	textEdit:SetText(message)

	function textEdit:OnTextChanged()
		lastSaveTime = api.Time:GetUiMsec() + 3000
	end
	textEdit:SetHandler("OnTextChanged", textEdit.OnTextChanged)

	api.On("UPDATE", OnUpdate)
end

local function OnUnload()
	if showBtn ~= nil then
  	showBtn:Show(false)
  end

	if noteWindow ~= nil then
		noteWindow:Show(false)
		noteWindow = nil
	end
end


return {
	name = "Notepad",
	desc = "A simple notepad",
	version = "1.0",
	author = "Aguru",
	OnLoad = OnLoad,
	OnUnload = OnUnload
}
