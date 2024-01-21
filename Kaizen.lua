local add = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/additional.lua"))()
local lp = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local cancelquest = rs.Knit.Services.questService.RE.CancelCurrentQuest
local invite = rs.Knit.Services.partyService.RE.Invite
local kick = rs.Knit.Services.partyService.RE.Kick
local disband = rs.Knit.Services.partyService.RE.Disband
local autonext = false
local curquestlvl
local pgui = lp.PlayerGui
local uinoreset = pgui:WaitForChild("UINoReset")
local questFrameLabel = uinoreset:FindFirstChild("Quests"):FindFirstChild("QuestsFrame").QuestTemplate1.Label
local old
old = hookmetamethod(game, "__namecall", function(self, ...)
    if self.Name == "FallDamage" then return
    elseif self.Name == "OnCooldown" then return
    elseif self.Name == "OnDash" then return end
    return old(self, ...)
end)
game.Players.LocalPlayer.Idled:Connect(function() game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end)
local function getlvl() return add.int(string.split(lp.PlayerGui.UI.Tabs.MenuButton.Level.Text, "LV. ")[2]) end
local function nearestquest()
    for i,Npc in pairs(game:GetService("Workspace").Debris.InteractionModels:children()) do
        if add.dist_to(Npc.HumanoidRootPart.Position) <= 10 then
            local quest = Npc.Name
            return quest
        end
    end
    return ""
end
local function selectdialog(option) rs.Knit.Services.interactService.RF.GetOptionData:InvokeServer(nearestquest(), option) end
local function tptoquest(questname)
    local npc = game:GetService("Workspace").Debris.InteractionModels:FindFirstChild(questname)
    local rp = npc:FindFirstChild("HumanoidRootPart")
    if npc and rp and add.dist_to(rp.Position) > 10 then lp.Character.PrimaryPart.CFrame = rp.CFrame end
end
local function checkquest(lvl)
    local level = lvl or getlvl()
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
local function getquest(lvl)
    local level = lvl or getlvl()
    if level >= 205 then selectdialog("Joko")
    elseif level >= 195 then selectdialog("Poison Shrooms")
    elseif level >= 175 then selectdialog("Cursed Sushis")
    elseif level >= 160 then selectdialog("Gnashers")
    elseif level >= 130 then selectdialog("Hanamato")
    elseif level >= 125 then selectdialog("Rogue Sorcerers")
    elseif level >= 110 then selectdialog("Fire Shrooms")
    elseif level >= 80 then selectdialog("Fly Heads")
    elseif level >= 70 then selectdialog("Saku")
    elseif level >= 65 then selectdialog("Seniors")
    elseif level >= 45 then selectdialog("Juniors")
    elseif level >= 30 then selectdialog("Shrooms")
    elseif level >= 15 then selectdialog("Armed Bandits")
    elseif level >= 1 then selectdialog("Bandits") end task.wait(0.1)
    selectdialog("Confirm")
end

task.spawn(function()
    while task.wait() do
        if questFrameLabel.RichText then questFrameLabel.RichText = false end
        if string.find(questFrameLabel.Text, "rgb%(255, 255, 0%)") then
            selectdialog("Bye")
            if autonext then task.wait(0.25)
                checkquest(); task.wait(0.5)
                getquest()
            else task.wait(0.25)
                getquest(curquestlvl)
            end
        end
    end
end)

local owner = "dimasikprofi4"
game.Players:WaitForChild(owner).Chatted:Connect(function(text)
    if text == "cancel" then
        cancelquest:FireServer()
    elseif text == "here" then
        lp.Character.PrimaryPart.CFrame = game.Players[owner].Character.PrimaryPart.CFrame
    elseif text == "party" then
        for i,v in pairs(add.get_friends(game.Players[owner])) do invite:FireServer(v.Name) end
        invite:FireServer(owner)
    elseif string.sub(text,1,1) == "p" and game.Players:FindFirstChild(string.sub(text,3)) then
        invite:FireServer(string.sub(text, 3))
    elseif string.sub(text,1,1) == "k" and game.Players:FindFirstChild(string.sub(text,3)) then
        kick:FireServer(string.sub(text, 3))
    elseif text == "db" then
        disband:FireServer()
    elseif text == "ant" then
        autonext = not autonext
    elseif text == "r" then
        selectdialog("Bye")
        task.wait(0.25)
        checkquest()
        task.wait(0.5)
        getquest()
    elseif add.int(text) then
        curquestlvl = add.int(text)
        checkquest(curquestlvl)
        task.wait(0.5)
        getquest(curquestlvl)
    end
end)
rs.Knit.Services.serverInputService.RE.TryEnableSafeMode:FireServer()