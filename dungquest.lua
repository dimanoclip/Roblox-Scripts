local inp = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/vinp.lua"))()
local add = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/additional.lua"))()
local key = inp.PressKey
local plys = game.Players
local lp = plys.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
lp.CharacterAdded:Connect(function(character) char = character end)
local rs = game:GetService("ReplicatedStorage")
local chatevent = rs:WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
local spawn, wait = task.spawn, task.wait
local pgui = lp.PlayerGui
local abils = pgui:WaitForChild("abilities").Frame
local skill1 = abils:FindFirstChild("LeftAbility")
local skill2 = abils:FindFirstChild("RightAbility")
local lastpos = char:WaitForChild("HumanoidRootPart").CFrame
local function chat_say(text, target)
    chatevent:FireServer(string.format("/w %s %s", target.Name, text), "All")
end
local debounce = false
local function deb(time)
    spawn(function()
        if not debounce then
            debounce = true
            wait(time)
            debounce = false
        end
    end)
end
local triggers = {
    others = {2, 1.3},
    self = {1.1}
}
local function checktriggers(ply, health)
    local hum = ply.Character:WaitForChild("Humanoid"); health = health or hum.Health
    if ply == lp then
        for i, trigger in pairs(triggers["self"]) do
            if health <= hum.MaxHealth/trigger then return i end
        end
    else
        for i, trigger in pairs(triggers["others"]) do
            if health <= hum.MaxHealth/trigger then return i end
        end
    end
end
local cmds = {
    ["heal 1"] = function(target) if add.is_alive(target) and not debounce then spawn(function() key(Enum.KeyCode.Q); chat_say("Healed!!!", target); deb(0.3) end) end end,
    ["heal 2"] = function(target) if add.is_alive(target) and not debounce then spawn(function() key(Enum.KeyCode.E); chat_say("Healed!!!", target); deb(0.3) end) end end,
}

char:WaitForChild("Humanoid").HealthChanged:Connect(function(health)
    local target = lp
    local hum = target.Character:WaitForChild("Humanoid")
    if checktriggers(target, health) then
        cmds["heal 2"](target)
    end
end)

spawn(function()
    local player = plys:WaitForChild("makasgamer20")
    player.Chatted:Connect(function(msg, targ)
        local askedply = player
        if string.find(msg, "/w ighf8yu5g ") then msg = string.sub(msg, #"/w ighf8yu5g "+2) end
        print(msg)
        for cmd, callback in pairs(cmds) do
            if msg == cmd then callback(askedply) end
        end
    end)
    player.Character:WaitForChild("Humanoid").HealthChanged:Connect(function(health)
        local target = player
        if checktriggers(target, health) == 1 then
            cmds["heal 2"](target)
        elseif checktriggers(target, health) == 2 then
            cmds["heal 1"](target)
        end
    end)
end)
spawn(function()
    local player = plys:WaitForChild("dimasikprofi4")
    player.Chatted:Connect(function(msg, targ)
        local askedply = player
        if string.find(msg, "/w ighf8yu5g ") then msg = string.sub(msg, #"/w ighf8yu5g "+2) end
        print(msg)
        for cmd, callback in pairs(cmds) do
            if msg == cmd then callback(askedply) end
        end
    end)
    player.Character:WaitForChild("Humanoid").HealthChanged:Connect(function(health)
        local target = player
        if checktriggers(target, health) == 1 then
            cmds["heal 2"](target)
        elseif checktriggers(target, health) == 2 then
            cmds["heal 1"](target)
        end
    end)
end)
queue_on_teleport('loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Dimanoname/Roblox-Scripts/main/dungquest.lua"))()')
print(string.rep("\nEverything loaded", 5))
print(string.format("\nTriggers are:\n%s for others,\n%s for self\n", table.concat(triggers["others"], ", "), table.concat(triggers["self"], ", ")))