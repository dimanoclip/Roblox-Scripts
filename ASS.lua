-- https://www.roblox.com/games/13379838093
local vim = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/virtinp.lua"))()
local msg = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/messages.lua"))()
local UserInputService = game:GetService("UserInputService")
local clk = false
local speed = 32
game.Players.LocalPlayer.Idled:connect(function() game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end)
spawn(function() 
	while true do task.wait()
		for i,Village in pairs(game.workspace.Server.Mobs:GetChildren()) do
			for i1,Mob in pairs(Village:GetChildren()) do
				if math.floor(((game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")).Position - Mob.Position).magnitude) <= 15 then
					local args = {
					    [1] = {
					        [1] = "MobHit",
					        [2] = Mob,
					        [3] = "WeaponAttack"
					    }
					}
					game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Server"):FireServer(unpack(args))
				end
			end
		end
		for i,Model in pairs(game.workspace.Debris:GetChildren()) do
			if Model:IsA("Part") and string.find(Model.Name, "-")then
				if math.floor(((game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")).Position - Model.Position).magnitude) <= 55 then
					Model.CFrame = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
				end
			end
		end
	end 
end)
spawn(function() while true do task.wait() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed if clk then vim.CenterMouseClick() end end end)
UserInputService.InputBegan:connect(function(a,b)
	if a.KeyCode == Enum.KeyCode.F1 then
		clk = not clk
	elseif a.KeyCode == Enum.KeyCode.LeftBracket then
		if speed > 32 then speed -= 2; msg.Notify("WalkSpeed", tostring(speed)) end
	elseif a.KeyCode == Enum.KeyCode.RightBracket then
		if speed < 96 then speed += 2; msg.Notify("WalkSpeed", tostring(speed)) end
	end
end)