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
local pgui = lp.PlayerGui
local abils = pgui.abilities.Frame
local skill1 = abils.LeftAbility
local skill2 = abils.RightAbility
local function getcd(skill)
    return skill:FindFirstChild("cooldownNumber") and skill.cooldownNumber.Text
end
local function delaymsg(target)
    local args = {
        [1] = "sorry, I have a cooldown!",
        [2] = string.format("To %s", target.Nick or target)
    }
    chatevent:FireServer(unpack(args))
end
local cmds = {
    ["heal 1"] = function(target) if add.is_alive(target) and getcd(skill1) == "0.1" then root.CFrame = target.Character:WaitForChild("HumanoidRootPart").CFrame; key(Enum.KeyCode.Q) elseif getcd(skill1) ~= "0.1" then delaymsg(target) end end,
    ["heal 2"] = function(target) if add.is_alive(target) and getcd(skill2) == "0.1" then root.CFrame = target.Character:WaitForChild("HumanoidRootPart").CFrame; key(Enum.KeyCode.E) elseif getcd(skill2) ~= "0.1" then delaymsg(target) end end
}
plys:FindFirstChild("makasgamer20").Chatted:Connect(function(msg, targ)
    local askedply = plys["makasgamer20"]
    if string.find(msg, "/w ighf8yu5g ") then msg = string.sub(msg, #"/w ighf8yu5g "+2) end
    print(msg)
    for cmd, callback in pairs(cmds) do
        if msg == cmd then callback(askedply) end
    end
end)
plys:FindFirstChild("dimasikprofi4").Chatted:Connect(function(msg, targ)
    local askedply = plys["dimasikprofi4"]
    if string.find(msg, "/w ighf8yu5g ") then msg = string.sub(msg, #"/w ighf8yu5g "+2) end
    print(msg)
    for cmd, callback in pairs(cmds) do
        if msg == cmd then callback(askedply) end
    end
end)

print("Everything loaded")