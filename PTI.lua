local msg = {}
msg.Notify = function(title, text, dur)
    if dur == nil then
        game.StarterGui:SetCore("SendNotification", {
            Title = tostring(title),
            Text = tostring(text),
            Duration = 1
        })
    elseif dur < 0 then
        game.StarterGui:SetCore("SendNotification", {
            Title = tostring(title),
            Text = tostring(text),
            Duration = math.huge
        })
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = tostring(title),
            Text = tostring(text),
            Duration = dur
        })
    end
end
game.UserInputService.InputBegan:connect(function(a,b)
	if a.KeyCode == Enum.KeyCode.F1 then
		for i=1,15 do task.wait()
			game:GetService("ReplicatedStorage").RemoteEvent:FireServer(1e18, "CultivationCurrent")
		end
		msg.Notify("Qi Gain", "Boosted Meditation")
	elseif a.KeyCode == Enum.KeyCode.F2 then
		for i,v in pairs(game.Players.LocalPlayer.Quest:children()) do
			for i1=1,15 do task.wait()
				local A_1 = v.Name
				local A_2 = game:GetService("Players").LocalPlayer.PlayerGui.Main.background.Power.Stats.StageShow.Text:gsub("Initial", ""):gsub("Early", ""):gsub("Mid", ""):gsub("Late", ""):gsub("Peak", "")
				local A_3 = 99
				local A_4 = v:FindFirstChild("Category").Value
				local A_5 = "Add"
				game:GetService("ReplicatedStorage").Quest:FireServer(A_1, A_2, A_3, A_4, A_5)
			end
		end
		msg.Notify("Quest Progress", "Fulled All Quests")
	elseif a.KeyCode == Enum.KeyCode.F3 then
		for i,v in pairs(game.Players.LocalPlayer.Laws:children()) do
			for i1=1,15 do task.wait()
				local A_1 = v.Name
				local A_2 = v:FindFirstChild("ProgressLimit").Value
				local A_3 = v:FindFirstChild("ProgressLimit").Value
				local A_4 = true
				local A_5 = v:FindFirstChild("Bonus").Value
				game:GetService("ReplicatedStorage").Law:FireServer(A_1, A_2, A_3, A_4, A_5)
			end
		end
		msg.Notify("Laws Progress", "All Laws Fulled")
	elseif a.KeyCode == Enum.KeyCode.F4 then
		for i=1,300 do
			game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Vitality Pill", "Add")
			game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Tiger Pill", "Add")
			game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Hawk Pill", "Add")
		end
		msg.Notify("Pills", "Given to inv, reset.")
	elseif a.KeyCode == Enum.KeyCode.F5 then
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Demon Charm", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Red Qi Ring", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("World's End", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Beserker", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Burning Soul", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Darkpearl", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Plagueborne Poison", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("River Blades", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Sea Blessing", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Sand Tobe", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Rock Ravine", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Earth Severing", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Extreme Force", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Lavaflow", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("One With Nature", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Lightning Call", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Heaven's Thunder", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Subtle Mind", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Fake World", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Shadow's Descent", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("Time Manipulation - Incomplete", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("", "Add")
		game:GetService("ReplicatedStorage").InventoryEvent:FireServer("", "Add")
		msg.Notify("Accesories", "Given 2")
	end
end)

