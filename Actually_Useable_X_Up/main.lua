local api = require("api")
local auxu = {
    name = "Actually Useable X Up",
    version = "2.0",
    author = "MikeTheShadow",
    desc = "It's actually useable."
}

local blocklist = {}

local recruit_message = ""

local recruit_textfield

local recruit_button

local filter_dropdown

local is_recruiting = false

local raid_manager

local RecruitCanvas

local dms_only

local function OnLoad()


    local settings = api.GetSettings("auxu")

    if settings.blocklist == nil then
        settings.blocklist = {}
        settings.hide_cancel = false
        api.SaveSettings()
    end

    -- Recruit canvas

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

    function RecruitCanvas:OnDragStart()
        if api.Input:IsShiftKeyDown() then
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
    RecruitCanvas:EnableDrag(true)

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

    -- Recruit filtering
    filter_dropdown = api.Interface:CreateComboBox(raid_manager)
    filter_dropdown:SetExtent(100, 30)
    filter_dropdown:AddAnchor("LEFT", raid_manager, 285, 140)
    filter_dropdown.dropdownItem =  {"Equals","Contains","Starts With"}
    filter_dropdown:Select(1)
    filter_dropdown:Show(true)

    -- DMs only
    dms_only = api.Interface:CreateComboBox(raid_manager)
    dms_only:SetExtent(100, 30)
    dms_only:AddAnchor("LEFT", raid_manager, 390, 140)
    dms_only.dropdownItem = {"All Chats","Whispers","Guild"}
    dms_only:Select(1)
    dms_only:Show(true)

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
        filter_dropdown:Show(false)
        dms_only:Show(false)
    end
end



local show_settings = true

auxu.OnLoad = OnLoad
auxu.OnUnload = OnUnload

local function ResetRecruit()
    is_recruiting = false
    recruit_button:SetText("Start Recruiting")
    recruit_textfield:Enable(true)

end

local function OnChatMessage(channelId, speakerId,_, speakerName, message)

    message = message:lower()

    filter_selection = filter_dropdown.selctedIndex

    is_null = string.find(message, recruit_message, 1, true) == nil

    if not speakerName or recruit_message == "" then
        return
    end

    if not is_recruiting then
        ResetRecruit()
        return
    end

    -- Filter check

    filter_selection = filter_dropdown.selctedIndex

    if filter_selection == 1 and message ~= recruit_message then
        return
    elseif filter_selection == 2 and string.find(message, recruit_message, 1, true) == nil then
        return
    elseif filter_selection == 3 and string.sub(message, 1, #recruit_message) ~= recruit_message then
        return
    end

    recruit_method = dms_only.selctedIndex

    if recruit_method == 1 then
        api.Log:Info(("Inviting " .. speakerName))
        api.Team:InviteToTeam(speakerName, false)
    elseif recruit_method == 2 and channelId == -3 then
        api.Log:Info(("Inviting " .. speakerName))
        api.Team:InviteToTeam(speakerName, false)
    elseif recruit_method == 3 and channelId == 7 then
        api.Log:Info(("Inviting " .. speakerName))
        api.Team:InviteToTeam(speakerName, false)
    end
end

api.On("CHAT_MESSAGE", OnChatMessage)

return auxu