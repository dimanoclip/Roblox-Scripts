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
    for _,k in pairs(game:GetService("Workspace").Interactions:children()) do
        if k.Name == "Sidequests" or k.Name == "Story" then
            for i,v in pairs(k:children()) do
                for i1,Quest in pairs(v:children()) do
                    if Quest.Name == questname and add.dist_to(Quest.Position) > 20 then
                        lp.Character.PrimaryPart.CFrame = Quest.CFrame
                    end
                end
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
    elseif level >= 140 then tptoquest("MidoriPrimarySideQuests")
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
    elseif level >= 140 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), "Crabions")
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
lp.Chatted:Connect(function(text)
    if game.Players:FindFirstChild(text) then
        owner = text
    end
end)



-- local lp = game.Players.LocalPlayer
-- local enabled, enemy, quest = true, nil, nil
-- local levelLabel = game.Players.LocalPlayer.PlayerGui:FindFirstChild("UI"):FindFirstChild("Tabs"):FindFirstChild("MenuButton"):FindFirstChild("Level")
-- local plylevel = tonumber(string.split(levelLabel.Text, "LV. ")[2])
-- local questFrameLabel = lp.PlayerGui:WaitForChild("UINoReset"):FindFirstChild("Quests"):FindFirstChild("QuestsFrame").QuestTemplate1.Label

-- game.Players.LocalPlayer.Idled:Connect(function() game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end)

-- local questTable = {
--     {"BanditSideQuest", "Bandits", 1},
--     {"BanditSideQuest", "Armed Bandits", 15},
--     {"ShroomSideQuest", "Shrooms", 30},
--     {"StudentSideQuest", "Juniors", 45},
--     {"StudentSideQuest", "Seniors", 65},
--     {"EnrolmentCurseQuest", "Fly Heads", 80},
--     {"EnrolmentCurseQuest", "Fire Shrooms", 110},
--     {"MidoriPrimarySideQuests", "Rogue Sorcerers", 125},
--     {"MidoriPrimarySideQuests", "Crabions", 140},
--     {"MidoriPrimarySideQuests", "Gnashers", 160},
--     {"SwampPrimarySideQuest", "Cursed Sushis", 175},
--     {"SwampPrimarySideQuest", "Poison Shrooms", 195},
--     {"SwampPrimarySideQuest", "Eye Fanatics", 220},
--     {"Miwa", "Saku", 70},
--     {"Yuzi2", "Hanamato", 130},
--     {"Pygmy", "Joko", 205}
-- }

-- task.spawn(function()
--     while task.wait() do
--         for i=1,#questTable do
--             if plylevel < tonumber(questTable[i][3]) then enemy = tostring(questTable[i-1][2]); quest = tostring(questTable[i-1][1]) end
--         end
--         if questFrameLabel.RichText then questFrameLabel.RichText = false end
--         if quest ~= nil and enemy ~= nil then
--             if string.find(questFrameLabel.Text, "rgb%(255, 255, 0%)") ~= nil then
--                 game:GetService("ReplicatedStorage").Knit.Services.interactService.RF.GetOptionData:InvokeServer(quest, "Bye")
--             else
--                 game:GetService("ReplicatedStorage").Knit.Services.interactService.RF.GetOptionData:InvokeServer(quest, enemy)
--                 game:GetService("ReplicatedStorage").Knit.Services.interactService.RF.GetOptionData:InvokeServer(quest, "Confirm")
--             end
--         end
--     end
-- end)
-- game.Players["dimasikprofi4"].Chatted:Connect(function(text)
--     if text == "/here" then
--         lp.Character.PrimaryPart.CFrame = game.Players["dimasikprofi4"].Character.PrimaryPart.CFrame
--     elseif text == "/toggle" then
--         if enabled then enabled = false else enabled = true end
--     elseif text == "/cancel" then
--         game:GetService("ReplicatedStorage"):WaitForChild("Knit"):WaitForChild("Services").questService.RE.CancelCurrentQuest:FireServer()
--     end
-- end)