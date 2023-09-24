-- https://www.roblox.com/games/6461766546
if not game:IsLoaded() then game.Loaded:Wait() end
local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local SettingsLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/SaveSettingsLibrary.lua"))()
local InputLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/InputFunctions%20Library.lua"))()
local msg = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/messages.lua"))()
msg.Notify("Welcome", "Thank you for using my script.\nGood luck and have fun!", 5)
local Players = game.Players
local Player = Players.LocalPlayer
local PG = Player.PlayerGui
local SG = nil
if PG:FindFirstChild("Useless Gui") == nil then SG = Instance.new("ScreenGui", PG); SG.Name = "Useless Gui"; task.wait(0.5)
else PG:FindFirstChild("Useless Gui").DeathNoteGui.DeathVictim.Text = Player.Name; PG:FindFirstChild("Useless Gui"):Remove(); SG = Instance.new("ScreenGui", PG); SG.Name = "Useless Gui" end
local FileName = "AHeroDestiny.CRAB"
local SettingsTable = SettingsLibrary.LoadSettings(FileName)
local bb=game:service'VirtualUser'
Player.Idled:connect(function()
bb:CaptureController()bb:ClickButton2(Vector2.new())
end)

local function CreateDN()
    local TB = Instance.new("TextButton", SG)
    local DN = Instance.new("Frame", SG)
    TB.Name = "DeathNote"
    TB.AutoButtonColor = false
    TB.Size = UDim2.new(0, 163.2, 0, 39.28)
    TB.Position = UDim2.new(0, 0, 0, 540,1)
    TB.BorderColor3 = Color3.fromRGB(27, 42, 53)
    TB.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
    --------------------------------------------------
    DN.Name = "DeathNoteGui"
    DN.Size = UDim2.new(0, 163.2, 0, 39.28)
    DN.Position = UDim2.fromOffset(181, 540)
    DN.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
    DN.Visible = false
    --------------------------------------------------
    for i=1,2 do
        local FR = Instance.new("Frame", TB)
        FR.Name = "Shadow"
        if i == 1 then FR.Position = UDim2.new(0, 0, 0, 8); FR.Size = UDim2.new(0, 163.2, 0, 31); FR.BackgroundColor3 = Color3.fromRGB(45, 45, 45) elseif i == 2 then FR.Position = UDim2.new(0, 0, 0, 32); FR.Size = UDim2.new(0, 163.2, 0, 8);  FR.BackgroundColor3 = Color3.fromRGB(40, 40, 40) end
        FR.BorderSizePixel = 0
    end
    local BT = Instance.new("TextLabel", TB)
    BT.TextColor = BrickColor.new(255, 255, 255)
    BT.Text = "DEATHNOTE"
    BT.TextSize = 14
    BT.TextScaled = true
    BT.TextWrapped = true
    BT.BackgroundTransparency = 1
    BT.BorderColor3 = Color3.fromRGB(27, 42, 53)
    BT.BorderSizePixel = 1
    BT.Size = UDim2.new(1, 0, 1, 0)
    BT.Position = UDim2.new(0, 0, 0, 2)
    local DV = Instance.new("TextBox", DN)
    DV.Name = "DeathVictim"
    DV.Size = UDim2.new(1, 0, 1, 0)
    DV.BackgroundTransparency = 1
    DV.TextColor3 = Color3.fromRGB(255, 255, 255)
    DV.TextWrapped = true
    DV.TextScaled = true
    DV.PlaceholderText = "Enter Nick Here"
    DV.Text = game.Players.LocalPlayer.Name
    TB.MouseButton1Click:connect(function()
        DN.Visible = not DN.Visible
    end)
    TB.MouseButton2Click:connect(function()
        DV.Text = Player.Name
        SG:Remove()
    end)
end
CreateDN()
local UZ = Instance.new("Part", game.workspace)
UZ.Name = "UselessZone"
UZ.Position = Vector3.new(0, -300, 0)
UZ.Size = Vector3.new(10, 1, 10)
UZ.Anchored = true

