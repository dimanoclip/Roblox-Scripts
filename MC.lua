-- https://www.roblox.com/games/13645439359
local PlaceId = 13645439359
if game.PlaceId ~= PlaceId then warn(string.format("Wrong game detected. %s expected, got %s", PlaceId, game.PlaceId)) return end
-- Ebanina
local conv = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/convs.lua"))()
game.Players.LocalPlayer.Idled:Connect(function() game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end)
while true do task.wait()
    pcall(function()
        if game.Players.LocalPlayer.Character:FindFirstChild("Meditate") ~= nil then
            local qi = game.Players.LocalPlayer.DataValues.QI.Value
            task.wait(1)
            if qi == game.Players.LocalPlayer.DataValues.QI.Value and game.Players.LocalPlayer.Character:FindFirstChild("Meditate") ~= nil then
                game.Players.LocalPlayer.Character:FindFirstChild("Meditate"):Activate()
            end
            for i,v in pairs(game.Players.LocalPlayer.Backpack:children()) do
                if v.Name == "Low Quality Qi Pill" then
                    v.Parent = game.Players.LocalPlayer.Character; task.wait()
                    game.Players.LocalPlayer.Character:FindFirstChild(v.Name):Activate()
                end
                task.wait(0.25)
            end
        end
        for i,v in pairs(game.Players.LocalPlayer.Backpack:children()) do
            if v.Name == "Silver Sack" then
                v.Parent = game.Players.LocalPlayer.Character; task.wait()
                game.Players.LocalPlayer.Character:FindFirstChild(v.Name):Activate()
            end
            task.wait(0.25)
        end
        if conv.Round(game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health) <= conv.Round(game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").MaxHealth/2) then
            repeat
            game.Players.LocalPlayer.Backpack:FindFirstChild("Bread").Parent = game.Players.LocalPlayer.Character; task.wait()
            game.Players.LocalPlayer.Character:FindFirstChild("Bread"):Activate()
            task.wait(0.25)
            until conv.Round(game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health) > conv.Round(game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").MaxHealth/2)
        end
    end)
end
-- AutoTrinklets
game.UserInputService.InputBegan:connect(function(a,b)
    if a.KeyCode == Enum.KeyCode.F1 then
        local lastpos = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
        for i,v in pairs(game:GetService("Workspace").Interactables.Trinklet:children()) do
            if v:FindFirstChild("ProximityPrompt") ~= nil then
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v.CFrame
                task.wait(4)
            end
        end
        game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = lastpos
    end
end)
-- Noclip
for i,v in pairs(game.Players.LocalPlayer.Character:children()) do
    if v:IsA("BasePart") then
        v.CanCollide = true
    end
end
-- Farm Bandits
local lastpos = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
for _,Mob in pairs(game:GetService("Workspace").Mobs:children()) do
    if string.find(Mob.Name, "Dwarf") then
        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):UnequipTools()
        local Hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local EHrp = Mob:FindFirstChild("HumanoidRootPart")
        pcall(function()
            while Mob:FindFirstChild("Humanoid").Health > 0 do task.wait(0.25)
                if Mob:FindFirstChild("Humanoid").Health <= 0 then break end
                pcall(function() game.Players.LocalPlayer.Backpack:FindFirstChild("Combat").Parent = game.Players.LocalPlayer.Character end)
                Hrp.CFrame = CFrame.new(EHrp.Position - EHrp.CFrame.LookVector * 4, EHrp.Position)
                Hrp.Velocity = Vector3.new(0,0,0)
                game.Players.LocalPlayer.Character:FindFirstChild("Combat"):Activate()
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Combat"):WaitForChild("M2"):FireServer()
            end
        end)
    end
end
game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0,0,0)
game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = lastpos
-- Getting Info
local conv = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/convs.lua"))()
for i,v in pairs(game.Players:children()) do
    if v.Name ~= game.Players.LocalPlayer.Name then
        local dist = math.floor(((game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")).Position - v.Character:FindFirstChild("HumanoidRootPart").Position).magnitude)
        if dist <= 20 then
            print(v.Name.."("..dist.."m)"..": \n")
            print("HP: "..conv.ToLetters(v.Character:FindFirstChild("Humanoid").Health).."/"..conv.ToLetters(v.Character:FindFirstChild("Humanoid").MaxHealth).." ¦ QI: "..conv.ToLetters(v.DataValues.QI.Value).." ¦ Realm: "..v.DataValues.Realm.Value.." "..v.DataValues.RealmRank.Value)
        end
    end
end
-- Getting Info v2
local conv = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/convs.lua"))()
local SG = game.CoreGui:FindFirstChild("UselessGui") or Instance.new("ScreenGui", game.CoreGui)
SG.Name = "UselessGui"
SG.DisplayOrder = 10
SG.ResetOnSpawn = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local Frame = SG:FindFirstChild("PlayersStats") or Instance.new("Frame", SG)
Frame.Name = "PlayersStats"
Frame.AutoLocalize = false
Frame.BackgroundColor3 = Color3.fromRGB(60,60,60)
Frame.BackgroundTransparency = 0.4
Frame.Position = UDim2.fromOffset(20, 450)
while game.CoreGui:FindFirstChild("UselessGui") ~= nil do
    local gap = 3
    Frame:ClearAllChildren()
    Frame.Size = UDim2.new(0, 400, 0, 25)
    pcall(function()
        for i,v in pairs(game.Players:children()) do
            if v.Name ~= game.Players.LocalPlayer.Name then
                local dist = math.floor(((game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")).Position - v.Character:FindFirstChild("HumanoidRootPart").Position).magnitude)
                if dist <= 50 then
                    if i > 1 then Frame.Size = UDim2.fromOffset(Frame.AbsoluteSize.X, Frame.AbsoluteSize.Y+25) end
                    local Test = Instance.new("TextLabel", Frame)
                    Test.Text = ("〔"..v.DataValues.Race.Value.." ¦ "..v.DataValues.Aptitude.Value.."〕 "..v.DisplayName.." 〔"..dist.."m〕"..":\n".."HP: "..conv.ToLetters(v.Character:FindFirstChild("Humanoid").Health).."/"..conv.ToLetters(v.Character:FindFirstChild("Humanoid").MaxHealth).." ¦ QI: "..conv.ToLetters(v.DataValues.QI.Value).." ¦ Realm: "..v.DataValues.Realm.Value.." "..v.DataValues.RealmRank.Value)
                    Test.TextColor3 = Color3.new(1, 1, 1)
                    Test.BackgroundTransparency = 1
                    Test.Size = UDim2.fromOffset(Frame.AbsoluteSize.X, 25)
                    Test.Position = UDim2.fromOffset(0, gap)
                    Test.TextWrapped = true
                    Test.TextScaled = true
                    gap += 25
                    Test.InputBegan:connect(function(a,b)
                        if a.UserInputType == Enum.UserInputType.MouseButton1 then
                            setclipboard(v.DisplayName) 
                        end
                    end)
                end
            end
        end
    end)
    task.wait(0.5)
end