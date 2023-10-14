if not game:IsLoaded() then game.Loaded:Wait() end
--Press F1 To Toggle ESP | F3 To Toggle Clicker--
local msg = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/messages.lua"))()
msg.Notify("Binds", "F1 - ESP\nF2 - Clicker")
local Toggle = true
local on
local PlayerName = "DisplayName"
local P = game:GetService("Players")
local LP = P.LocalPlayer
local mouse=LP:GetMouse()
local UserInputService=game:GetService("UserInputService")
local RunService=game:GetService("RunService")
local DB = false
-----------------------------------------------------------------
local vu=game:GetService("VirtualUser")
LP.Idled:connect(function()
vu:CaptureController()vu:ClickButton2(Vector2.new())
end)
-----------------------------------------------------------------
local ScreenGui=Instance.new("ScreenGui",LP.PlayerGui)
local IsEnabled=Instance.new("TextLabel",ScreenGui)
IsEnabled.Size=UDim2.new(0,55,0,15)
IsEnabled.BackgroundColor3=Color3.fromRGB(50,190,50)
IsEnabled.Visible=false
IsEnabled.Text="Enabled"
IsEnabled.TextScaled=true
IsEnabled.TextSize=11
IsEnabled.Font=Enum.Font.Code
local ESPT = function(PLR)
	local Icon = Instance.new("BillboardGui")
	local NameDist = Instance.new("TextLabel")
	Icon.Parent = PLR.Character.Head
	Icon.Name = "Icon"
	Icon.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Icon.Active = true
	Icon.AlwaysOnTop = true
	Icon.ExtentsOffset = Vector3.new(0, 1, 0)
	Icon.LightInfluence = 1.000
	Icon.Size = UDim2.new(0, 400, 0, 50)
	NameDist.Name = "NameDist"
	NameDist.Parent = Icon
	NameDist.BackgroundColor3 = PLR.TeamColor.Color
	NameDist.BackgroundTransparency = 1.000
	NameDist.Position = UDim2.new(0, 0, 0, 0)
	NameDist.Size = UDim2.new(0, 400, 0, 10)
	NameDist.Font = Enum.Font.IndieFlower
	NameDist.Text = "NIL"
	NameDist.TextColor3 = PLR.TeamColor.Color
	NameDist.TextSize = 18.000
	NameDist.TextWrapped = true
end
local ESPTF = function(PLR, ICON)
	local NameDist = Instance.new("TextLabel")
	NameDist.Name = "NameDist"
	NameDist.Parent = ICON
	NameDist.BackgroundColor3 = PLR.TeamColor.Color
	NameDist.BackgroundTransparency = 1.000
	NameDist.Position = UDim2.new(0, 0, 0, 0)
	NameDist.Size = UDim2.new(0, 400, 0, 10)
	NameDist.Font = Enum.Font.IndieFlower
	NameDist.Text = "NIL"
	NameDist.TextColor3 = PLR.TeamColor.Color
	NameDist.TextSize = 18.000
	NameDist.TextWrapped = true
end
local function CCB()
    vu:CaptureController();
    vu:ClickButton1(Vector2.new());
end 
-----------------------------------------------------------------
RunService.Stepped:Connect(function()
	if not Toggle then
		for i,v in pairs(P:GetChildren()) do
			if v.Character.Head:FindFirstChild("Icon") ~= nil then
				v.Character.Head:FindFirstChild("Icon"):Remove()
			end
		end
	end
	if DB then 
		return 
	end
	DB = true
	pcall(function()
		if Toggle then
			for i,v in pairs(P:GetChildren()) do
				if v:IsA("Player") then
					if v ~= game.Players.LocalPlayer then
						if v.Character ~= nil then
							if v.Character.Head:FindFirstChild("Icon") == nil then
								ESPT(v)
							else
								if v.Character.Head.Icon:FindFirstChild("NameDist") == nil then
									ESPTF(v, v.Character.Head.Icon)
								else
									if v.Character.Head:FindFirstChild("Icon").Enabled == false then
										v.Character.Head:FindFirstChild("Icon").Enabled = true
									else
										if v.Character.Head:FindFirstChild("Icon") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") ~= nil then
											local pos = math.floor(((game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")).Position - (v.Character:FindFirstChild("HumanoidRootPart")).Position).magnitude)
											v.Character.Head.Icon["NameDist"].Text = v[PlayerName].." | "..pos
										else
											if v.Character.Head:FindFirstChild("Icon") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil then
												v.Character.Head.Icon["NameDist"].Text = v[PlayerName]
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end)
	wait()
	DB = false
end)
RunService.Stepped:Connect(function()
   if on then
       CCB();
       IsEnabled.Visible=true
       IsEnabled.Position=UDim2.new(0,mouse.X+12.5,0,mouse.Y+25)
   else
       IsEnabled.Visible=false
   end
end)
-----------------------------------------------------------------
UserInputService.InputBegan:connect(function(a,b)
   if a.KeyCode==Enum.KeyCode.F1 then
       Toggle = not Toggle
   end
end)
UserInputService.InputBegan:connect(function(a,b)
   if a.KeyCode==Enum.KeyCode.F2 then
        on = not on
   end
end)