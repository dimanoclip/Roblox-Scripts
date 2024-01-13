local add = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/additional.lua"))()
local lp = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local cancelquest = rs.Knit.Services.questService.RE.CancelCurrentQuest
local talk = rs.Knit.Services.interactService.RF.GetOptionData
local invite = rs.Knit.Services.partyService.RE.Invite
game.Players.LocalPlayer.Idled:Connect(function() game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end)
local function nearestquest()
    for i,v in pairs(game.Workspace:WaitForChild("Debris"):WaitForChild("InteractionModels"):children()) do
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
    for _,v in pairs(game.Workspace:WaitForChild("Debris"):WaitForChild("InteractionModels"):children()) do
        for i1,Quest in pairs(v:children()) do
            if Quest.Name == questname and add.dist_to(Quest.Position) > 20 then
                lp.Character.PrimaryPart.CFrame = Quest.CFrame
            end
        end
    end
end
local function getquest()
    local level = tonumber(string.split(lp.PlayerGui.UI.Tabs.MenuButton.Level.Text, "LV. ")[2])
    if level >= 205 then tptoquest("Pygmy")
    elseif level >= 195 then tptoquest("SwampPrimarySideQuest")
    elseif level >= 175 then tptoquest("SwampPrimarySideQuest")
    elseif level >= 160 then tptoquest("MidoriPrimarySideQuests")
    elseif level >= 130 then tptoquest("Yuzi2")
    elseif level >= 125 then tptoquest("MidoriPrimarySideQuests")
    elseif level >= 110 then tptoquest("EnrolmentCurseQuest")
    elseif level >= 80 then tptoquest("EnrolmentCurseQuest")
    elseif level >= 70 then tptoquest("Miwa")
    elseif level >= 65 then tptoquest("StudentSideQuest")
    elseif level >= 45 then tptoquest("StudentSideQuest")
    elseif level >= 30 then tptoquest("ShroomSideQuest")
    elseif level >= 15 then tptoquest("BanditSideQuest")
    elseif level >= 1 then tptoquest("BanditSideQuest") end
end
local function gettarget()
    local level = tonumber(string.split(lp.PlayerGui.UI.Tabs.MenuButton.Level.Text, "LV. ")[2])
    if level >= 205 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Joko")
    elseif level >= 195 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Poison Shrooms")
    elseif level >= 175 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Cursed Sushis")
    elseif level >= 160 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Gnashers")
    elseif level >= 130 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Hanamato")
    elseif level >= 125 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Rogue Sorcerers")
    elseif level >= 110 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Fire Shrooms")
    elseif level >= 80 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Fly Heads")
    elseif level >= 70 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Saku")
    elseif level >= 65 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Seniors")
    elseif level >= 45 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Juniors")
    elseif level >= 30 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Shrooms")
    elseif level >= 15 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Armed Bandits")
    elseif level >= 1 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Bandits") end
    task.wait(0.1)
    rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Confirm")
end
local function remlastowns(curown)
    for i,v in pairs(game.Players:children()) do
        if v:FindFirstChild("OwnerCheck") and v.Name ~= curown then
            v:FindFirstChild("OwnerCheck"):Remove()
        end
    end
end
local owner = "dimasikprofi4"
local owneraccess
task.spawn(function()
    while task.wait() do
        if not game.Players:WaitForChild(owner):FindFirstChild("OwnerCheck") then
            if owneraccess then owneraccess:Disconnect() end
            owneraccess = game.Players:WaitForChild(owner).Chatted:Connect(function(text)
                if game.Players:WaitForChild(owner):FindFirstChild("OwnerCheck") then
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
                end
            end)
            local ownercheck = Instance.new("BoolValue", game.Players[owner])
            ownercheck.Name = "OwnerCheck"
            ownercheck.Value = true
            remlastowns(owner)
        end
    end
end)

game.Players.LocalPlayer.Chatted:Connect(function(text)
    if game.Players:FindFirstChild(text) then
        print("Owner changed to "..text)
        owner = text
    end
end)