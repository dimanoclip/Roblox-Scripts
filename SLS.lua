-- https://www.roblox.com/games/13802578990
local PlaceId = 13802578990
if game.PlaceId ~= PlaceId then warn(string.format("Wrong game detected. %s expected, got %s", PlaceId, game.PlaceId)) return end
local Farm = true
local FSpot = "Forest_5"
local Players = game.Players
local Player = Players.LocalPlayer
local bb=game:service'VirtualUser'
local msg = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/messages.lua"))()
Player.Idled:connect(function()
bb:CaptureController()bb:ClickButton2(Vector2.new())
end)
local FSpots = {}
local Worlds = {"Forest", "VikingLands", "Desert", "SamuraiVillage", "Town", "Graveyard", "Beach", "Footland", "Undersea"}
for i,v in pairs(Worlds) do
	for i1=1,5 do
		table.insert(FSpots, v.."_"..i1)
	end
end
local function IncVar(var)
	if string.find(var, "Forest_") then
		var = FSpots[var:gsub("Forest_", "")+1]
		return var
	elseif string.find(var, "VikingLands_") then
		var = FSpots[var:gsub("VikingLands_", "")+6]
		return var
	elseif string.find(var, "Desert_") then
		var = FSpots[var:gsub("Desert_", "")+11]
		return var
	elseif string.find(var, "SamuraiVillage_") then
		var = FSpots[var:gsub("SamuraiVillage_", "")+16]
		return var
	elseif string.find(var, "Town_") then
		var = FSpots[var:gsub("Town_", "")+21]
		return var
	elseif string.find(var, "Graveyard_") then
		var = FSpots[var:gsub("Graveyard_", "")+26]
		return var
	elseif string.find(var, "Beach_") then
		var = FSpots[var:gsub("Beach_", "")+31]
		return var
	elseif string.find(var, "Footland_") then
		var = FSpots[var:gsub("Footland_", "")+36]
		return var
	elseif string.find(var, "Undersea_") then
		var = FSpots[var:gsub("Undersea_", "")+41]
		return var
	end
end
local function DecVar(var)
	if string.find(var, "Forest_") then
		var = FSpots[var:gsub("Forest_", "")-1]
		return var
	elseif string.find(var, "VikingLands_") then
		var = FSpots[5+var:gsub("VikingLands_", "")-1]
		return var
	elseif string.find(var, "Desert_") then
		var = FSpots[10+var:gsub("Desert_", "")-1]
		return var
	elseif string.find(var, "SamuraiVillage_") then
		var = FSpots[15+var:gsub("SamuraiVillage_", "")-1]
		return var
	elseif string.find(var, "Town_") then
		var = FSpots[20+var:gsub("Town_", "")-1]
		return var
	elseif string.find(var, "Graveyard_") then
		var = FSpots[25+var:gsub("Graveyard_", "")-1]
		return var
	elseif string.find(var, "Beach_") then
		var = FSpots[30+var:gsub("Beach_", "")-1]
		return var
	elseif string.find(var, "Footland_") then
		var = FSpots[35+var:gsub("Footland_", "")-1]
		return var
	elseif string.find(var, "Undersea_") then
		var = FSpots[40+var:gsub("Undersea_", "")-1]
		return var
	end
end
local UserInputService=game:GetService("UserInputService")
UserInputService.InputBegan:connect(function(a,b)
	if a.KeyCode == Enum.KeyCode.F1 then
		Farm = not Farm
		msg.Notify("ItemLifting", tostring(Farm))
	end
	if a.KeyCode == Enum.KeyCode.RightBracket then
		FSpot = IncVar(FSpot)
		msg.Notify("LiftingSpot", tostring(FSpot))
	elseif a.KeyCode == Enum.KeyCode.LeftBracket then
		FSpot = DecVar(FSpot)
		msg.Notify("LiftingSpot", tostring(FSpot))
	end
end)
spawn(function()
	while true do task.wait()
		game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Network"):WaitForChild("HatchEgg"):InvokeServer("DiscoEgg", 1)
	end
end)
spawn(function()
	while true do task.wait()
		game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Network"):WaitForChild("ComboClick"):FireServer()
		game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Network"):WaitForChild("BuyPrestige"):FireServer()
		game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Network"):WaitForChild("Rebirth"):FireServer()
	end
end)
spawn(function()
	while true do task.wait(1)
		game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Network"):WaitForChild("CraftAll"):FireServer()
		game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Network"):WaitForChild("EquipBestPets"):FireServer()
	end
end)
spawn(function()
	while true do task.wait()
		if Farm then
			game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Network"):WaitForChild("StartLifting"):FireServer(FSpot)
			task.wait(0.6)
		end
	end
end)