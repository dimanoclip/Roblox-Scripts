-- https://www.roblox.com/games/12603365593
if not game:IsLoaded() then game.Loaded:Wait() end
---------------------------------------------------------
local msg = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/messages.lua"))()
msg.Notify("Binds (Toggle)", "F1 - Train JF+MS  |  F2 - Train FS\nF3 - Auto Respawn  |  F4 - AutoEquip\nG - ClickTP", 3)
---------------------------------------------------------
local TrainMSJF,TrainFS,RespawnAssist,trainpos,ClickTP = false,false,false,nil,false
local P = game.Players
local LP = P.LocalPlayer
local mouse=LP:GetMouse()
local AutoEquip = {}
AutoEquip.State = false
AutoEquip.Tool = "None"
AutoEquip.LB = 0
---------------------------------------------------------
local UserInputService=game:GetService("UserInputService")
local RunService=game:GetService("RunService")
---------------------------------------------------------
local vu=game:GetService("VirtualUser")
LP.Idled:Connect(function() vu:CaptureController()vu:ClickButton2(Vector2.new()) end)
---------------------------------------------------------
local Events = {}
Events.Respawn = {"Respawn"}
Events.FS = {"Add_FS_Request"}
Events.MS = {"Add_MS_Request"}
Events.JF = {"Add_JF_Request"}
Events.Aura = {"ConcealRevealAura"}
RunService.Stepped:Connect(function()
	if TrainFS then game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(Events.FS) end
    if TrainMSJF then
		game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(Events.MS)
		game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(Events.JF)
	end
	if AutoEquip.State then
		if AutoEquip.Tool ~= "None" then
			if LP.Backpack:FindFirstChild(AutoEquip.Tool) ~= nil then
				LP.Backpack:FindFirstChild(AutoEquip.Tool).Parent = LP.Character
			end
		end
		if AutoEquip.LB ~= 0 then
			Events.ELB = {"EquipWeight_Request", AutoEquip.LB}
			game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(Events.ELB)
		end
	end
	if RespawnAssist then
   		if LP.Character:FindFirstChild("Humanoid") ~= nil and LP.Character.Humanoid.Health == 0 then
			game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(Events.Respawn)
			task.wait(1)
			game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(Events.Aura)
		end
		if LP.Character:FindFirstChild("ForceField") ~= nil then LP.Character:FindFirstChild("ForceField"):Remove() end
		game.Lighting.Blur.Enabled = false; LP.PlayerGui.ScreenGui.Enabled = true; LP.PlayerGui.IntroGui.Enabled = false
		if trainpos ~= nil and LP.Character:FindFirstChild("HumanoidRootPart") ~= nil then LP.Character.HumanoidRootPart.CFrame = trainpos end
	end
end)
---------------------------------------------------------
UserInputService.InputBegan:Connect(function(a,b)
	if a.KeyCode==Enum.KeyCode.F1 then TrainMSJF = not TrainMSJF
	    if TrainMSJF then msg.Notify("Train JF+MS", "Enabled")
		else msg.Notify("Train JF+MS", "Disabled") end
	elseif a.KeyCode==Enum.KeyCode.F2 then TrainFS = not TrainFS
	    if TrainFS then msg.Notify("Train FS", "Enabled")
		else msg.Notify("Train FS", "Disabled") end
	elseif a.KeyCode==Enum.KeyCode.F3 then RespawnAssist = not RespawnAssist
		if RespawnAssist and LP.Character:FindFirstChild("HumanoidRootPart") ~= nil then msg.Notify("Auto Respawn", "Enabled"); trainpos = LP.Character.HumanoidRootPart.CFrame
		else msg.Notify("Auto Respawn", "Disabled"); trainpos = nil end
	elseif a.KeyCode==Enum.KeyCode.F4 then AutoEquip.State = not AutoEquip.State
		if AutoEquip.State then msg.Notify("AutoEquip", "Enabled")
    	else msg.Notify("AutoEquip", "Disabled") end
	end
end)
UserInputService.InputBegan:Connect(function(a,b)
	if a.KeyCode==Enum.KeyCode.KeypadPlus then
		if AutoEquip.LB < 24 then AutoEquip.LB = AutoEquip.LB + 1; msg.Notify("AutoEquip", "LB: "..tostring(AutoEquip.LB)) end
	elseif a.KeyCode==Enum.KeyCode.KeypadMinus then
		if AutoEquip.LB > 0 then AutoEquip.LB = AutoEquip.LB - 1; if AutoEquip.LB == 0 then msg.Notify("AutoEquip", "LB: None");Events.ELB = {"EquipWeight_Request", 0}; game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(Events.ELB) else msg.Notify("AutoEquip", "LB: "..tostring(AutoEquip.LB)) end end
	end
end)
---------------------------------------------------------
UserInputService.InputBegan:Connect(function(a,b)
	if a.KeyCode==Enum.KeyCode.G then ClickTP = not ClickTP
		if ClickTP then msg.Notify("ClickTP", "Enabled")
    	else msg.Notify("ClickTP", "Disabled") end
	elseif a.KeyCode==Enum.KeyCode.PageUp then
		if ClickTP then LP.Character.HumanoidRootPart.CFrame = CFrame.new(LP.Character.HumanoidRootPart.CFrame.Position.x, LP.Character.HumanoidRootPart.CFrame.Position.y+200,LP.Character.HumanoidRootPart.CFrame.Position.z) end
	elseif a.KeyCode==Enum.KeyCode.PageDown then
		if ClickTP then LP.Character.HumanoidRootPart.CFrame = CFrame.new(LP.Character.HumanoidRootPart.CFrame.Position.x, LP.Character.HumanoidRootPart.CFrame.Position.y-200,LP.Character.HumanoidRootPart.CFrame.Position.z) end
	end
end)
mouse.Button1Down:Connect(function() if mouse.Target and ClickTP then LP.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.x, mouse.Hit.y + 5, mouse.Hit.z) end end)
---------------------------------------------------------
msg.Notify("Why not?", "KP1 - Equip Fists\nKP2 - Equip Push Ups\nKP3 - Equip Meditation", 5)
UserInputService.InputBegan:Connect(function(a,b)
	if a.KeyCode==Enum.KeyCode.KeypadZero then loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/rejoin.lua"))()
	elseif a.KeyCode==Enum.KeyCode.KeypadOne then
		if LP.Backpack:FindFirstChild("Fist Training") ~= nil then
			if AutoEquip.State then AutoEquip.Tool = "None"; msg.Notify("AutoEquip", "Tool: None") end
			LP.Backpack:FindFirstChild("Fist Training").Parent = LP.Character
			msg.Chat("Successfully equiped!", "Green")
		else msg.Chat("There is some problem...", "Red") end
	elseif a.KeyCode==Enum.KeyCode.KeypadTwo then
		if LP.Backpack:FindFirstChild("Push Up") ~= nil then
			if AutoEquip.State then AutoEquip.Tool = "None"; msg.Notify("AutoEquip", "Tool: None") end
			LP.Backpack:FindFirstChild("Push Up").Parent = LP.Character
			msg.Chat("Successfully equiped!", "Green")
		else msg.Chat("There is some problem...", "Red") end
	elseif a.KeyCode==Enum.KeyCode.KeypadThree then
		if LP.Backpack:FindFirstChild("Meditate") ~= nil then
			if AutoEquip.State then AutoEquip.Tool = "Meditate"; msg.Notify("AutoEquip", "Tool: Meditation"); LP.Character.Humanoid:UnequipTools() end
			LP.Backpack:FindFirstChild("Meditate").Parent = LP.Character
			msg.Chat("Successfully equiped!", "Green")
		else msg.Chat("There is some problem...", "Red") end
	end
end)