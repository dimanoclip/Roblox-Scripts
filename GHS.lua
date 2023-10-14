-- https://www.roblox.com/games/13122746147
local PlaceId = 13122746147
if game.PlaceId ~= PlaceId then warn(string.format("Wrong game detected. %s expected, got %s", PlaceId, game.PlaceId)) return end
local eggams = {1, 3, 8}
local plyw,eggs,eggam = nil,false,eggams[1]
if game.Players.LocalPlayer.PlayerGui.PetsGui.PetAnimation:FindFirstChild("AnimationExample") then game.Players.LocalPlayer.PlayerGui.PetsGui.PetAnimation:FindFirstChild("AnimationExample"):Remove() end
local UserInputService = game:GetService("UserInputService")
local msg = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/messages.lua"))()
game.Players.LocalPlayer.Idled:connect(function() game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end)
spawn(function()
while true do task.wait()
game:GetService("ReplicatedStorage"):WaitForChild("ClientEvents"):WaitForChild("Rebirth"):FireServer()
game:GetService("ReplicatedStorage"):WaitForChild("ClientEvents"):WaitForChild("Spin"):FireServer()
plyw = game.Players.LocalPlayer:WaitForChild("DataFolder").CurrentWorld.Value
game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WeightSpawnHandler"):WaitForChild("Collect"):FireServer(plyw)
end
end)
spawn(function()
while true do task.wait(1) if eggs then game:GetService("ReplicatedStorage"):WaitForChild("ClientEvents"):WaitForChild("OpenedPet"):FireServer(plyw, eggam) end
game:GetService("ReplicatedStorage"):WaitForChild("ClientEvents"):WaitForChild("ChangePet"):FireServer("CraftAll")
game:GetService("ReplicatedStorage"):WaitForChild("ClientEvents"):WaitForChild("ChangePet"):FireServer("EquipBest")
end
end)
UserInputService.InputBegan:connect(function(a,b)
	if a.KeyCode == Enum.KeyCode.F1 then
		game:GetService("ReplicatedStorage"):WaitForChild("ClientEvents"):WaitForChild("OpenedPet"):FireServer(plyw, eggam)
	elseif a.KeyCode == Enum.KeyCode.F2 then
		eggs = not eggs; msg.Notify("AutoHatch", tostring(eggs))
	end
	if a.KeyCode == Enum.KeyCode.LeftBracket then
		for i,v in pairs(eggams) do if i ~= 1 and v == eggam then eggam = eggams[i-1]; msg.Notify("EggsToHatch", tostring(eggam)); break end end
	elseif a.KeyCode == Enum.KeyCode.RightBracket then
		for i,v in pairs(eggams) do if i ~= 3 and v == eggam then eggam = eggams[i+1]; msg.Notify("EggsToHatch", tostring(eggam)); break end end
	end
end)