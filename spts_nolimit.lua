local Players = game:GetService("Players")
local Local = Players.LocalPlayer
local char = Local.Character or Local.CharacterAdded
local event = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent")
Local.CharacterAdded:Connect(function(character) char = character end)
_G.FSlvl = 23
_G.BTlvl = 29
_G.PPlvl = 20
while true do task.wait(0.5)
    spawn(function()
        if char and char:FindFirstChild("Humanoid").Health <= 0 then return end
        spawn(function()
            for i1=1,10 do
                if char:FindFirstChild("Humanoid").Health <= 0 then break end
                event:FireServer({"+FS".._G.FSlvl})
                event:FireServer({"+BT".._G.BTlvl})
                event:FireServer({"+PP".._G.PPlvl})
                task.wait(0.3)
            end
        end)
    end)
end
