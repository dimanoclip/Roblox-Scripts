-- https://www.roblox.com/games/14305177026

-- Services

local http = game:GetService("HttpService")
local vu = game:GetService("VirtualUser")
local rs = game:GetService("ReplicatedStorage")

-- Loads

local settings = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/settings.lua"))()
local wh = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/wh.lua"))()

-- Vars

local data = {

}


local filename = "UselessData.json"
local pp,LP = game.Players,game.Players.LocalPlayer
local stats = LP.leaderstats
local ranking,sbl = false,false
local asc,sanc = stats.Ascension.Value,stats.SanctificationName.Value

-- AntiAFK

LP.Idled:Connect(function() vu:CaptureController(); vu:ClickButton2(Vector2.new()) end)

-- Events

pp.PlayerRemoving:Connect(function(ply)
	if ply == LP then
		data.Player = ply.Name
		if stats.BestLevel.Value < 500 then data.BestLevel = stats.BestLevel.Value
		else data.BestLevel = stats.Level.Value end
		data.Level = stats.Level.Value
		settings.save(filename, data)
	end
end)

-- Script

while task.wait() do
	if stats.ManaPerSec.Value == 0 and ranking == false then
		if stats.BestLevel.Value >= 500 then
			if settings.check(filename) then
				if settings.get(filename).BestLevel >= stats.Level.Value then
					stats.BestLevel.Value = settings.get(filename).BestLevel
				else stats.BestLevel.Value = stats.Level.Value end
			else stats.BestLevel.Value = stats.Level.Value
			end
			sbl = true
		end
		rs:WaitForChild("ManaGain"):FireServer()
		task.wait(3)
		task.spawn(function()
			while stats.ManaPerSec.Value ~= 0 do task.wait()
				if stats.Mana.Value >= stats.RequiredMana.Value then
					ranking = true
					local bl = stats.BestLevel.Value
					while stats.Mana.Value >= stats.RequiredMana.Value do
						rs:WaitForChild("RankUp"):FireServer()
						task.wait(3)
					end
					if stats.Level.Value >= bl or stats.Level.Value == 500 then
						if sbl then stats.BestLevel.Value = stats.Level.Value end
						rs:WaitForChild("Sanctify"):FireServer()
						rs:WaitForChild("Rebirth"):FireServer()
					end
					ranking = false
				end
			end
		end)
	end
end