local add = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/additional.lua"))()
local lp = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local enabled = true
local cancelquest = rs:WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("questService"):WaitForChild("RE"):WaitForChild("CancelCurrentQuest")
game.Players.LocalPlayer.Idled:Connect(function() game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end)
local function nquest()
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
    for i,v in pairs(game:GetService("Workspace").Interactions.Sidequests:children()) do
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
    if level >= 205 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nquest(), "Joko")
    elseif level >= 195 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nquest(), "Poison Shrooms")
    elseif level >= 175 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nquest(), "Cursed Sushis")
    elseif level >= 160 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nquest(), "Gnashers")
    elseif level >= 140 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nquest(), "Crabions")
    elseif level >= 130 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nquest(), "Hanamato")
    elseif level >= 125 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nquest(), "Rogue Sorcerers")
    elseif level >= 110 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nquest(), "Fire Shrooms")
    elseif level >= 80 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nquest(), "Fly Heads")
    elseif level >= 70 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nquest(), "Saku")
    elseif level >= 65 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nquest(), "Seniors")
    elseif level >= 45 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nquest(), "Juniors")
    elseif level >= 30 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nquest(), "Shrooms")
    elseif level >= 15 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nquest(), "Armed Bandits")
    elseif level >= 1 then rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nquest(), "Bandits") end
    task.wait(0.1)
    rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nquest(), "Confirm")
end
local owner = "dimasikprofi4"
game.Players[owner].Chatted:Connect(function(text)
    if text == "here" then
        lp.Character.PrimaryPart.CFrame = game.Players["dimasikprofi4"].Character.PrimaryPart.CFrame
    elseif text == "toggle" then
        if enabled then enabled = false else enabled = true end
    elseif text == "take" then
        getquest()
        gettarget()
    elseif text == "done" then
        rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nquest(), "Bye")
    elseif text == "cancel" then
        cancelquest:FireServer()
    elseif text == "party" then
        rs.Knit.Services.partyService.RE.Invite:FireServer(owner)
    end
end)
lp.Chatted:Connect(function(text)
    if game.Players:FindFirstChild(text) then
        owner = text
    end
end)