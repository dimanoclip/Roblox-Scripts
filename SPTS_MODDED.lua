-- https://www.roblox.com/games/15786769057
local PlaceId = 15786769057
if game.PlaceId ~= PlaceId then warn(string.format("Wrong game detected. %s expected, got %s", PlaceId, game.PlaceId)) return end
if not game:IsLoaded() then game.Loaded:Wait() end
---------------------------------------------------------
game:GetService('Players').LocalPlayer.Idled:Connect(function() game:GetService('VirtualUser'):CaptureController() game:GetService('VirtualUser'):ClickButton2(Vector2.new()) end)
local msgs = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/msgs.lua"))()
local add = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/additional.lua"))()
local seekforvillains = false
local farm_tpm = false
local autofarm = false
_G.levels = {21, 27, 23, 23, 20}
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
local skills = {}
skills.lasthands = {1,1}
skills.punch = function(pos) remote:FireServer({"Skill_Punch",skills.lasthands[1] == 1 and "Right" or "Left",pos}); print('Just punched at '..tostring(pos)); skills.lasthands[1] = skills.lasthands[1] == 1 and 0 or 1 end
skills.soul_attack = function(target) remote:FireServer({"Skill_SoulAttack_Start", target});task.wait();remote:FireServer({"Skill_SoulAttack_End"}); print('Just soul attacked '..target.Name) end
skills.soul_reap = function(target) remote:FireServer({"Skill_SoulReap", target}); print('Just soul reaped '..target.Name) end
skills.devil_flame = function(target) remote:FireServer({"Skill_DevilFlame", target}); print('Just flamed '..target.Name) end
skills.fireball = function(pos) remote:FireServer({"Skill_SpherePunch",pos}); print('Just fireballed at '..tostring(pos)) end
skills.invisible = function(state) remote:FireServer({"Skill_Invisible",state and "Start" or "Stop"}); print('Just '..(state and 'enabled ' or 'disabled ')..'invisibility') end
skills.bpunch = function(pos) remote:FireServer({"Skill_BulletPunch", skills.lasthands[2] == 1 and "Right" or "Left", add.dist_to(pos), pos}); print('Just shoted at '..tostring(pos)); skills.lasthands[2] = skills.lasthands[2] == 1 and 0 or 1 end
skills.teleport = function(pos) remote:FireServer({"Skill_Teleport",pos}); print('Just teleported to '..tostring(pos)) end
skills.toggleaura = function() remote:FireServer({"ConcealRevealAura"}); print('Just toggled aura') end
local function checknearplrs(dist) dist = dist or 500 for i,v in pairs(game.Players:GetChildren()) do if v~=player and v.Character and v.Character.HumanoidRootPart and add.dist_to(v.Character.HumanoidRootPart.Position) <= 1000 then return true end task.wait() end return false end
if player.PrivateStats.Rank.Value > 11 then XI_RANK:FireServer() end toggleaura()
task.spawn(function()
    while true do
        pcall(function()
            if not hum or hum.Health <= 0 or not autofarm then return end
            remote:FireServer({"+FS".._G.levels[1]})
            if not checknearplrs() and hum then remote:FireServer({"+BT"..(hum.Health >= 25 and _G.levels[2] or _G.levels[2]-1)}) end
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
task.spawn(function() while task.wait() do if farm_tpm then remote:FireServer({"FinishMission",300000}) task.wait(0.000000000001) end end end)
msgs.Notify('AutoFarm', 'Loaded', 1)
local function SA(player)
    local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    skills.teleport(player.Character.HumanoidRootPart.Position)
    skills.soul_attack(player)
    task.wait(2)
    skills.teleport(Vector3.new(pos.X+math.random(-15, 15), pos.Y, pos.Z+math.random(-15, 15)))
end
local function SR(player)
    local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    skills.teleport(player.Character.HumanoidRootPart.Position)
    skills.soul_reap(player)
    task.wait(2)
    skills.teleport(Vector3.new(pos.X+math.random(-15, 15), pos.Y, pos.Z+math.random(-15, 15)))
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
    task.spawn(function()
    local rep = player:WaitForChild('PrivateStats'):WaitForChild('Reputation').Value
    local lastrep = player.PrivateStats.Reputation.Value
    ServerPlayers[player.Name] = true
    task.spawn(function()
        while ServerPlayers[player.Name] do task.wait(1)
            if not seekforvillains then task.wait() return end
            if player.PrivateStats.Reputation.Value ~= lastrep and player.PrivateStats.Reputation.Value < 0 then
                if not player.Character then return end
                if add.dist_to(player.Character.HumanoidRootPart.Position) < 500 then task.wait(1); soulattack(player)
                elseif add.dist_to(player.Character.HumanoidRootPart.Position) < 700 then task.wait(1); skills.devil_flame(player)
                else while true do if add.dist_to(player.Character.HumanoidRootPart.Position) < 700 then task.wait(1); soulattack(player); break end task.wait(0.5) end end
            end
        end
    end)
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
    elseif a.KeyCode == Enum.KeyCode.F2 then autofarm = not autofarm; msgs.Notify('Autofarm', autofarm and 'Enabled' or 'Disabled', 1)
    elseif a.KeyCode == Enum.KeyCode.F3 then for i,v in pairs(game.Players:GetChildren()) do if v.PrivateStats.Reputation.Value < 0 then soulattack(v); task.wait(0.1) end end
    elseif a.KeyCode == Enum.KeyCode.F4 then farm_tpm = not farm_tpm; msgs.Notify('TPM Farm', farm_tpm and 'Enabled' or 'Disabled', 1)
    elseif a.KeyCode == Enum.KeyCode.F5 then loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/rejoin.lua"))()
    elseif a.KeyCode == Enum.KeyCode.F6 then loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/serverhop.lua"))() end
end)
-- task.spawn(function() while task.wait() do if shield then addshield:FireServer() end end end)
msgs.Notify('Main Binds', 'F1 - toggle watching\nF2 - toggle autofarm\nF3 - Kill villians(PP)')
msgs.Notify('Misc Binds', 'F4 - toggle tpm farm\nF5 - ReJoin\nF6 - ServerHop')

-- local convs = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/convs.lua"))()
-- local weaker = 0
-- local myps = game.Players.LocalPlayer.PrivateStats.PsychicPower.Value
-- for i,v in pairs(game.Players:GetChildren()) do
--     if myps > v.PrivateStats.PsychicPower.Value then weaker = weaker + 1 end
--     print(v.Name..'('..v.PrivateStats.Reputation.Value..')', 'PP: '..convs.ToLetters(v.PrivateStats.PsychicPower.Value))
-- end
-- print(weaker..'/'..(#game.Players:GetChildren())-1)

-- while task.wait() do
-- 	game.Players.LocalPlayer.PrivateStats.Gamepass_LBConceal_TP.Value = true
-- 	game.Players.LocalPlayer.PrivateStats.Gamepass_LBConceal_TPM.Value = true
-- 	game.Players.LocalPlayer.PrivateStats.Gamepass_LBConceal_BT.Value = true
-- 	game.Players.LocalPlayer.PrivateStats.Gamepass_LBConceal_F2P.Value = true
-- 	game.Players.LocalPlayer.PrivateStats.Gamepass_LBConceal_FS.Value = true
-- 	game.Players.LocalPlayer.PrivateStats.Gamepass_LBConceal_Has.Value = true
-- 	game.Players.LocalPlayer.PrivateStats.Gamepass_LBConceal_JF.Value = true
-- 	game.Players.LocalPlayer.PrivateStats.Gamepass_LBConceal_Kills.Value = true
-- 	game.Players.LocalPlayer.PrivateStats.Gamepass_LBConceal_MS.Value = true
-- 	game.Players.LocalPlayer.PrivateStats.Gamepass_LBConceal_NegativeREP.Value = true
-- 	game.Players.LocalPlayer.PrivateStats.Gamepass_LBConceal_PP.Value = true
-- 	game.Players.LocalPlayer.PrivateStats.Gamepass_LBConceal_PositiveREP.Value = true
-- end