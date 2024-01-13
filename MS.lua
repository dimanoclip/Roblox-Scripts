-- https://www.roblox.com/games/14483332676
local World,Heaven = 14483332676, 15554349285
if game.PlaceId ~= World and game.PlaceId ~= Heaven then warn(string.format("Wrong game detected. %s expected, got %s", World, game.PlaceId)) return end
local scrollrem = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Player"):WaitForChild("Stats"):WaitForChild("ScrollRemote")
local talant = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Player"):WaitForChild("Stats"):WaitForChild("TalentRemote")
local phys = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Player"):WaitForChild("Stats"):WaitForChild("PhysiqueRemote")
local iboost = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Player"):WaitForChild("Cultivation"):WaitForChild("ItemBoost")
local breakt = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Player"):WaitForChild("Cultivation"):WaitForChild("BreakthroughRemote")
local LP = game:GetService("Players").LocalPlayer
local function getNil(name,class) for _,v in next, getnilinstances() do if v.ClassName==class and v.Name==name then return v;end end end

task.spawn(function()
    while true do task.wait(1)
        scrollrem:FireServer("Talent", 5, getNil("Talent Scroll", "Tool"))
        scrollrem:FireServer("Physique", 5, getNil("Physique Scroll", "Tool"))
    end
end)

task.spawn(function()
    while true do task.wait(0.3)
        if game.PlaceId == Heaven then
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
    end
end)

task.spawn(function()
    local limit = 99999999
    for i=1,limit do task.wait()
        iboost:FireServer(limit/2, limit, 600, getNil("True Fruit of Heaven", "Tool"))
    end
end)

task.spawn(function()
    for i=1,10000 do task.wait()
        breakt:FireServer("Breakthrough")
    end
end)