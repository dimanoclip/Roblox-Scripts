local add = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/additional.lua"))()
add.aa()
local Players = game:GetService("Players")
local Local = Players.LocalPlayer
local char = Local.Character or Local.CharacterAdded:Wait()
local event = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent")
local swordevent = game:GetService("ReplicatedStorage"):WaitForChild("SwordRemote")

Local.CharacterAdded:Connect(function(character) char = character end)
_G.State = true
_G.FSlvl = 23
_G.BTlvl = 29
_G.MSlvl = 20
_G.JFlvl = 20
_G.PPlvl = 20
while true do task.wait(0.3)
    task.spawn(function()
        if (char and char:FindFirstChild("Humanoid") and char:FindFirstChild("Humanoid").Health <= 0) or not _G.State then return end
        task.spawn(function()
            for i=1,10 do
                if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("Humanoid").Health <= 0 then break end
                event:FireServer({"+FS".._G.FSlvl})
                event:FireServer({"+BT".._G.BTlvl})
                event:FireServer({"+MS".._G.MSlvl})
                event:FireServer({"+JF".._G.JFlvl})
                event:FireServer({"+PP".._G.PPlvl})
                swordevent:FireServer(Local)
                task.wait(0.25)
            end
        end)
    end)
end

local codes = {"NoLimitLove", "SWORDIE!", "FinalUpdate"}
for code in codes do
    game:GetService("ReplicatedStorage"):WaitForChild("Redeem"):FireServer(code)
end
