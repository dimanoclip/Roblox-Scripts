while true do task.wait()
    for i,v in pairs(game.workspace:children()) do
        if v.Name.lower() == "orbs" and #v:children() > 0 then
            for i1,orb in pairs(v:children()) do task.wait()
                game:GetService("ReplicatedStorage"):WaitForChild("Remote"):FireServer("Orbs", "Absorb", orb.Name)
            end
        end
    end
end

while task.wait() do 
    local args = {
        [1] = "Pet",
        [2] = "Egg",
        [3] = "Hatch",
        [4] = "Easter Egg",
        [5] = 3
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):FireServer(unpack(args))
end