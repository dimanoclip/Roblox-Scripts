-- https://www.roblox.com/games/15786769057
local PlaceId = 15786769057
if game.PlaceId ~= PlaceId then warn(string.format("Wrong game detected. %s expected, got %s", PlaceId, game.PlaceId)) return end
if not game:IsLoaded() then game.Loaded:Wait() end
---------------------------------------------------------
game:GetService('Players').LocalPlayer.Idled:Connect(function() game:GetService('VirtualUser'):CaptureController() game:GetService('VirtualUser'):ClickButton2(Vector2.new()) end)
local msgs = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/msgs.lua"))()
local seekforvillains = false
_G.levels = {19, 25, 21, 21, 18}
local players = game.Players
local player = players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait() and player.Character
local hum = char:WaitForChild('Humanoid')
local HRP = char:WaitForChild('HumanoidRootPart')
player.CharacterAdded:Connect(function(character) char = character;hum = char:WaitForChild('Humanoid'); HRP = char:WaitForChild('HumanoidRootPart') end)
local gui = player.PlayerGui
local RS = game.ReplicatedStorage
local remote = RS:WaitForChild("RemoteEvent")
local toggleaura = function() remote:FireServer({"ConcealRevealAura"}) end
local XI_RANK = RS:WaitForChild("RankEvents"):WaitForChild("Normal"):WaitForChild("XI")
function TPto(pos) remote:FireServer({"Skill_Teleport", pos}) end
function invis(state) remote:FireServer({"Skill_Invisible",state and "Start" or "Stop"}) end
local function checknearplrs(dist) dist = dist or 500 for i,v in pairs(game.Players:GetChildren()) do if v~=player and v.Character and v.Character.HumanoidRootPart and math.floor((char.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude) <= 500 then return true end task.wait() end return false end
if player.PrivateStats.Rank.Value > 11 then XI_RANK:FireServer() end toggleaura()
task.spawn(function()
    while true do
        pcall(function()
            remote:FireServer({"+FS".._G.levels[1]})
            if not checknearplrs() and hum and hum.Health >= 25 then remote:FireServer({"+BT".._G.levels[2]}) end
            remote:FireServer({"+MS".._G.levels[3]})
            remote:FireServer({"+JF".._G.levels[4]})
            remote:FireServer({"+PP".._G.levels[5]})
        end) task.wait()
end end)
task.spawn(function()
    while true do
        if hum.Health == 0 then
            task.wait(0.1); remote:FireServer({"Respawn"})
            gui.ScreenGui.Enabled = true; game.Lighting.Blur.Enabled = false; gui.IntroGui.Enabled = false; task.wait(1)
            toggleaura()
            if player.PrivateStats.Rank.Value > 11 then XI_RANK:FireServer() end
        end task.wait()
    end
end)
task.spawn(function() while task.wait() do remote:FireServer({"FinishMission",300000}) task.wait(0.000000000001) end end)
msgs.Notify('AutoFarm', 'Loaded', 1)
local function SA(player)
    local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    hum:UnequipTools()
    TPto(player.Character.HumanoidRootPart.Position)
    remote:FireServer({"Skill_SoulAttack_Start", player})
    remote:FireServer({"Skill_SoulAttack_End"})
    print(player.Name..' just got soul attacked')
    task.wait(2)
    TPto(Vector3.new(pos.X+math.random(-15, 15), pos.Y, pos.Z+math.random(-15, 15)))
end
local function SR(player)
    local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    hum:UnequipTools()
    invis(true); task.wait(0.2)
    TPto(player.Character.HumanoidRootPart.Position)
    remote:FireServer({"Skill_SoulReap", player})
    print(player.Name..' just got soul reaped')
    task.wait(2)
    TPto(Vector3.new(pos.X+math.random(-15, 15), pos.Y, pos.Z+math.random(-15, 15)))
    invis(false); task.wait(0.2)
end
local function soulattack(player)
    local PP = game.Players.LocalPlayer.PrivateStats.PsychicPower.Value
    if player == game.Players.LocalPlayer then return end
    if player then
        if player.PrivateStats.PsychicPower.Value < PP then
            if player.PrivateStats.Reputation.Value ~= 0 then SR(player) else SA(player) end
        end
        task.wait(1)
    else
        for i,v in pairs(game.Players:GetChildren()) do
            if v.PrivateStats.PsychicPower.Value < PP and v ~= game.Players.LocalPlayer then
                if v.PrivateStats.Reputation.Value ~= 0 then SR(v) else SA(v) end
            end
            task.wait(1)
        end
    end
end

local ServerPlayers = {}
function checkingrep(player)
    local rep = player:WaitForChild('PrivateStats').Reputation.Value
    local lastrep = player.PrivateStats.Reputation.Value
    ServerPlayers[player.Name] = true
    task.spawn(function()
        while ServerPlayers[player.Name] do task.wait(1)
            if not seekforvillains then task.wait() return end
            if player.PrivateStats.Reputation.Value ~= lastrep and player.PrivateStats.Reputation.Value < 0 then
                if not player.Character then return end
                if math.floor((char.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude) < 5000 then task.wait(1); soulattack(player)
                else while true do if math.floor((char.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude) < 5000 then task.wait(1); soulattack(player); break end task.wait(0.5) end end
            end
        end
    end)
end

players.PlayerAdded:Connect(checkingrep)
players.PlayerRemoving:Connect(function(player) ServerPlayers[player.Name] = false end)
for i,v in pairs(players:GetChildren()) do checkingrep(v) end

-- local addshield = workspace:WaitForChild("Main"):WaitForChild("MouseIgnoreGroup"):WaitForChild("SafeZone"):WaitForChild("Add")
-- local removeshield = workspace:WaitForChild("Main"):WaitForChild("MouseIgnoreGroup"):WaitForChild("SafeZone"):WaitForChild("Delete")
local UserInputService=game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(a,b)
    if a.KeyCode == Enum.KeyCode.F1 then seekforvillains = not seekforvillains; msgs.Notify('Watching', seekforvillains and 'Enabled' or 'Disabled', 1)
    elseif a.KeyCode == Enum.KeyCode.F2 then for i,v in pairs(game.Players:GetChildren()) do if v.PrivateStats.Reputation.Value < 0 then soulattack(v); task.wait(0.1) end end
    elseif a.KeyCode == Enum.KeyCode.F3 then soulattack()
    elseif a.KeyCode == Enum.KeyCode.F4 then loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/rejoin.lua"))()
    elseif a.KeyCode == Enum.KeyCode.F5 then loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/serverhop.lua"))() end
end)
-- task.spawn(function() while task.wait() do if shield then addshield:FireServer() end end end)
msgs.Notify('Useful Binds', 'F1 - toggle watching\nF2 - Kill villians(PP)\nF3 - kill all(PP)')
msgs.Notify('Misc Binds', 'F4 - ReJoin\nF5 - ServerHop')

local convs = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/convs.lua"))()
local weaker = 0
local myps = game.Players.LocalPlayer.PrivateStats.PsychicPower.Value
for i,v in pairs(game.Players:GetChildren()) do
    if myps > v.PrivateStats.PsychicPower.Value then weaker = weaker + 1 end
    print(v.Name..'('..v.PrivateStats.Reputation.Value..')', 'PP: '..convs.ToLetters(v.PrivateStats.PsychicPower.Value))
end
print(weaker..'/'..(#game.Players:GetChildren())-1)


loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua"))()