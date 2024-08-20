local raid_maker_addon = {
    name = "Auto Raid",
    author = "Arch+Ikaiser",
    version = "1.3",
    desc = "Toggle Auto Invites | holds keyword after disabling"
}

--Modified by Ikaiser

local inviteEnabled = false
local inviteKeyword = false
local autoInviteBtn
local prefix
local keyword
local playerId = api.Unit:GetUnitId("player")
local remindercount = 0
local remindeAt = 100
local setup = false

-- Create UI button and attach it to the raid window
local function CreateUI(raidWnd)
    if not raidWnd.autoInviteBtn then
	-- Initial setup
		if not setup then
			autoInviteBtn = raidWnd:CreateChildWidget("button", "invite_toggle", 0, true)
			autoInviteBtn:SetExtent(300, 60)
			autoInviteBtn:AddAnchor("CENTER", raidWnd, 0, 160)
			autoInviteBtn:SetText("Enable Auto")
			api.Interface:ApplyButtonSkin(autoInviteBtn, BUTTON_BASIC.DEFAULT)
			setup = true
		end

	-- Button Clicks
        autoInviteBtn:SetHandler("OnClick", function()
            inviteEnabled = not inviteEnabled
			if inviteEnabled then
				autoInviteBtn:SetText("Disable Auto")
				api.Log:Info("Auto invite is enabled.  \#To Setup Type \"x up for \[key\]\"")
				
				-- is there a keyword already? if so let the user know what it is.
				if inviteKeyword ~= nil then
					api.Log:Info("Auto Invite keyword is: \'" .. keyword .. "\'")
				end
            else
				autoInviteBtn:SetText("Enable Auto")
				api.Log:Info("Auto invite is disabled")
			end
        end)

        
    end
end

-- Handle chat messages for invites
local function OnChatMessage(_, speakerId, _, speakerName, message)
    -- If disabled, do not read
	if not inviteEnabled then return end
	
	-- makes the message uniform
	local lowermessage = message:lower()
	remindercount = remindercount + 1
	-- From the User or other User
    if speakerId == playerId then

        --resets all variables
        if string.match(lowermessage, "full") == "full" then
			--resets all variables
            api.Log:Info("Auto Invite Manually Disabled, Enable Auto Inviter to resume")
			autoInviteBtn:SetText("Enable Auto")
			inviteEnabled = false
		
		-- Setting up new Keyword		
		elseif string.match(lowermessage, "x up for") then
			local tempkey = string.match(lowermessage, "x up for (%w+)")
			keyword = "x " .. tempkey
			api.Log:Info("Auto Invite keyword is: \'" .. keyword .. "\'")
		end

	-- Message is not from user, Match keyword to message
    elseif keyword == string.match(lowermessage,keyword) then
        api.Team:InviteToTeam(speakerName, false)
		--api.Log:Info("\#debug\#  Invited " .. speakerName .. " for saying: " .. message)
        api.Log:Info("Invited " .. speakerName .. " to the team.   ||  Type \"full\" to end autoinviting")
    end

	--Reminds the user the Auto invite is Enabled and it's keyword,  changeable counter Default 20
	if (remindercount > remindeAt) and (keyword ~= nil) then
		api.Log:Info("\#Reminder\# Auto Invite Enabled, keyword is: \'" .. keyword .. "\'")
		remindercount = 0
	end
end

-- Handle raid manager toggle
local function OnRaidManagerToggle(raidWnd, show)
    if show then
        CreateUI(raidWnd)
    end
    raidWnd:Show(show)
end

-- Load and unload functions
local function OnLoad()
    api.Log:Info("Invite Toggle loaded.")
    api.On("CHAT_MESSAGE", OnChatMessage)
    api.On("raid_manager_toggle", OnRaidManagerToggle)
end

local function OnUnload()
    api.Log:Info("Invite Toggle unloaded.")
end

raid_maker_addon.OnLoad = OnLoad
raid_maker_addon.OnUnload = OnUnload

return raid_maker_addon
