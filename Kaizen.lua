local add = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/additional.lua"))()
local lp = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local cancelquest = rs.Knit.Services.questService.RE.CancelCurrentQuest
local talk = rs.Knit.Services.interactService.RF.GetOptionData
local invite = rs.Knit.Services.partyService.RE.Invite
game.Players.LocalPlayer.Idled:Connect(function() game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end)
local function nearestquest()
    for i,Quest in pairs(game.Workspace:WaitForChild("Debris"):WaitForChild("InteractionModels"):children()) do
        if Quest:FindFirstChild("HumanoidRootPart") and add.dist_to(Quest.PrimaryPart.Position) <= 15 then
            local quest = Quest.Name
            return quest
        end
    end
    return ""
end
local function tptoquest(questname)
    for _,Quest in pairs(game.Workspace:WaitForChild("Debris"):WaitForChild("InteractionModels"):children()) do
        if Quest.Name == questname and add.dist_to(Quest.PrimaryPart.Position) > 20 then
            lp.Character.PrimaryPart.CFrame = Quest.PrimaryPart.CFrame
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
    if level >= 205 then talk:InvokeServer(nearestquest(), "Joko")
    elseif level >= 195 then talk:InvokeServer(nearestquest(), "Poison Shrooms")
    elseif level >= 175 then talk:InvokeServer(nearestquest(), "Cursed Sushis")
    elseif level >= 160 then talk:InvokeServer(nearestquest(), "Gnashers")
    elseif level >= 130 then talk:InvokeServer(nearestquest(), "Hanamato")
    elseif level >= 125 then talk:InvokeServer(nearestquest(), "Rogue Sorcerers")
    elseif level >= 110 then talk:InvokeServer(nearestquest(), "Fire Shrooms")
    elseif level >= 80 then talk:InvokeServer(nearestquest(), "Fly Heads")
    elseif level >= 70 then talk:InvokeServer(nearestquest(), "Saku")
    elseif level >= 65 then talk:InvokeServer(nearestquest(), "Seniors")
    elseif level >= 45 then talk:InvokeServer(nearestquest(), "Juniors")
    elseif level >= 30 then talk:InvokeServer(nearestquest(), "Shrooms")
    elseif level >= 15 then talk:InvokeServer(nearestquest(), "Armed Bandits")
    elseif level >= 1 then talk:InvokeServer(nearestquest(), "Bandits") end
    task.wait(0.1)
    talk:InvokeServer(nearestquest(), "Confirm")
end
local owner = "dimasikprofi4"
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
end)