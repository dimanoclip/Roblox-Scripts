-- https://www.roblox.com/games/12761410397
local workspace = game:GetService("Workspace")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local PlayerGui = localPlayer:WaitForChild("PlayerGui")
local autofs,autobt,autopp,farmingpp,autows,autojf,autotp,savepos = false,false,false,false,false,false,false,nil
localPlayer.Idled:Connect(function() game.VirtualUser:CaptureController(); game.VirtualUser:ClickButton2(Vector2.new()) end)


local function isPlayerOnMobile()
    return UserInputService.TouchEnabled and not (UserInputService.KeyboardEnabled or UserInputService.GamepadEnabled)
end

local RayfieldURL = isPlayerOnMobile() and
                    'https://raw.githubusercontent.com/Hosvile/Refinement/main/MC%3AArrayfield%20Library' or
                    'https://sirius.menu/rayfield'

local Rayfield = loadstring(game:HttpGet(RayfieldURL))()


local Window = Rayfield:CreateWindow({
   Name = "SPTS:AU",
   LoadingTitle = "SPTS:AU",
   LoadingSubtitle = "Why not?",
})

local MainTab = Window:CreateTab("Main")

if character then else return end

local function notify(title, content, duration)
    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = duration or 0.7,
        Image = 10010348543
    })
end
local function sendmsg(text:string)
    character.PrimaryPart.Anchored = true; character.PrimaryPart.Velocity = Vector3.new(0,0,0)
    task.wait(1)
    replicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(text, "All")
    character.PrimaryPart.Anchored = false
end


local AutoFarmsSection = MainTab:CreateSection("Auto Farms")
local AutoFist = MainTab:CreateToggle({
    Name = "Auto Fist Strength",
    CurrentValue = false,
    Flag = "AutoFSFlag",
    Callback = function(Value)
        autofs = Value
    end,
})
local AutoBody = MainTab:CreateToggle({
    Name = "Auto Body Toughness",
    CurrentValue = false,
    Flag = "AutoBTFlag",
    Callback = function(Value)
        autobt = Value
    end,
})
local AutoPP = MainTab:CreateToggle({
    Name = "Auto Psychic Power",
    CurrentValue = false,
    Flag = "AutoPPFlag",
    Callback = function(Value)
        autopp = Value
    end,
})

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
    while task.wait() do
        if autofs then
            replicatedStorage.RemoteEvents.FistStrength:FireServer()
        end
        if autobt then
            replicatedStorage.RemoteEvents.Pushup:FireServer()
        end
        if farmingpp == false and autopp then
            replicatedStorage.RemoteEvents.TrainPsychic:FireServer(true)
            farmingpp = true
        end
    end
end)
game.UserInputService.InputBegan:Connect(function(a,b)
    if a.KeyCode == Enum.KeyCode.W or a.KeyCode == Enum.KeyCode.A or a.KeyCode == Enum.KeyCode.S or a.KeyCode == Enum.KeyCode.D or a.KeyCode == Enum.KeyCode.Space then
        replicatedStorage.RemoteEvents.TrainPsychic:FireServer(false)
        farmingpp = false
    end
end)