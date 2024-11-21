-- https://www.roblox.com/games/12798970675
local PlaceId = 12798970675
if game.PlaceId ~= PlaceId then warn(string.format("Wrong game detected. %s expected, got %s", PlaceId, game.PlaceId)) return end
if not game:IsLoaded() then game.Loaded:Wait() end
---------------------------------------------------------
game:GetService('Players').LocalPlayer.Idled:Connect(function() game:GetService('VirtualUser'):CaptureController() game:GetService('VirtualUser'):ClickButton2(Vector2.new()) end)
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait() and player.Character
local humanoid = char:WaitForChild('Humanoid')
player.CharacterAdded:Connect(function(character) char = character; humanoid = char:WaitForChild('Humanoid') end)
local mouse = player:GetMouse(), Workspace.CurrentCamera
local UIS = game:GetService("UserInputService")
local farmposorig, farmpos, LB = nil, nil, 0
local Remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent")
UIS.InputBegan:Connect(function(key, gpe)
    if key.KeyCode == Enum.KeyCode.F1 then
        char.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
		farmposorig = char.HumanoidRootPart.Position
        farmpos = char.HumanoidRootPart.CFrame
    elseif key.KeyCode == Enum.KeyCode.F2 then
        char.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
		farmposorig = nil
        farmpos = nil
    elseif key.KeyCode == Enum.KeyCode.F5 then
        local Success, ErrorMessage = pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer) end)
        if ErrorMessage and not Success then warn(ErrorMessage) end
    elseif key.KeyCode == Enum.KeyCode.F6 then
        local Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. game.PlaceId .. '/servers/Public?sortOrder=Asc&limit=100'))
        local lowest,serverid = math.huge, ""
        for i,v in pairs(Site.data) do
            if lowest > v.playing then lowest = v.playing; serverid = tostring(v.id) end
        end
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, serverid, game.Players.LocalPlayer)
	end
	if key.KeyCode==Enum.KeyCode.KeypadPlus then
		if LB < 19 then LB = LB + 1 end
        Remote:FireServer({"EquipWeight_Request", LB})
	elseif key.KeyCode==Enum.KeyCode.KeypadMinus then
		if LB > 0 then LB = LB - 1 end
        Remote:FireServer({"EquipWeight_Request", LB})
	end
end)

task.spawn(function()
    while task.wait() do
        if humanoid and humanoid.Health <= 0 then
            Remote:FireServer({"Respawn"})
            task.wait(0.1)
            if farmposorig then farmpos = CFrame.new(farmposorig.X+math.random(-25, 25)/10, farmposorig.Y, farmposorig.Z+math.random(-25, 25)/10) end
            player.PlayerGui.ScreenGui.Enabled = true
            repeat task.wait() until player.PlayerGui.IntroGui.Enabled == true
            Remote:FireServer({"EquipWeight_Request", LB})
            Remote:FireServer({"ConcealRevealAura"})
            game.Lighting.Blur.Enabled = false; player.PlayerGui.IntroGui.Enabled = false
            continue
        elseif humanoid and farmpos and humanoid.Health > 0 then
            char.HumanoidRootPart.CFrame = farmpos
        end
        Remote:FireServer({"Add_FS_Request"})
        Remote:FireServer({"Add_MS_Request"})
        Remote:FireServer({"Add_JF_Request"})
    end
end)