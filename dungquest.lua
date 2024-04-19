local inp = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/vinp.lua"))()
local add = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/additional.lua"))()
local key = inp.PressKey
local plys = game.Players
local lp = plys.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
lp.CharacterAdded:Connect(function(character) char = character end)
local root = char:WaitForChild("HumanoidRootPart")
local rs = game:GetService("ReplicatedStorage")
local chatevent = rs:WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
local spawn = task.spawn
local pgui = lp.PlayerGui
local abils = pgui.abilities.Frame
local skill1 = abils.LeftAbility
local skill2 = abils.RightAbility
local lastpos = root.CFrame
local function getcd(skill)
    return (skill:FindFirstChild("slot") and skill:FindFirstChild("slot"):FindFirstChild("cooldownNumber")) and skill.slot.cooldownNumber.Text
end
local function delaymsg(target)
    local args = {
        [1] = "COOLDOWN!",
        [2] = string.format("To %s", target.Name or target)
    }
    for i=1,5 do task.wait(); chatevent:FireServer(unpack(args)) end
end
local cmds = {
    ["heal 1"] = function(target) if add.is_alive(target) and (getcd(skill1) == "0.1" or getcd(skill1) == "4") then root.CFrame = target.Character:WaitForChild("HumanoidRootPart").CFrame; key(Enum.KeyCode.Q); task.wait(4); root.CFrame = lastpos elseif getcd(skill1) ~= "0.1" and getcd(skill1) ~= "4" then delaymsg(target) end end,
    ["heal 2"] = function(target) if add.is_alive(target) and (getcd(skill2) == "0.1" or getcd(skill2) == "4") then root.CFrame = target.Character:WaitForChild("HumanoidRootPart").CFrame; key(Enum.KeyCode.E); task.wait(4); root.CFrame = lastpos elseif getcd(skill2) ~= "0.1" and getcd(skill2) ~= "4" then delaymsg(target) end end
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
queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Scripts/main/dungquest.lua"))()')
print("Everything loaded")


