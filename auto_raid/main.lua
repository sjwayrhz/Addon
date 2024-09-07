local api = require("api")
local auxu = {
    name = "Actually Useable X Up",
    version = "1.0",
    author = "MikeTheShadow",
    desc = "Seriously. It's actually useable."
}

local recruit_message = ""

local recruit_textfield

local recruit_button

local is_recruiting = false

local raid_manager

local RecruitCanvas

local function OnLoad()
    
    RecruitCanvas = api.Interface:CreateEmptyWindow("recruitWindow")
    RecruitCanvas:AddAnchor("CENTER", "UIParent", 0, 50)
    RecruitCanvas:SetExtent(200,100)
    RecruitCanvas:Show(false)
    
    RecruitCanvas.bg = RecruitCanvas:CreateNinePartDrawable(TEXTURE_PATH.HUD, "background")
    RecruitCanvas.bg:SetTextureInfo("bg_quest")
    RecruitCanvas.bg:SetColor(0, 0, 0, 0.5)
    RecruitCanvas.bg:AddAnchor("TOPLEFT", RecruitCanvas, 0, 0)
    RecruitCanvas.bg:AddAnchor("BOTTOMRIGHT", RecruitCanvas, 0, 0)
    
    cancelButton = RecruitCanvas:CreateChildWidget("button","cancel_x", 0 , true)
    cancelButton:SetText("Cancel Auto Raid")
    cancelButton:AddAnchor("TOPLEFT", RecruitCanvas, "TOPLEFT", 37, 34)
    api.Interface:ApplyButtonSkin(cancelButton, BUTTON_BASIC.DEFAULT)

    function RecruitCanvas:OnDragStart(arg)
        if arg == "LeftButton" and api.Input:IsShiftKeyDown() then
          RecruitCanvas:StartMoving()
          api.Cursor:ClearCursor()
          api.Cursor:SetCursorImage(CURSOR_PATH.MOVE, 0, 0)
        end
    end
    RecruitCanvas:SetHandler("OnDragStart", RecruitCanvas.OnDragStart)
    function RecruitCanvas:OnDragStop()
        RecruitCanvas:StopMovingOrSizing()
        api.Cursor:ClearCursor()
    end
    RecruitCanvas:SetHandler("OnDragStop", RecruitCanvas.OnDragStop)
    RecruitCanvas:RegisterForDrag("LeftButton")
    
    raid_manager = ADDON:GetContent(UIC.RAID_MANAGER)
    
    canvas_width = raid_manager:GetWidth()
    
    raid_manager:SetExtent(canvas_width,440)
    
    recruit_button = raid_manager:CreateChildWidget("button", "raid_setup_button", 0, true)
    recruit_button:SetExtent(300, 60)
    recruit_button:AddAnchor("LEFT", raid_manager, 20, 140)
    recruit_button:SetText("Start Recruiting")
    api.Interface:ApplyButtonSkin(recruit_button, BUTTON_BASIC.DEFAULT)
    
    recruit_textfield = W_CTRL.CreateEdit("recruit_message", raid_manager)
    recruit_textfield:AddAnchor("LEFT", raid_manager, 131, 140)
    recruit_textfield:SetExtent(150, 30)
    recruit_textfield:SetMaxTextLength(64)
    recruit_textfield:CreateGuideText("X CR")
    recruit_textfield:Show(true)
    
    recruit_button:SetHandler("OnClick", function()
        if is_recruiting then
            is_recruiting = false
            recruit_button:SetText("Start Recruiting")
            recruit_textfield:Enable(true)
            RecruitCanvas:Show(false)
        else
            is_recruiting = true
            recruit_button:SetText("Stop Recruiting")
            recruit_textfield:Enable(false)
            recruit_message = string.lower(recruit_textfield:GetText())
            RecruitCanvas:Show(true)
        end
    end)
    
    cancelButton:SetHandler("OnClick", function()
        if is_recruiting then
            is_recruiting = false
            recruit_button:SetText("Start Recruiting")
            recruit_textfield:Enable(true)
            RecruitCanvas:Show(false)
        else
            is_recruiting = true
            recruit_button:SetText("Stop Recruiting")
            recruit_textfield:Enable(false)
            recruit_message = string.lower(recruit_textfield:GetText())
            RecruitCanvas:Show(true)
        end
    end)
end

local function OnUnload()
    if recruit_button then
        recruit_button:Show(false)
        recruit_textfield:Show(false)
        raid_manager:SetExtent(canvas_width,395)
        RecruitCanvas:Show(false)
    end
end

auxu.OnLoad = OnLoad
auxu.OnUnload = OnUnload

local function ResetRecruit()
    is_recruiting = false
    recruit_button:SetText("Start Recruiting")
    recruit_textfield:Enable(true) 
end

local function OnChatMessage(_, speakerId, _, speakerName, message)

    if not speakerName or recruit_message == "" or not is_recruiting then
        return
    end
    
    is_recruiting = false
    
    for i = 1, 50 do
        team_member = api.Unit:GetUnitInfoById("team" .. i)
        if team_member == nil then
            is_recruiting = true
            break
        end
    end
    
    if not is_recruiting then
        ResetRecruit()
        return
    end
    
    if string.lower(message) == recruit_message then
        api.Log:Info(("Inviting " .. speakerName))
        api.Team:InviteToTeam(speakerName, false)
    end
end

api.On("CHAT_MESSAGE", OnChatMessage)

return auxu