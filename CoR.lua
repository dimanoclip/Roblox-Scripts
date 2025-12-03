-- https://www.roblox.com/games/11634325399
local PlaceId = 11634325399
if game.PlaceId ~= PlaceId then warn(string.format("Wrong game detected. %s expected, got %s", PlaceId, game.PlaceId)) return end
-- Some Features
local conv = loadstring(game:HttpGet("https://raw.githubusercontent.com/dimanoclip/1/main/convs.lua"))()
game.Players.LocalPlayer.Idled:connect(function() game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end)
while true do task.wait(0.5)
game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso"):FindFirstChild("BillboardGui").TextLabel.Text = conv.ToLetters(game.Players.LocalPlayer.leaderstats.Level.Value)
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Trascendence"):FireServer()
end
-- Farm Cultivators
local lastpos = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
for _,Mob in pairs(game:GetService("Workspace").Dummies:children()) do
    if string.find(Mob.Name, "Cultivator") then
        local Hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local EHrp = Mob:FindFirstChild("HumanoidRootPart")
        game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso"):FindFirstChild("Ring2").Hinge1.Enabled = false
        while Mob:FindFirstChild("Humanoid").Health > 0 do task.wait()
        	if Mob:FindFirstChild("Humanoid").Health <= 0 then break end
            Hrp.CFrame = CFrame.new(EHrp.Position - EHrp.CFrame.LookVector * 3, EHrp.Position)
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PunchEvent"):FireServer()
        end
    end
end
game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = lastpos
game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso"):FindFirstChild("Ring2").Hinge1.Enabled = true
-- Alive Weapon
local pp = game.Players
local player = pp.LocalPlayer
local giver = pp["craypower12"] -- change weapon owner's name here
local cmd = "kill" -- command to use weapon

giver.Chatted:Connect(function(msg)
    local lastpos = player.Character:FindFirstChild("HumanoidRootPart").CFrame
    if msg:sub(1, cmd:len()):lower() == cmd:lower() then
        local target = msg:sub(cmd:len() + 2)
        if target ~= player.Name then
            local pt = pp[target]
            local Hrp = player.Character:FindFirstChild("HumanoidRootPart")
            local EHrp = pt.Character:FindFirstChild("HumanoidRootPart")
            while pt.Character:FindFirstChild("Humanoid").Health > 0 do task.wait()
                if pt.Character:FindFirstChild("Humanoid").Health <= 0 then break end
                Hrp.CFrame = CFrame.new(EHrp.Position - EHrp.CFrame.LookVector * 3, EHrp.Position)
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PunchEvent"):FireServer()
            end
            player.Character:FindFirstChild("HumanoidRootPart").CFrame = lastpos
        end
    end
end)

