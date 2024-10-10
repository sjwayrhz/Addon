local toggleBtn, noteWindow

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
    toggleBtn = api.Interface:CreateWidget("button", "notePadToggleBtn", api.rootWindow)
    toggleBtn:Show(true)
    toggleBtn:AddAnchor("TOPRIGHT", "UIParent", -270, 3)
    api.Interface:ApplyButtonSkin(toggleBtn, BUTTON_BASIC.PLUS)

    noteWindow = api.Interface:CreateWindow("notesWindow", "笔记本")
    noteWindow:Show(false)

    textEdit = W_CTRL.CreateMultiLineEdit("noteEdit", noteWindow)
    local wW, wH = noteWindow:GetExtent()
    textEdit:SetExtent(wW - 20, wH - 54)
    textEdit:AddAnchor("TOPLEFT", noteWindow, 10, 44)

    function toggleBtn:OnClick()
        if noteWindow:IsVisible() then
            noteWindow:Show(false)
            api.Interface:ApplyButtonSkin(toggleBtn, BUTTON_BASIC.PLUS)
        else
            noteWindow:Show(true)
            api.Interface:ApplyButtonSkin(toggleBtn, BUTTON_BASIC.MINUS)
        end
    end
    toggleBtn:SetHandler("OnClick", toggleBtn.OnClick)

    -- 添加窗口关闭事件处理
    function noteWindow:OnClose()
        noteWindow:Show(false)
        api.Interface:ApplyButtonSkin(toggleBtn, BUTTON_BASIC.PLUS)
    end
    noteWindow:SetHandler("OnClose", noteWindow.OnClose)

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
    if toggleBtn ~= nil then
        toggleBtn:Show(false)
        toggleBtn = nil
    end

    if noteWindow ~= nil then
        noteWindow:Show(false)
        noteWindow = nil
    end
end

return {
    name = "Notepad",
    desc = "A simple notepad",
    version = "0.1.1",
    author = "Usb",
    OnLoad = OnLoad,
    OnUnload = OnUnload
}