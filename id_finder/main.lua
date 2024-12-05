local api = require("api")

local id_finder_addon = {
    name = "ID Finder",
    version = "0.1",
    author = "Crawling/Mr.GPT",
    desc = "Prints the IDs/names of buffs/debuffs on the target."
}

local Canvas, infoButton

local function DisplayBuffsDebuffs()
    local target = api.Unit:GetUnitId("target")
    if not target then
        api.Log:Info("No target selected.")
        return
    end

    api.Log:Info("Target ID: " .. target)
    local buffCount = api.Unit:UnitBuffCount("target")
    local debuffCount = api.Unit:UnitDeBuffCount("target")
    local message = "Buffs and Debuffs on Target:\n"

    if buffCount > 0 then
        -- Collect Buff IDs and Names
        for i = 1, buffCount do
            local buff = api.Unit:UnitBuff("target", i)
            if buff and buff.buff_id then
                local buffTooltip = api.Ability:GetBuffTooltip(buff.buff_id)
                local buffName = buffTooltip and buffTooltip.name or "Unknown Buff Name"
                message = message .. string.format("Buff ID: %d, Name: %s\n", buff.buff_id, buffName)
            else
                api.Log:Info("Failed to get buff information.")
            end
        end
    else
        message = message .. "No buffs found.\n"
    end

    if debuffCount > 0 then
        -- Collect Debuff IDs and Names
        for i = 1, debuffCount do
            local debuff = api.Unit:UnitDeBuff("target", i)
            if debuff and debuff.buff_id then
                local debuffTooltip = api.Ability:GetBuffTooltip(debuff.buff_id)
                local debuffName = debuffTooltip and debuffTooltip.name or "Unknown Debuff Name"
                message = message .. string.format("Debuff ID: %d, Name: %s\n", debuff.buff_id, debuffName)
            else
                api.Log:Info("Failed to get debuff information.")
            end
        end
    else
        message = message .. "No debuffs found.\n"
    end

    api.Log:Info(message)
end

local function OnLoad()
    Canvas = api.Interface:CreateEmptyWindow("DisplayBuffsDebuffsWindow")
    Canvas:Show(true)
    
    infoButton = Canvas:CreateChildWidget("button", "infoButton", 0, true)
    infoButton:Show(true)
    infoButton:AddAnchor("CENTER", Canvas, "CENTER", 90, 30)
    infoButton:SetText("Display Buffs/Debuffs")
    infoButton:SetHandler("OnClick", function()
        DisplayBuffsDebuffs()
    end)
    api.Interface:ApplyButtonSkin(infoButton, BUTTON_BASIC.DEFAULT)
end

local function OnUnload()
    if Canvas ~= nil then
        Canvas:Show(false)
        Canvas = nil
    end
end

id_finder_addon.OnLoad = OnLoad
id_finder_addon.OnUnload = OnUnload

return id_finder_addon