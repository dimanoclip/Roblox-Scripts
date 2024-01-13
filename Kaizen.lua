local add = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/additional.lua"))()
local lp = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local cancelquest = rs.Knit.Services.questService.RE.CancelCurrentQuest
local talk = rs.Knit.Services.interactService.RF.GetOptionData
local invite = rs.Knit.Services.partyService.RE.Invite
game.Players.LocalPlayer.Idled:Connect(function() game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end)
local function nearestquest()
    for i,v in pairs(game:GetService("Workspace").Interactions.Sidequests:children()) do
        for i1,Quest in pairs(v:children()) do
            if add.dist_to(Quest.Position) <= 15 then
                local quest = Quest.Name
                return quest
            end
        end
    end
    return ""
end
local function tptoquest(questname)
    for _,v in pairs(game:GetService("Workspace").Interactions.Sidequests:children()) do
        for i1,Quest in pairs(v:children()) do
            if Quest.Name == questname and add.dist_to(Quest.Position) > 20 then
                lp.Character.PrimaryPart.CFrame = Quest.CFrame
            end
        end
    end
end
local function getquest()
    local level = tonumber(string.split(lp.PlayerGui.UI.Tabs.MenuButton.Level.Text, "LV. ")[2])
    if level >= 220 then tptoquest("SwampPrimarySideQuest")
    elseif level >= 195 then tptoquest("SwampPrimarySideQuest")
    elseif level >= 175 then tptoquest("SwampPrimarySideQuest")
    elseif level >= 160 then tptoquest("MidoriPrimarySideQuests")
    elseif level >= 140 then tptoquest("MidoriPrimarySideQuests")
    elseif level >= 125 then tptoquest("MidoriPrimarySideQuests")
    elseif level >= 110 then tptoquest("EnrolmentCurseQuest")
    elseif level >= 80 then tptoquest("EnrolmentCurseQuest")
    elseif level >= 65 then tptoquest("StudentSideQuest")
    elseif level >= 45 then tptoquest("StudentSideQuest")
    elseif level >= 30 then tptoquest("ShroomSideQuest")
    elseif level >= 15 then tptoquest("BanditSideQuest")
    elseif level >= 1 then tptoquest("BanditSideQuest") end
end
local function gettarget()
    local level = tonumber(string.split(lp.PlayerGui.UI.Tabs.MenuButton.Level.Text, "LV. ")[2])
    if level >= 220 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Joko")
    elseif level >= 195 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Poison Shrooms")
    elseif level >= 175 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Cursed Sushis")
    elseif level >= 160 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Gnashers")
    elseif level >= 140 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Crabions")
    elseif level >= 125 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Rogue Sorcerers")
    elseif level >= 110 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Fire Shrooms")
    elseif level >= 80 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Fly Heads")
    elseif level >= 65 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Seniors")
    elseif level >= 45 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Juniors")
    elseif level >= 30 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Shrooms")
    elseif level >= 15 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Armed Bandits")
    elseif level >= 1 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Bandits") end
    task.wait(0.1)
    rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Confirm")
end
local owner = "Frost_228333"
game.Players:WaitForChild(owner).Chatted:Connect(function(text)
    if text == "cancel" then
        cancelquest:FireServer()
    elseif text == "party" then
        invite:FireServer(owner)
    elseif text == "r" then
        talk:InvokeServer(nearestquest(), "Bye")
        task.wait(0.25)
        getquest()
        task.wait(0.5)
        gettarget()
    end
    print(text)
end)