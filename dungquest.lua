local inp = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/vinp.lua"))()
local add = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/additional.lua"))()
local key = inp.PressKey
local plys = game.Players
local lp = plys.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
lp.CharacterAdded:Connect(function(character) char = character end)
local rs = game:GetService("ReplicatedStorage")
local chatevent = rs:WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
local spawn = task.spawn
local pgui = lp.PlayerGui
local abils = pgui.abilities.Frame
local skill1 = abils.LeftAbility
local skill2 = abils.RightAbility
local lastpos = char:FindFirstChild("HumanoidRootPart").CFrame
local cmds = {
    ["heal 1"] = function(target) if add.is_alive(target) then char:FindFirstChild("HumanoidRootPart").CFrame = target.Character:WaitForChild("HumanoidRootPart").CFrame; key(Enum.KeyCode.Q); task.wait(15); char:FindFirstChild("HumanoidRootPart").CFrame = lastpos end end,
    ["heal 2"] = function(target) if add.is_alive(target) then char:FindFirstChild("HumanoidRootPart").CFrame = target.Character:WaitForChild("HumanoidRootPart").CFrame; key(Enum.KeyCode.E); task.wait(15); char:FindFirstChild("HumanoidRootPart").CFrame = lastpos end end
}
spawn(function()
    plys:WaitForChild("makasgamer20").Chatted:Connect(function(msg, targ)
        local askedply = plys["makasgamer20"]
        if string.find(msg, "/w ighf8yu5g ") then msg = string.sub(msg, #"/w ighf8yu5g "+2) end
        print(msg)
        for cmd, callback in pairs(cmds) do
            if msg == cmd then callback(askedply) end
        end
    end)
end)
spawn(function()
    plys:WaitForChild("dimasikprofi4").Chatted:Connect(function(msg, targ)
        local askedply = plys["dimasikprofi4"]
        if string.find(msg, "/w ighf8yu5g ") then msg = string.sub(msg, #"/w ighf8yu5g "+2) end
        print(msg)
        for cmd, callback in pairs(cmds) do
            if msg == cmd then callback(askedply) end
        end
    end)
end)
queue_on_teleport('loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Dimanoname/Roblox-Scripts/main/dungquest.lua"))()')
print("Everything loaded")