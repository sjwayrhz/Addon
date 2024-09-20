local api = require("api")

local reality_check_addon = {
	name = "Reality Check",
	author = "Michaelqt",
	version = "0.1",
	desc = "Time-related utilities for labor and in-game time."
}

local LABORPOINT_CAP = 10000
local LABORPOINT_REGEN_PER_5_MIN = 40
local WARNING_MINUTES_ORANGE = 120
local WARNING_MINUTES_RED = 30

local realityCheckWnd
local function displayTimeString(timeInMs)
    local seconds = math.floor(timeInMs / 1000) % 60
    local minutes = math.floor(timeInMs / (1000*60)) % 60  
    local hours = math.floor(timeInMs / (1000*60*60)) % 24
    
    return string.format("%02dh %02dm", hours, minutes)
end

local function displayIRLTimeString(timeInMs)
    local seconds = math.floor(timeInMs / 1000) % 60
    local minutes = math.floor(timeInMs / (1000*60)) % 60  
    local hours = math.floor(timeInMs / (1000*60*60)) % 24
    
    return string.format("%02d:%02d", hours, minutes)
end 

local function updateLaborTimer(diff, laborPower)
    local distToLaborCap = LABORPOINT_CAP - tonumber(laborPower)
    local minutesUntilLaborCap = distToLaborCap / (LABORPOINT_REGEN_PER_5_MIN / 5)
    local msUntilLaborCap = minutesUntilLaborCap * 60 * 1000
    -- TODO: Add the real life time when you'll cap
    -- local localTimeMsWhenCapped = api.Time:GetLocalTime() + msUntilLaborCap
    -- api.Log:Info(tostring(api.Time:GetLocalTime()) ..  " " .. tostring(msUntilLaborCap))
    -- api.Log:Info(displayTimeString(api.Time:GetLocalTime()) ..  " " .. displayTimeString(msUntilLaborCap))
    -- realityCheckWnd.laborTimer:SetText("Time to Labor Cap: " .. displayTimeString(msUntilLaborCap) .. " (" .. tostring(displayIRLTimeString(localTimeMsWhenCapped)) .. " IRL)")
    realityCheckWnd.laborTimer:SetText("Time to Labor Cap: " .. displayTimeString(msUntilLaborCap))
    if minutesUntilLaborCap > WARNING_MINUTES_ORANGE then 
        ApplyTextColor(realityCheckWnd.laborTimer, FONT_COLOR.LABORPOWER_YELLOW)
    elseif minutesUntilLaborCap < WARNING_MINUTES_ORANGE and minutesUntilLaborCap > WARNING_MINUTES_RED then 
        ApplyTextColor(realityCheckWnd.laborTimer, FONT_COLOR.ORANGE)
    elseif minutesUntilLaborCap < WARNING_MINUTES_RED then
        ApplyTextColor(realityCheckWnd.laborTimer, FONT_COLOR.RED)
    end 
end 

local function OnUpdate(dt)
    
end 

local function OnLoad()
	local settings = api.GetSettings("reality_check")
    realityCheckWnd = api.Interface:CreateEmptyWindow("realityCheckWnd", "UIParent")
    

    local laborTimer = realityCheckWnd:CreateChildWidget("label", "laborTimer", 0, true)
    laborTimer.style:SetAlign(ALIGN.LEFT)
    laborTimer:AddAnchor("BOTTOMLEFT", "UIParent", 300, -24)
    ApplyTextColor(laborTimer, FONT_COLOR.LABORPOWER_YELLOW)

    laborTimer:SetText("Time to Labor Cap: Waiting for labor tick...")

    --- Event Handlers for main window
    -- Whenever there's a chat message, see if we should pop the window up.
    function realityCheckWnd:OnEvent(event, ...)
        if event == "LABORPOWER_CHANGED" then
            if arg ~= nil then 
                updateLaborTimer(unpack(arg))
            end 
        end
    end
    realityCheckWnd:SetHandler("OnEvent", realityCheckWnd.OnEvent)
    realityCheckWnd:RegisterEvent("LABORPOWER_CHANGED")

    realityCheckWnd:Show(true)
	
    api.On("UPDATE", OnUpdate)
	api.SaveSettings()
end

local function OnUnload()
	api.On("UPDATE", function() return end)
    realityCheckWnd:ReleaseHandler("LABORPOWER_CHANGED")
    realityCheckWnd:Show(false)
    realityCheckWnd = nil
end

reality_check_addon.OnLoad = OnLoad
reality_check_addon.OnUnload = OnUnload

return reality_check_addon
