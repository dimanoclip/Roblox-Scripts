-- https://www.roblox.com/games/12761410397
local PlaceId = 12761410397
if game.PlaceId ~= PlaceId then warn(string.format("Wrong game detected. %s expected, got %s", PlaceId, game.PlaceId)) return end
if _G.Working then _G.Working = false end task.wait(0.5) _G.Working = true
local workspace,players,replicatedStorage = game:GetService("Workspace"),game:GetService("Players"),game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local plyrp = character:WaitForChild("HumanoidRootPart")
local humanoid = localPlayer.Character:WaitForChild("Humanoid")
local PlayerGui = localPlayer:WaitForChild("PlayerGui")
local autofs,autobt,autopp,autows,autojf,farmingpp,autotp,savedpos,smode
if not character then return end
local vinp = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/vinp.lua"))()
local add = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/additional.lua"))()
localPlayer.Idled:Connect(function() game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end)
local function isPlayerOnMobile()
    return UserInputService.TouchEnabled and not (UserInputService.KeyboardEnabled or UserInputService.GamepadEnabled)
end
local RayfieldURL = isPlayerOnMobile() and 'https://raw.githubusercontent.com/Hosvile/Refinement/main/MC%3AArrayfield%20Library' or 'https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/rayfield.lua'
local Rayfield = loadstring(game:HttpGet(RayfieldURL))()
local Window = Rayfield:CreateWindow({
   Name = "SPTS:AU",
   LoadingTitle = "SPTS:AU",
   LoadingSubtitle = "Why not?",
})
local MainTab = Window:CreateTab("Main")
local function unalltools() humanoid:UnequipTools() end
local function equiptool(instance) if add.isexist(instance) then humanoid:EquipTool(instance) end end
local function collectquests()
    for _1,type in pairs({"Daily", "Weekly", "Monthly"}) do
        for _2,aim in pairs({"FistStrength", "BodyToughness", "PsychicPower","JumpForce","MovementSpeed"}) do
            for i=1,15 do task.wait() replicatedStorage.RemoteEvents.DailyQuestClaim:FireServer(i, aim, type)
    end end end
end

local AutoFarmsSection = MainTab:CreateSection("Grinding Stuff")
local AutoFist = MainTab:CreateToggle({
    Name = "Auto FS",
    CurrentValue = false,
    Flag = "AutoFSFlag",
    Callback = function(Value)
        unalltools()
        autofs = Value
    end,
})
local AutoBody = MainTab:CreateToggle({
    Name = "Auto BT",
    CurrentValue = false,
    Flag = "AutoBTFlag",
    Callback = function(Value)
        unalltools()
        autobt = Value
    end,
})
local AutoPP = MainTab:CreateToggle({
    Name = "Auto PS",
    CurrentValue = false,
    Flag = "AutoPPFlag",
    Callback = function(Value)
        unalltools()
        autopp = Value
    end,
})
local AutoMS = MainTab:CreateToggle({
    Name = "Auto MS",
    CurrentValue = false,
    Flag = "AutoWSFlag",
    Callback = function(Value)
        autows = Value
        while autows do task.wait()
            humanoid.WalkSpeed = 0.5
            vinp.PressKey(119, 0.25); humanoid.WalkSpeed = 0.5
            vinp.PressKey(97, 0.25); humanoid.WalkSpeed = 0.5
            vinp.PressKey(115, 0.25); humanoid.WalkSpeed = 0.5
            vinp.PressKey(100, 0.25); humanoid.WalkSpeed = 0.5
        end
    end,
})
local AutoJF = MainTab:CreateToggle({
    Name = "Auto JF",
    CurrentValue = false,
    Flag = "AutoJFFlag",
    Callback = function(Value)
        if Value then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
        task.wait(0.1);localPlayer.Character.PrimaryPart.Anchored = Value;task.wait()
        autojf = Value
        while autojf do task.wait(); replicatedStorage.RemoteEvents.Jumped:FireServer() end
    end,
})
local MiscSection = MainTab:CreateSection("Misc Stuff")
local SilentMode = MainTab:CreateToggle({
    Name = "Silent Farm",
    CurrentValue = false,
    Flag = "SilentModeFlag",
    Callback = function(Value)
        if Value then unalltools() elseif not Value then farmingpp = false unalltools() end
        smode = Value
    end,
})
local AutoTP = MainTab:CreateToggle({
    Name = "Return To Pos | Risky",
    CurrentValue = false,
    Flag = "AutoTPFlag",
    Callback = function(Value)
        savedpos = localPlayer.Character.PrimaryPart.CFrame
        autotp = Value
    end,
})
local AutoQuests = MainTab:CreateButton({
    Name = "Collect quests",
    Callback = function()
        collectquests()
    end,
})
local AutoMulti = MainTab:CreateDropdown({
    Name = "Auto Upgrade",
    Options = {"Off","FistStrength","BodyToughness","MovementSpeed","JumpForce","PsychicPower"},
    CurrentOption = {"Off"},
    MultipleOptions = false,
    Flag = "AutoUpgradeFlag",
})
collectquests()

task.spawn(function()
    while _G.Working do task.wait()
        if game:GetService("Lighting").Blur.Enabled == true then game:GetService("Lighting").Blur.Enabled = false end
        if autotp then
            localPlayer.Character:WaitForChild("HumanoidRootPart")
            if humanoid.Health <= 0 then replicatedStorage.Respawn:FireServer() end task.wait()
            if PlayerGui.PlayScreen.Enabled ~= false then PlayerGui.PlayScreen.Enabled = false end
            if plyrp.CFrame ~= savedpos then plyrp.CFrame = savedpos plyrp.Velocity = Vector3.new(0,0,0) end
        end
        if AutoMulti.CurrentOption[1] ~= "Off" then
            replicatedStorage.RemoteEvents.UpgradeMultiplier:FireServer(AutoMulti.CurrentOption[1])
        end
        if autofs then
            replicatedStorage.RemoteEvents.FistStrength:FireServer()
            if not smode then
                equiptool(localPlayer.Backpack:FindFirstChild("FistStrength"))
                localPlayer.Character:FindFirstChild("FistStrength"):Activate()
            end
        end
        if autobt then
            replicatedStorage.RemoteEvents.Pushup:FireServer()
            if not smode then
                equiptool(localPlayer.Backpack:FindFirstChild("BodyToughness"))
                localPlayer.Character:FindFirstChild("BodyToughness"):Activate()
            end
        end
        if autopp then
            if not smode then
                equiptool(localPlayer.Backpack:FindFirstChild("PsychicPower"))
            else
                if not farmingpp then
                    replicatedStorage.RemoteEvents.TrainPsychic:FireServer(true)
                    farmingpp = true
                end
            end
        end
    end
end)
game.UserInputService.InputBegan:Connect(function(a,b)
    if not add.dontmoving(humanoid) and farmingpp then
        replicatedStorage.RemoteEvents.TrainPsychic:FireServer(false)
        farmingpp = false
    end
end)