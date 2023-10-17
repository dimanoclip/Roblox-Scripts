-- https://www.roblox.com/games/12761410397
local PlaceId = 12761410397
if game.PlaceId ~= PlaceId then warn(string.format("Wrong game detected. %s expected, got %s", PlaceId, game.PlaceId)) return end
if _G.Working then _G.Working = false end task.wait(0.5) _G.Working = true
local workspace = game:GetService("Workspace")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = localPlayer.Character:WaitForChild("Humanoid")
local PlayerGui = localPlayer:WaitForChild("PlayerGui")
local autofs,autobt,autopp,autows,autojf,farmingpp,autotp,savedpos,smode
if character then else return end
local vinp = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/vinp.lua"))()
localPlayer.Idled:Connect(function() game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end)
local function isPlayerOnMobile()
    return UserInputService.TouchEnabled and not (UserInputService.KeyboardEnabled or UserInputService.GamepadEnabled)
end
local RayfieldURL = isPlayerOnMobile() and 'https://raw.githubusercontent.com/Hosvile/Refinement/main/MC%3AArrayfield%20Library' or 'https://sirius.menu/rayfield'
local Rayfield = loadstring(game:HttpGet(RayfieldURL))()
local Window = Rayfield:CreateWindow({
   Name = "SPTS:AU",
   LoadingTitle = "SPTS:AU",
   LoadingSubtitle = "Why not?",
})
local MainTab = Window:CreateTab("Main")
local function notify(title, content, duration)
    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = duration or 0.7,
        Image = 10010348543
    })
end
local function unalltools() for i,v in pairs(localPlayer.Character:GetChildren()) do if v:IsA("Tool") then v.Parent = localPlayer.Backpack end end end
local function collectquests()
    for _1,aim in pairs({"FistStrength", "BodyToughness", "PsychicPower","JumpForce","MovementSpeed"}) do
        for _2,type in pairs({"Daily", "Weekly", "Monthly"}) do
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
        if Value then humanoid.WalkSpeed = 0.5 end
        while autows do task.wait()
            vinp.PressKey(119, 0.25)
            vinp.PressKey(97, 0.25)
            vinp.PressKey(115, 0.25)
            vinp.PressKey(100, 0.25)
        end
    end,
})
local AutoJF = MainTab:CreateToggle({
    Name = "Auto JF",
    CurrentValue = false,
    Flag = "AutoJFFlag",
    Callback = function(Value)
        if Value then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end task.wait(0.1)
        localPlayer.Character.PrimaryPart.Anchored = Value
        task.wait()
        autojf = Value
        while autojf do
            replicatedStorage.RemoteEvents.Jumped:FireServer()
            task.wait(0.25)
        end
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
-- local KeyBinds = MainTab:CreateSection("KeyBinds")
-- local SpamParry = MainTab:CreateKeybind({
--     Name = "Spam Parry (Hold)",
--     CurrentKeybind = "E",
--     HoldToInteract = true,
--     Flag = "ToggleParrySpam",
--     Callback = function(Keybind)
--     end,
-- })
-- local ToggleParryKB = MainTab:CreateKeybind({
--    Name = "Toggle Parry (Bind)",
--    CurrentKeybind = "G",
--    HoldToInteract = false,
--    Flag = "ToggleParryKB",
--    Callback = function(Keybind)
--     AutoParryToggle:Set(not AutoParryToggle.CurrentValue)
--    end,
-- })

-- local Misc = MainTab:CreateSection("Misc")
-- local AutoVote = MainTab:CreateDropdown({
--     Name = "Auto Vote",
--     Options = {"ffa","2t","4t"},
--     CurrentOption = {"ffa"},
--     MultipleOptions = false,
--     Flag = "AutoVoteFlag",
--  })
-- local AutoGGToggle = MainTab:CreateToggle({
--     Name = "AutoGG",
--     CurrentValue = true,
--     Flag = "AutoGGFlag",
--     Callback = function(Value)
--         autogg = Value
--     end,
-- })

task.spawn(function()
    while _G.Working do task.wait()
        if game:GetService("Lighting").Blur.Enabled == true then game:GetService("Lighting").Blur.Enabled = false end
        if autotp then
            localPlayer.Character:WaitForChild("HumanoidRootPart")
            if humanoid.Health <= 0 then replicatedStorage.Respawn:FireServer() end task.wait()
            if PlayerGui.PlayScreen.Enabled ~= false then PlayerGui.PlayScreen.Enabled = false end
            if localPlayer.Character.PrimaryPart.CFrame ~= savedpos then localPlayer.Character:WaitForChild("HumanoidRootPart") localPlayer.Character.PrimaryPart.CFrame = savedpos localPlayer.Character.PrimaryPart.Velocity = Vector3.new(0,0,0) end
        end
        if AutoMulti.CurrentOption[1] ~= "Off" then
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("UpgradeMultiplier"):FireServer(AutoMulti.CurrentOption[1])
        end
        if autofs then
            replicatedStorage.RemoteEvents.FistStrength:FireServer()
            if not smode then
                if localPlayer.Backpack:FindFirstChild("FistStrength") then localPlayer.Backpack:FindFirstChild("FistStrength").Parent = localPlayer.Character end
                localPlayer.Character:FindFirstChild("FistStrength"):Activate()
            end
        end
        if autobt then
            replicatedStorage.RemoteEvents.Pushup:FireServer()
            if not smode then
                if localPlayer.Backpack:FindFirstChild("BodyToughness") then localPlayer.Backpack:FindFirstChild("BodyToughness").Parent = localPlayer.Character end
                localPlayer.Character:FindFirstChild("BodyToughness"):Activate()
            end
        end
        if autopp then
            if not smode then
                if localPlayer.Backpack:FindFirstChild("PsychicPower") then localPlayer.Backpack:FindFirstChild("PsychicPower").Parent = localPlayer.Character end
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
    if (a.KeyCode == Enum.KeyCode.W or a.KeyCode == Enum.KeyCode.A or a.KeyCode == Enum.KeyCode.S or a.KeyCode == Enum.KeyCode.D or a.KeyCode == Enum.KeyCode.Space) and farmingpp then
        replicatedStorage.RemoteEvents.TrainPsychic:FireServer(false)
        farmingpp = false
    end
end)