local function DestroyQuests()
    for _, Folder in pairs(game.Players.LocalPlayer:GetChildren()) do
        if Folder:IsA("Folder") and (Folder.Name == "Quest") then
            Folder:Destroy()
        end
    end
end

local function RemoteAttack(Number, AttackPosition)
    if Player.Stats.Class.Value == "Angel" then
        Player.Stats.Class.Value = "Puri Puri"
    end
    if Player.Stats.Class.Value == "Toxin" then
        Player.Stats.Class.Value = "Broly"
    end
    local ClassString = string.gsub(Player.Stats.Class.Value, " ", "")
    local AttackArg = ClassString.."Attack"..tostring(Number)
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(AttackArg, AttackPosition)
end

local function DistAttack(pos)
    if Player.Stats.Class.Value == "Limitless" then local dist = math.floor(((game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")).Position - pos).magnitude)
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("LimitlessAttack5", pos)
    elseif Player.Stats.Class.Value == "Cosmic" then
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("CosmicAttack1", pos)
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("CosmicAttack2", pos)
    elseif Player.Stats.Class.Value == "Blast" then
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("BlastAttack2", pos)
    end
end

local Useless = Material.Load({
	Title = "A Hero Dentiny",
	Style = 1,
	SizeX = 500,
	SizeY = 350,
	Theme = "Mocha",
})

local AutoFarmTab = Useless.New({
	Title = "Farm"
})
 
AutoFarmTab.Toggle({
    Text = "AutoHP",
    Callback = function(Value)
        SettingsTable.AutoHP = Value
        coroutine.wrap(function()
            while SettingsTable.AutoHP do task.wait()
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer("UpgradeHealth", 100000000)
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer("UpgradeHealth", 10000000)
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer("UpgradeHealth", 1000000)
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer("UpgradeHealth", 100000)
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer("UpgradeHealth", 10000)
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer("UpgradeHealth", 1000)
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer("UpgradeHealth", 100)
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer("UpgradeHealth", 10)
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer("UpgradeHealth", 3)
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer("UpgradeHealth", 1)
            end
        end)()
    end,
    Enabled = SettingsTable.AutoHP
})


 
local BossTable = {}
AutoFarmTab.Toggle({
    Text = "AutoFarm",
    Callback = function(Value)
        SettingsTable.AutoFarm = Value
        if Player.Character:FindFirstChild("Form") and (Player.Character.Form.Value == "") then
            RemoteAttack(6)
        end
        coroutine.wrap(function()
            while SettingsTable.AutoFarm do task.wait()
                for i, v in pairs(BossTable) do
                    if v and SettingsTable.AutoFarm then
                        local Npc = workspace.Spawns:FindFirstChild(i):FindFirstChild(i)
                        if Npc and Npc:FindFirstChild("Humanoid") and not (Npc.Humanoid.Health == 0) then
                            for i1, v1 in pairs(require(game:GetService("ReplicatedStorage").Modules.Quests)) do
                                if v1.Target == i then
                                    for _, Folder in pairs(Player:GetChildren()) do
                                        if Folder:IsA("Folder") and (Folder.Name == "Quest") then
                                            Folder:Destroy()
                                        end
                                    end
                                    game:GetService("ReplicatedStorage").RemoteEvent:FireServer("GetQuest", i1)
                                    Player:WaitForChild("Quest")
                                    break
                                end
                            end
                            local EHum = Npc:WaitForChild("Humanoid")
                            local EHrp = Npc:WaitForChild("HumanoidRootPart")
                            while SettingsTable.AutoFarm do task.wait()
                                local Char = Player.Character or Player.CharacterAdded:Wait()
                                local Hrp = Char:WaitForChild("HumanoidRootPart")
                                if EHum.Health == 0 then
                                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer("PurchaseSpinAll")
                                    break
                                end
                                Hrp.CFrame = CFrame.new(EHrp.Position - EHrp.CFrame.LookVector * 3, EHrp.Position)
                                InputLibrary.CenterMouseClick()
                                for Number=1, 5 do
                                    RemoteAttack(Number, EHrp.Position)
                                end
                            end
                        end
                    end
                end
            end
        end)()
    end,
    Enabled = SettingsTable.AutoFarm
})

AutoFarmTab.Toggle({
    Text = "GodFarm",
    Callback = function(Value)
        SettingsTable.GodFarm = Value
        coroutine.wrap(function()
            while SettingsTable.GodFarm do task.wait()
                if game.workspace.Spawns.God:FindFirstChild("God") ~= nil then
                    local targ = game.workspace.Spawns.God:FindFirstChild("God")
                    local targpos = targ.HumanoidRootPart.CFrame.Position
                    game:GetService("ReplicatedStorage").RemoteEvent:FireServer("GetQuest", 34)
                    if Player.Stats.StrengthFactor.Value >= 5000 and SettingsTable.GodFarm then
                        repeat task.wait(0.5)
                        DistAttack(targpos)
                        until targ:FindFirstChild("Humanoid") == nil
                        DestroyQuests()
                        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer("PurchaseSpinAll")
                        msg.Chat("God has been killed!", "Green")
                    elseif Player.Stats.StrengthFactor.Value >= 100 and Player.Stats.StrengthFactor.Value < 5000 and SettingsTable.GodFarm then
                        repeat task.wait(0.5)
                        Player.Character.HumanoidRootPart.CFrame = CFrame.new(6504, 1761.5, -855)
                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("LimitlessAttack2", targpos)
                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("LimitlessAttack5", targpos)
                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("LimitlessAttack3", targpos)
                        until targ:FindFirstChild("Humanoid").Health == 0
                        DestroyQuests()
                        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer("PurchaseSpinAll")
                        msg.Chat("God has been killed!", "Green")
                    end
                end
            end
        end)()
    end,
    Enabled = SettingsTable.GodFarm
})

AutoFarmTab.Toggle({
    Text = "AutoQuests",
    Callback = function(Value)
        SettingsTable.AutoQuests = Value
        coroutine.wrap(function()
            while SettingsTable.AutoQuests do task.wait()
                local targetname = nil
                local target = nil
                local targetrp = nil
                local lastpos = nil
                if not SettingsTable.GodFarm and not SettingsTable.AutoFarm then
                    for _, Folder in pairs(game.Players.LocalPlayer:GetChildren()) do
                        if Folder:IsA("Folder") and (Folder.Name == "Quest") then
                            targetname = Folder.Target.Value
                            target = game.workspace.Spawns[targetname]:WaitForChild(targetname)
                            targetrp = target:WaitForChild("HumanoidRootPart")
                            lastpos = Player.Character.HumanoidRootPart.CFrame.Position
                            repeat task.wait()
                                if SettingsTable.AutoQuests then
                                    Player.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(targetrp.Position - targetrp.CFrame.LookVector * 3, targetrp.Position)
                                    RemoteAttack(1, targetrp.Position)
                                    RemoteAttack(2, targetrp.Position)
                                    RemoteAttack(3, targetrp.Position)
                                    RemoteAttack(5, targetrp.Position)
                                else break end
                            until target:WaitForChild("Humanoid").Health == 0
                            Player.Character.HumanoidRootPart.CFrame = CFrame.new(lastpos)
                            msg.Chat(targetname.." has been killed!", "Green")
                            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer("PurchaseSpinAll")
                            DestroyQuests()
                        end
                    end
                end
            end
        end)()
    end,
    Enabled = SettingsTable.AutoQuests
})
---------------------------------------------------------------------------------------
local btime = Instance.new("TextLabel", SG)
btime.Name = "QTime"
btime.BackgroundColor3 = Color3.new(0, 0, 0)
btime.BackgroundTransparency = 0.500
btime.Position = UDim2.new(0, 268, 0, 286)
btime.Size = UDim2.new(0, 125, 0, 47)
btime.Font = Enum.Font.SourceSansSemibold
btime.TextColor3 = Color3.fromRGB(255, 255, 255)
btime.TextScaled = true
btime.TextSize = 14.000
btime.TextWrapped = true
btime.Visible = false
---------------------------------------------------------------------------------------
for i, v in pairs(require(game:GetService("ReplicatedStorage").Modules.Quests)) do
    if v.Amount == 1 then
        BossTable[v.Target] = false
    end
end

if SettingsTable.SavedTable then
    for i, v in pairs(BossTable) do
        if not SettingsTable.SavedTable[i] then
            SettingsTable.SavedTable[i] = false
        end
    end
else
    SettingsTable.SavedTable = BossTable
end
 
AutoFarmTab.DataTable({
	Text = "Chipping away",
	Callback = function(ChipSet)
        for i, v in pairs(ChipSet) do
            BossTable[i] = v
            SettingsTable.SavedTable[i] = v
        end
	end,
	Options = SettingsTable.SavedTable
})
 
local SpinTab = Useless.New({
	Title = "Spins"
})

local SpinTable = {}
local SpinToggle = nil
SpinToggle = SpinTab.Toggle({
	Text = "AutoSpin",
	Callback = function(Value)
		SettingsTable.AutoSpin = Value
        coroutine.wrap(function()
            while SettingsTable.AutoSpin do task.wait()
                game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer()
                for i, v in pairs(SpinTable) do
                    if SpinTable[Player.Stats.Class.Value] then
                        SpinToggle:SetState(false)
                        break
                    end
                end
            end
        end)()
	end,
	Enabled = SettingsTable.AutoSpin
})
 
for i, v in pairs(require(game:GetService("ReplicatedStorage").Modules.Classes).Lucky) do
    SpinTable[v.Item] = false
end
 
SpinTab.DataTable({
	Text = "Chipping away",
	Callback = function(ChipSet)
        for i, v in pairs(ChipSet) do
            SpinTable[i] = v
        end
	end,
	Options = SpinTable
})

local Quests = Useless.New({
    Title = "Quests"
})
local choosen = {}
choosen.State = false
choosen.Target = nil
choosen.Index = nil
Quests.Toggle({
    Text = "Loop",
    Callback = function(Value) if Value then SettingsTable.QuestLoop = Value elseif not Value then task.wait(0.5) choosen.Target = nil; choosen.Index = nil; SettingsTable.QuestLoop = Value end end,
    Enabled = SettingsTable.QuestLoop
})
for i,v in pairs(require(game:GetService("ReplicatedStorage").Modules.Quests)) do
    if v.Amount == 1 then
        Quests.Button({
            Text = i.." | The "..v.Target.."",
            Callback = function()
                pcall(function()
                    choosen.State = false
                    if choosen.State == false then
                        DestroyQuests()
                        task.wait(0.5)
                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("GetQuest", i)
                        if not SettingsTable.AutoQuests then choosen.State = true
                            repeat task.wait(0.5)
                                if not choosen.State then break end
                                DistAttack(game.workspace.Spawns[v.Target]:WaitForChild(v.Target).HumanoidRootPart.Position)
                            until game.workspace.Spawns[v.Target]:WaitForChild(v.Target).Humanoid.Health == 0
                            msg.Chat(v.Target.." has been killed!", "Green")
                            DestroyQuests()
                            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer("PurchaseSpinAll")
                            choosen.State = false
                        end
                        choosen.Target = v.Target
                        choosen.Index = i
                    end
                end)
            end,
        })
    else
        Quests.Button({
            Text = i.." | "..v.Target.."s",
            Callback = function()
                pcall(function()
                    choosen.State = false
                    if choosen.State == false then
                        DestroyQuests()
                        task.wait(0.5)
                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("GetQuest", i)
                        if not SettingsTable.AutoQuests then choosen.State = true
                            repeat task.wait(0.5)
                                if not choosen.State then break end
                                DistAttack(game.workspace.Spawns[v.Target]:WaitForChild(v.Target).HumanoidRootPart.Position)
                            until game.workspace.Spawns[v.Target]:WaitForChild(v.Target).Humanoid.Health == 0
                            msg.Chat(v.Target.." has been killed!", "Green")
                            DestroyQuests()
                            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer("PurchaseSpinAll")
                            choosen.State = false
                        end
                        choosen.Target = v.Target
                        choosen.Index = i
                    end
                end)
            end,
        })
    end
end

game.Players.PlayerRemoving:Connect(function(PlayerRemoving)
    if PlayerRemoving == Player then
        SettingsLibrary.SaveSettings(FileName, SettingsTable)
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    local targettime = nil
    if SettingsTable.QuestLoop then if choosen.Index ~= nil then game:GetService("ReplicatedStorage").RemoteEvent:FireServer("GetQuest", choosen.Index) end end
    pcall(function() if SG:FindFirstChild("DeathNoteGui").DeathVictim.Text ~= Player.Name and SG:FindFirstChild("DeathNoteGui").DeathVictim.Text ~= "" and PG:FindFirstChild("Useless Gui") ~= nil then 
        if Players:FindFirstChild(SG:FindFirstChild("DeathNoteGui").DeathVictim.Text) ~= nil and Players:FindFirstChild(SG:FindFirstChild("DeathNoteGui").DeathVictim.Text).Character:FindFirstChild("ForceField") == nil and Players:FindFirstChild(SG:FindFirstChild("DeathNoteGui").DeathVictim.Text).Character:FindFirstChild("Health") ~= nil and Players:FindFirstChild(SG:FindFirstChild("DeathNoteGui").DeathVictim.Text).Character.Health ~= 0 then
            DistAttack(Players[SG:FindFirstChild("DeathNoteGui").DeathVictim.Text].Character.HumanoidRootPart.CFrame.Position)
        end
    end end)
    if not SettingsTable.GodFarm and not SettingsTable.AutoFarm then
        for _, Folder in pairs(game.Players.LocalPlayer:GetChildren()) do
            if Folder:IsA("Folder") and (Folder.Name == "Quest") and Folder.Goal.Value == 1 then
                btime.Visible = true
                targettime = game.Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui").RespawnTimes:WaitForChild(Folder.Target.Value).TextLabel.Text:gsub(" ", "")
                if targettime == "0:00" or targettime == "5:00" then btime.Text = "Alive"
                else btime.Text = targettime end
            else btime.Visible = false
            end
        end
    else btime.Visible = false
    end
end)

game:GetService("UserInputService").InputBegan:connect(function(a,b)
    if a.KeyCode==Enum.KeyCode.F1 then if Player.Character:FindFirstChild("HumanoidRootPart") ~= nil then local UZP = game.workspace.UselessZone.Position
        if Player.Character.HumanoidRootPart.CFrame ~= CFrame.new(UZP.X,UZP.Y+3.5,UZP.Z) then Player.Character.HumanoidRootPart.CFrame = CFrame.new(UZP.X,UZP.Y+3.5,UZP.Z);Player.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0);Player.Character.HumanoidRootPart.Anchored = true
        else Player.Character.HumanoidRootPart.CFrame = game.workspace.Map.SpawnLocation.CFrame;Player.Character.HumanoidRootPart.Anchored = false end 
    end end
end)
--------------------------------------------------
Player.CharacterAdded:Connect(function()
    if PG:FindFirstChild("Useless Gui") == nil then SG = Instance.new("ScreenGui", PG); SG.Name = "Useless Gui"; task.wait(0.5); CreateDN()
    else PG:FindFirstChild("Useless Gui").DeathNoteGui.TextBox.Text = Player.Name; PG:FindFirstChild("Useless Gui"):Remove(); SG = Instance.new("ScreenGui", PG); SG.Name = "Useless Gui" end
    task.wait(1.5)
    RemoteAttack(6)
end)