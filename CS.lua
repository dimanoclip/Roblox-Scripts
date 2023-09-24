-- https://www.roblox.com/games/14277384007
-------------------------------- VARS --------------------------------
local wh = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/wh.lua"))()
local msg = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/messages.lua"))()
local IS,RS = game:GetService("UserInputService"),game:GetService("ReplicatedStorage")
local pp,LP = game.Players,game.Players.LocalPlayer
local farmpos,lastpos,lastpos1,lastpos2 = nil,nil,nil,nil
local lastlast = 'lastpos1'
local farmmobs = false

-------------------------------- EVENTS --------------------------------
LP.Idled:connect(function() game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end)
IS.InputBegan:connect(function(a,b)

	if a.KeyCode == Enum.KeyCode.F1 then
		if lastpos1 == nil then
			lastpos1 = LP.Character:WaitForChild("HumanoidRootPart").CFrame
			msg.Notify("Train zone", "Setted")
		else
			LP.Character:WaitForChild("HumanoidRootPart").CFrame = lastpos1
			lastlast = 'lastpos1'
			pcall(function() LP.Backpack:FindFirstChild("Meditate").Parent = LP.Character end)
			RS:WaitForChild("Remotes"):WaitForChild("Cultivate"):FireServer(true)			
			msg.Notify("Train zone", "Teleporting")
		end

	elseif a.KeyCode == Enum.KeyCode.F2 then
		if lastpos2 == nil then
			lastpos2 = LP.Character:WaitForChild("HumanoidRootPart").CFrame
			msg.Notify("Checkpoint", "Setted")
		else
			LP.Character:WaitForChild("HumanoidRootPart").CFrame = lastpos2
			lastlast = 'lastpos2'
			msg.Notify("Checkpoint", "Teleporting")
		end

	elseif a.KeyCode == Enum.KeyCode.F3 then
		if lastlast == 'lastpos1' then
			lastpos1 = nil
			msg.Notify("Train zone", "Resetted")
		elseif lastlast == 'lastpos2' then
			lastpos2 = nil
			msg.Notify("Checkpoint", "Resetted")
		end

	elseif a.KeyCode == Enum.KeyCode.F4 then
		farmmobs = not farmmobs
		farmpos = LP.Character:WaitForChild("HumanoidRootPart").CFrame
		msg.Notify("AutoFarm", tostring(farmmobs))

	elseif a.KeyCode == Enum.KeyCode.F5 then
		lastpos = LP.Character:WaitForChild("HumanoidRootPart").CFrame
		local phil = game.workspace.World.Shops.Phil.Model.PrimaryPart
		if math.floor(((LP.Character:FindFirstChild("HumanoidRootPart")) - phil.Position).magnitude) < 100 then
			LP.Character:WaitForChild("HumanoidRootPart").CFrame = phil.CFrame
		end
		local slots = {}
		for i,v in pairs(LP.PlayerGui.Gui.Inventory.InventoryVanity.Grid:children()) do
			if v:IsA("ImageLabel") then
				table.insert(slots, v.Name)
			end
		end
		for i=1,#slots do
			game:GetService("ReplicatedStorage").Remotes.BuyItem:FireServer("Phil", "Supreme Grain Pill")
		end
		task.wait(0.25)
		LP.Character:WaitForChild("HumanoidRootPart").CFrame = lastpos
	end
end)


-------------------------------- Funcs --------------------------------
spawn(function()
while true do task.wait()
	RS:WaitForChild("Remotes"):WaitForChild("BreakThrough"):FireServer()
end
end)

spawn(function()
while true do task.wait()
	if farmmobs then
		LP.Character:WaitForChild("HumanoidRootPart").CFrame = farmpos
		pcall(function() LP.Backpack:FindFirstChild("Combat").Parent = LP.Character end)
		task.wait(0.25)
		RS:WaitForChild("Remotes"):WaitForChild("Combat"):FireServer("Light")
	end
end
end)

spawn(function()
while true do task.wait()
	RS:WaitForChild("Remotes"):WaitForChild("getData"):InvokeServer()
	for i,v in pairs(LP.PlayerGui.Gui.Inventory.InventoryVanity.Grid:children()) do task.wait()
		if string.find(v.Name, "Pill") then
			RS.Remotes.InventoryRequest:InvokeServer("Equip", {["Id"] = v.Name, ["Type"] = "Consumeable"})
			RS:WaitForChild("Remotes"):WaitForChild("getData"):InvokeServer()
		end
	end
end
end)










-------------------------------- LOGS --------------------------------

-- Stats Logs

spawn(function()
while true do 
	local data = RS:WaitForChild("Remotes"):WaitForChild("getData"):InvokeServer()
	local toprint = ("Qi: "..data["Qi"].."\nRealm: "..data["RealmTag"].."("..data["Realm"]..")".."\nTaels: "..data["Taels"])
	wh.Send(nil, LP.Name.."'s stats:", toprint, 0x26a300)
	task.wait(60*10)
end
end)

-- JoinLeave Logs

pp.PlayerAdded:connect(function(player)
	wh.Send(nil, "Player Joined", tostring(player.Name), 0x0050a3)
	player.Chatted:connect(function(msg)
		wh.Send(nil, tostring(player.Name), msg, 0x00a36d)
	end)
end)
pp.PlayerRemoving:connect(function(player)
	wh.Send(nil, "Player Exiting", tostring(player.name), 0x0050a3)
end)

-- Chat Logs

for i,v in pairs(pp:children()) do
	local player = v
	v.Chatted:connect(function(msg)
		wh.Send(nil, tostring(player.Name), msg, 0x00a36d)
	end)
end

--[[
game:GetService("ReplicatedStorage").Remotes.BuyItem:FireServer("Phil", "Body Tempering Pill")
game:GetService("ReplicatedStorage").Remotes.InventoryRequest:InvokeServer("Equip", {["Id"] = "Body Tempering Pill", ["Type"] = "Consumeable"})

game:GetService("ReplicatedStorage").Remotes.BuyItem:FireServer("Phil", "Grain Pill")
game:GetService("ReplicatedStorage").Remotes.InventoryRequest:InvokeServer("Equip", {["Id"] = "Grain Pill", ["Type"] = "Consumeable"})
game:GetService("ReplicatedStorage").Remotes.InventoryRequest:InvokeServer("Equip", {["Id"] = "Supreme Grain Pill", ["Type"] = "Consumeable"})
]]--