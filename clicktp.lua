local Player = game.Players.LocalPlayer
local PlyChar = Player.Character
local PlyRP = PlyChar.HumanoidRootPart
local mouse = Player:GetMouse()
mouse.KeyDown:connect(function(key)
	if key == "b" then
		if mouse.Target then
			PlyRP.CFrame = CFrame.new(mouse.Hit.x, mouse.Hit.y + 5, mouse.Hit.z)
		end
	end
end)