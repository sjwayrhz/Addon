local api = require("api")

-- 定义笔记本配置
local notepads = {
    {name = "notebook-01", buttonText = "Author"},
    {name = "notebook-02", buttonText = "Need"},
    {name = "notebook-03", buttonText = "Political"},
    {name = "notebook-04", buttonText = "Asylum"}
}

local DISPLAY = {}
local buttons = {}
local noteWindows = {}
local textEdits = {}
local lastSaveTimes = {}
local Canvas
local toggleBtn

function DISPLAY.CreateDisplay(settings)
    local canvas_x = settings.x or 500
    local canvas_y = settings.y or 20
    
    Canvas = api.Interface:CreateEmptyWindow("notepadWindow", "UIParent")
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

    Canvas:SetExtent(200, 35 + (#notepads * 50))
    Canvas:Show(true)

    -- 修复拖动功能
    function Canvas:OnDragStart(arg)
        if arg == "LeftButton" and api.Input:IsShiftKeyDown() then
            Canvas:StartMoving()
            api.Cursor:ClearCursor()
            api.Cursor:SetCursorImage(CURSOR_PATH.MOVE, 0, 0)
        end
    end
    
    function Canvas:OnDragStop()
        local current_x, current_y = Canvas:GetOffset()
        settings.x = current_x
        settings.y = current_y
        api.SaveSettings()
        Canvas:StopMovingOrSizing()
        api.Cursor:ClearCursor()
    end

    -- 正确设置拖动事件处理
    Canvas:SetHandler("OnDragStart", Canvas.OnDragStart)
    Canvas:SetHandler("OnDragStop", Canvas.OnDragStop)
    Canvas:SetHandler("OnMouseDown", function(self, arg)
        if arg == "LeftButton" and api.Input:IsShiftKeyDown() then
            self:StartMoving()
        end
    end)
    Canvas:SetHandler("OnMouseUp", function(self)
        self:StopMovingOrSizing()
    end)

    -- 创建切换按钮并设置为相对位置
    toggleBtn = api.Interface:CreateWidget("button", "notepadToggleBtn", Canvas)
    toggleBtn:Show(true)
    toggleBtn:AddAnchor("TOPRIGHT", Canvas, -10, 5)
    api.Interface:ApplyButtonSkin(toggleBtn, BUTTON_BASIC.MINUS)

    function toggleBtn:OnClick()
        if Canvas:GetHeight() > 35 then
            -- 折叠视窗
            Canvas:SetExtent(200, 35)
            api.Interface:ApplyButtonSkin(toggleBtn, BUTTON_BASIC.PLUS)
            toggleBtn:SetText("+")

            -- 隐藏笔记按钮
            for _, button in ipairs(buttons) do
                button:Show(false)
            end
        else
            -- 展开视窗
            Canvas:SetExtent(200, 35 + (#notepads * 50))
            api.Interface:ApplyButtonSkin(toggleBtn, BUTTON_BASIC.MINUS)
            toggleBtn:SetText("-")

            -- 显示笔记按钮
            for _, button in ipairs(buttons) do
                button:Show(true)
            end
        end
        settings.hidden = not settings.hidden
        api.SaveSettings()
    end
    toggleBtn:SetHandler("OnClick", toggleBtn.OnClick)

    return Canvas
end

function DISPLAY.createButton(Canvas, notepad, x, y, settings)
    local button = api.Interface:CreateWidget("button", notepad.name .. "_button", Canvas)
    
    table.insert(buttons, button)
    
    button:Show(true)
    button:AddAnchor("TOPLEFT", Canvas, x, y)
    button:SetText(notepad.buttonText)
    
    api.Interface:ApplyButtonSkin(button, BUTTON_BASIC.DEFAULT)
    
    local button_width = button:GetWidth()
    local canvas_width = Canvas:GetWidth()
    
    if button_width > canvas_width - 50 then
        Canvas:SetExtent(button_width + 50, Canvas:GetHeight())
    end
    
    button:SetHandler("OnClick", function()
        DISPLAY.toggleNoteWindow(notepad.name)
    end)

    return button
end

function DISPLAY.createNoteWindow(notepad)
    local noteWindow = api.Interface:CreateWindow(notepad.name .. "Window", notepad.name)
    noteWindow:Show(false)

    local wW, wH = noteWindow:GetExtent()

    noteWindow:SetExtent(wW / 2, wH / 2)

    local textEdit = W_CTRL.CreateMultiLineEdit(notepad.name .. "Edit", noteWindow)
    textEdit:SetExtent((wW / 2) - 20, (wH / 2) - 54)
    textEdit:AddAnchor("TOPLEFT", noteWindow, 10, 40)

    noteWindows[notepad.name] = noteWindow
    textEdits[notepad.name] = textEdit

    function noteWindow:OnClose()
        noteWindow:Show(false)
    end
    noteWindow:SetHandler("OnClose", noteWindow.OnClose)

    -- 修复拖动功能
    function noteWindow:OnDragStart(arg)
        if arg == "LeftButton" and api.Input:IsShiftKeyDown() then
            noteWindow:StartMoving()
            api.Cursor:ClearCursor()
            api.Cursor:SetCursorImage(CURSOR_PATH.MOVE, 0, 0)
        end
    end
    
    function noteWindow:OnDragStop()
        local current_x, current_y = noteWindow:GetOffset()
        settings.x = current_x
        settings.y = current_y
        api.SaveSettings()
        noteWindow:StopMovingOrSizing()
        api.Cursor:ClearCursor()
    end

    noteWindow:SetHandler("OnDragStart", noteWindow.OnDragStart)
    noteWindow:SetHandler("OnDragStop", noteWindow.OnDragStop)
    noteWindow:SetHandler("OnMouseDown", function(self, arg)
        if arg == "LeftButton" and api.Input:IsShiftKeyDown() then
            self:StartMoving()
        end
    end)
    noteWindow:SetHandler("OnMouseUp", function(self)
        self:StopMovingOrSizing()
    end)

    local settings = api.GetSettings("notepad_" .. notepad.name)
    local message = settings.text or ""
    textEdit:SetText(message)

    function textEdit:OnTextChanged()
        lastSaveTimes[notepad.name] = api.Time:GetUiMsec() + 3000
    end
    textEdit:SetHandler("OnTextChanged", textEdit.OnTextChanged)

    -- 设置保存的位置
    if settings.x and settings.y then
        noteWindow:ClearAllPoints()
        noteWindow:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", settings.x, settings.y)
    end
end

function DISPLAY.toggleNoteWindow(notepadName)
    local noteWindow = noteWindows[notepadName]
    if noteWindow:IsVisible() then
        noteWindow:Show(false)
    else
        noteWindow:Show(true)
    end
end

function DISPLAY.Update()
    local currentTime = api.Time:GetUiMsec()
    for name, lastSaveTime in pairs(lastSaveTimes) do
        if lastSaveTime ~= -1 and lastSaveTime < currentTime then
            lastSaveTimes[name] = -1
            local settings = api.GetSettings("notepad_" .. name)
            settings.text = textEdits[name]:GetText()
            api.SaveSettings()
        end
    end
end

local function OnLoad()
    local settings = api.GetSettings("notepad")
    Canvas = DISPLAY.CreateDisplay(settings)
    
    local startX = 20
    local startY = 20
    local offset = 0
    
    for i, notepad in ipairs(notepads) do
        DISPLAY.createButton(Canvas, notepad, startX, startY + offset, settings)
        DISPLAY.createNoteWindow(notepad)
        offset = offset + 50
    end
    
    api.Log:Info("Multi-Notepad loaded successfully!")
end

local function OnUpdate()
    DISPLAY.Update()
end

local function OnUnload()
    if Canvas ~= nil then
        Canvas:Show(false)
        Canvas = nil
    end
    if toggleBtn ~= nil then
        toggleBtn:Show(false)
        toggleBtn = nil
    end
    for _, noteWindow in pairs(noteWindows) do
        if noteWindow ~= nil then
            noteWindow:Show(false)
        end
    end
end

return {
    name = "Multi-Notepad",
    desc = "Multiple notebooks help you remember life",
    version = "0.1",
    author = "Usb",
    OnLoad = OnLoad,
    OnUnload = OnUnload,
    OnUpdate = OnUpdate
}