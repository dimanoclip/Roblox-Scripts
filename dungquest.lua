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
local abils = pgui:WaitForChild("abilities").Frame
local skill1 = abils:FindFirstChild("LeftAbility")
local skill2 = abils:FindFirstChild("RightAbility")
local lastpos = char:FindFirstChild("HumanoidRootPart").CFrame
local function chat_say(text, target)
    chatevent:FireServer(text, "To "..(target.Name or target))
end
local cmds = {
    ["heal 1"] = function(target) if add.is_alive(target) then spawn(function() char:FindFirstChild("HumanoidRootPart").CFrame = target.Character:WaitForChild("HumanoidRootPart").CFrame; task.wait(); key(Enum.KeyCode.Q); task.wait(11.5); char:FindFirstChild("HumanoidRootPart").CFrame = lastpos; chat_say("I'm ready!", target) end) end end,
    ["heal 2"] = function(target) if add.is_alive(target) then spawn(function() char:FindFirstChild("HumanoidRootPart").CFrame = target.Character:WaitForChild("HumanoidRootPart").CFrame; task.wait(); key(Enum.KeyCode.E); task.wait(11.5); char:FindFirstChild("HumanoidRootPart").CFrame = lastpos; chat_say("I'm ready!", target) end) end end
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
    plys:WaitForChild("makasgamer20").HealthChanged:Connect(function(health)
        local target = plys["makasgamer20"]
        local hum = target.Character:WaitForChild("Humanoid")
        if health <= hum.MaxHealth/2 then
            cmds["heal 2"](target)
        elseif health <= hum.MaxHealth/1.3 then
            cmds["heal 1"](target)
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
    plys:WaitForChild("dimasikprofi4").HealthChanged:Connect(function(health)
        local target = plys["dimasikprofi4"]
        local hum = target.Character:WaitForChild("Humanoid")
        if health <= hum.MaxHealth/2 then
            cmds["heal 2"](target)
        elseif health <= hum.MaxHealth/1.3 then
            cmds["heal 1"](target)
        end
    end)
end)
queue_on_teleport('loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Dimanoname/Roblox-Scripts/main/dungquest.lua"))()')
print(("Everything loaded\n").rep(5))