-- https://www.roblox.com/games/13820774692
local PlaceId = 13820774692
if game.PlaceId ~= PlaceId then warn(string.format("Wrong game detected. %s expected, got %s", PlaceId, game.PlaceId)) return end
local vim = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/virtinp.lua"))()
spawn(function()
	while true do task.wait()
		for i,v in pairs(game:GetService("Workspace").UsedInScripts.TrainMics:children()) do task.wait()
			local args = {
			    [1] = "Bars",
			    [2] = v.Name
			}
			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild(game.Players.LocalPlayer.Name):FireServer(unpack(args))
			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild(game.Players.LocalPlayer.Name):FireServer(unpack(args))
			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild(game.Players.LocalPlayer.Name):FireServer(unpack(args))
		end
	end
end)
spawn(function()
	while true do task.wait()
		for i,v in pairs(game:GetService("Workspace").UsedInScripts.Train:children()) do task.wait()
			local args = {
			    [1] = "RapPower",
			    [2] = v.Name
			}
			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild(game.Players.LocalPlayer.Name):FireServer(unpack(args))
			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild(game.Players.LocalPlayer.Name):FireServer(unpack(args))
			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild(game.Players.LocalPlayer.Name):FireServer(unpack(args))
		end
	end
end)
spawn(function()
	while true do
		if game:GetService("Players").LocalPlayer.PlayerGui.Main.Fight.AbsolutePosition.X > 700 then
			for i,v in pairs(game:GetService("Workspace").UsedInScripts.Battle:children()) do
				if math.floor(((game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")).Position - v.Position).magnitude) <= 4 then
					local args = {
					    [1] = v.Name
					}
					game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Auto"):FireServer(unpack(args))
					local plyw = game.Players.LocalPlayer.plrValues.Wins.Value
					repeat task.wait() vim.CenterMouseClick() until plyw ~= game.Players.LocalPlayer.plrValues.Wins.Value
					game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Rebirth"):InvokeServer()
				end
			end
		end
		task.wait(1)
	end
end)