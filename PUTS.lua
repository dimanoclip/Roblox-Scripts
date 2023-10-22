--https://www.roblox.com/games/14506995572
local PlaceId = 14506995572
if game.PlaceId ~= PlaceId then warn(string.format("Wrong game detected. %s expected, got %s", PlaceId, game.PlaceId)) return end

local lply = game.Players.LocalPlayer
local pgui = lply:WaitForChild("PlayerGui")
local pullups = require(game:GetService("ReplicatedStorage").ModuleScript)["List"]
task.spawn(function()
    while task.wait() do
        local pup = lply.Backpack:FindFirstChildOfClass("Tool") or lply.Character:FindFirstChildOfClass("Tool")
        pup:WaitForChild("GainStrength").GainStrength:FireServer("LoadAntiCheat")
        pgui.MainGui.UpgradeFrame.UpgradeButton.UpgradePullUp.UpgradePullUp:FireServer(pgui.MainGui.UpgradeFrame.Next.Namee.TextLabel.Text)
    end
end)