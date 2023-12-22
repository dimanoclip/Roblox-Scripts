-- https://www.roblox.com/games/14483332676
local PlaceId = 14483332676
if game.PlaceId ~= PlaceId then warn(string.format("Wrong game detected. %s expected, got %s", PlaceId, game.PlaceId)) return end
local scrollrem = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Player"):WaitForChild("Stats"):WaitForChild("ScrollRemote")
local talant = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Player"):WaitForChild("Stats"):WaitForChild("TalentRemote")
local phys = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Player"):WaitForChild("Stats"):WaitForChild("PhysiqueRemote")
local iboost = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Player"):WaitForChild("Cultivation"):WaitForChild("ItemBoost")
local LP = game:GetService("Players").LocalPlayer
local function getNil(name,class) for _,v in next, getnilinstances() do if v.ClassName==class and v.Name==name then return v;end end end

task.spawn(function()
    while true do task.wait(0.5)
        scrollrem:FireServer("Talent", 10, getNil("Talent Scroll", "Tool"))
        scrollrem:FireServer("Physique", 10, getNil("Physique Scroll", "Tool"))
    end
end)

task.spawn(function()
    while true do task.wait(0.3)
        if LP.PlrStats.TalentSpins.Value > 50 then
            if LP.PlrStats.Talent.Value ~= 10 then
                talant:FireServer("Spin")
            end
        end
        if LP.PlrStats.PhysiqueSpins.Value > 50 then
            if not (string.find(LP.PlrStats.Physique.Value, "Sacred") and string.find(LP.PlrStats.Physique.Value, "Peak")) then
                phys:FireServer("Spin")
            end
        end
    end
end)

task.spawn(function()
    local limit = 500000
    for i=1,limit do task.wait()
        iboost:FireServer(limit/2, limit, 600, getNil("True Fruit of Heaven", "Tool"))
    end
end)