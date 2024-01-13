local add = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/additional.lua"))()
local lp = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local cancelquest = rs.Knit.Services.questService.RE.CancelCurrentQuest
local talk = rs.Knit.Services.interactService.RF.GetOptionData
local invite = rs.Knit.Services.partyService.RE.Invite
game.Players.LocalPlayer.Idled:Connect(function() game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end)
local questTable = {
    {quest = "BanditSideQuest", target = "Bandits", level = 1},
    {quest = "BanditSideQuest", target = "Armed Bandits", level = 15},
    {quest = "ShroomSideQuest", target = "Shrooms", level = 30},
    {quest = "StudentSideQuest", target = "Juniors", level = 45},
    {quest = "StudentSideQuest", target = "Seniors", level = 65},
    {quest = "EnrolmentCurseQuest", target = "Fly Heads", level = 80},
    {quest = "EnrolmentCurseQuest", target = "Fire Shrooms", level = 110},
    {quest = "MidoriPrimarySideQuests", target = "Rogue Sorcerers", level = 125},
    {quest = "MidoriPrimarySideQuests", target = "Crabions", level = 140},
    {quest = "MidoriPrimarySideQuests", target = "Gnashers", level = 160},
    {quest = "SwampPrimarySideQuest", target = "Cursed Sushis", level = 175},
    {quest = "SwampPrimarySideQuest", target = "Poison Shrooms", level = 195},
    {quest = "SwampPrimarySideQuest", target = "Eye Fanatics", level = 220},
    {quest = "Miwa", target = "Saku", 70},
    {quest = "Yuzi2", target = "Hanamato", 130},
    {quest = "Pygmy", target = "Joko", 205}
}
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
    for i,v in pairs(questTable) do
        if v.level > level then
            tptoquest(questTable[i-1].quest)
        end
    end
end
local function gettarget()
    local level = tonumber(string.split(lp.PlayerGui.UI.Tabs.MenuButton.Level.Text, "LV. ")[2])
    for i,v in pairs(questTable) do
        if v.level > level then
            talk:InvokeServer(nearestquest(), questTable[i-1].target)
        end
    end
    task.wait(0.15)
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