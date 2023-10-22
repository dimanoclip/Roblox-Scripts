local localPlayer = game.Players.LocalPlayer
localPlayer.Idled:Connect(function() game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end)
_G.QiAdd = 1
_G.ABT = true
task.spawn(function()
    while task.wait() do
        game:GetService("ReplicatedStorage"):WaitForChild("Event"):WaitForChild("AddQI"):FireServer(_G.QiAdd)
        if _G.ABT then
            game:GetService("ReplicatedStorage"):WaitForChild("Event"):WaitForChild("AnimC"):FireServer(3)
        end
    end
end)