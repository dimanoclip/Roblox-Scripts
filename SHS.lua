--https://www.roblox.com/games/12014935450
local PlaceId = 12014935450
if game.PlaceId ~= PlaceId then warn(string.format("Wrong game detected. %s expected, got %s", PlaceId, game.PlaceId)) return end
--Vars
local pp,LP = game.Players,game.Players.LocalPlayer
local char = LP.Character or LP.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local rs,remote = game:GetService("ReplicatedStorage"),game:GetService("ReplicatedStorage"):WaitForChild("Remote")
local vu = game:GetService("VirtualUser")
--Libs
local adds = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/additional.lua"))()
--AntiAFK
LP.Idled:Connect(function() vu:CaptureController() vu:ClickButton2(Vector2.new()) end)
--Main
local function stopanims()
	for i,v in pairs(hum:GetPlayingAnimationTracks()) do
		if v.Name == "Pushup" or string.find(v.Name, "Punch") then
			v:Stop(0)
		end
	end
end
task.spawn(function()
	remote:FireServer("Daily Draw", "VIP")
	remote:FireServer("Daily Draw", "Free")
end)
task.spawn(function()
	while task.wait() do
		for i1,v in pairs({"D", "W"}) do for i2=1,3 do remote:FireServer("Time Quest", "Finished", v..tostring(i2)) end	end
		for i,v in pairs(game:GetService("Workspace").TrainingZones:children()) do
			if v.Name ~= "Other" and v.Name ~= "Speed" then
				for i1,v1 in pairs(v:children()) do
					if adds.dist(v1.TrainingZone.Position) <= 15 and not adds.moving(hum) then
						remote:FireServer("Train", v.Name)
						stopanims()
					end
				end
			end
		end
		remote:FireServer("Train Speed")
	end
end)