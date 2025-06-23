local ball, closest = nil, {}
h = workspace.ChildAdded:Connect(function(child)
    if child.Name:find("CLIENT_BALL") then
        ball = child
    end
end)
local function hlplayer(ply)
    local hl = Instance.new("Highlight")
    hl.Parent = ply.Character
    hl.DepthMode = Enum.HighlightDepthMode.Occluded
    hl.FillTransparency = 0.8
end
local lp = game.Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait() and lp.Character
local mypp = char.PrimaryPart
lp.CharacterAdded:Connect(function(character)
    hlplayer(lp)
    char = character
    mypp = character.PrimaryPart
end)
hlplayer(lp)
local net = workspace:WaitForChild("Map").BallNoCollide.Net
workspace.ChildAdded:Connect(function(child)
    if child.Name == "map" then
        net = child:WaitForChild("BallNoCollide"):WaitForChild("Net")
    end
end)
task.spawn(function()
    while true do
		-- pcall(function() char:FindFirstChildOfClass('Highlight').OutlineColor = Color3.fromHSV(tick() % 7.5 / 7.5, 0.6, 0.6) end)
        -- pcall(function() char:FindFirstChildOfClass('Highlight').FillColor = Color3.fromHSV(tick() % 7.5 / 7.5, 0.6, 0.6) end)
		pcall(function() char:FindFirstChildOfClass('Highlight').OutlineColor = Color3.fromRGB(255,255,255) end)
        pcall(function() char:FindFirstChildOfClass('Highlight').FillColor = Color3.fromRGB(0,0,0) end)
        pcall(function() workspace:FindFirstChild("BallShadowIndicator").SurfaceGui.Frame.UIStroke.Color = Color3.fromHSV(tick() % 7.5 / 7.5, 0.6, 0.6) end)
        pcall(function() workspace:FindFirstChild("HitIndicator").Color = Color3.fromHSV(tick() % 7.5 / 7.5, 0.6, 0.6) end)
        -- local aim = workspace.Map.BallNoCollide.Positions["2"]["1"]
        -- closest = {aim, (aim.Position-mypp.Position).magnitude}
        closest = {nil, 1e99, 1e99}
        for i,v in pairs(game.Players:GetChildren()) do task.wait()
            if v.Team ~= lp.Team or v == lp or not v.Character or not net then continue end
            local pp = v.Character.PrimaryPart
            local net_dist = math.floor((pp.Position-net.Position).magnitude)
            local me_dist = math.floor((pp.Position-mypp.Position).magnitude)
            if net_dist < closest[2] then closest = {pp, net_dist, me_dist} end
            if pp.Position.y > 2 or me_dist < closest[3] then closest = {pp, net_dist, me_dist} end
        end
        task.wait(0.1)
    end
end)
local interact = game:GetService("ReplicatedStorage"):WaitForChild("Packages")._Index["sleitnick_knit@1.7.0"].knit.Services.BallService.RF.Interact
-- local hitbox = game:GetService("ReplicatedStorage"):WaitForChild("Packages")._Index["sleitnick_knit@1.7.0"].knit.Services.BallService.RF.CreateHitbox
local x, setid
x = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    if self == interact and args[1]["Action"] == "JumpSet" then
        local tilt = args[1]["TiltDirection"]
        if closest[1] then
            local target = closest[1]
            local actpos = Vector3.new(target.Position.x, target.Position.y+1.5, target.Position.z)
            local cf = CFrame.new(actpos + target.CFrame.LookVector*1.4, actpos)
            if closest[3] <= 5 then tilt = Vector3.yAxis
            else tilt = (cf.Position-ball.PrimaryPart.Position).Unit or tilt end
        end
        return x(self, {
            ["Charge"] = 1,
            ["Action"] = args[1]["Action"],
            ["SpecialCharge"] = 1,
            ["TiltDirection"] = tilt,
            ["BallId"] = args[1]["BallId"],
            ["MoveDirection"] = args[1]["MoveDirection"],
            ["From"] = args[1]["From"],
            ["HitboxSize"] = args[1]["HitboxSize"],
            ["LookVector"] = args[1]["LookVector"]
        })
    elseif self == interact and args["Action"] == "Set" and args[1]["Key"] == setid and args[1]["SpecialCharge"] ~= 1 then return
    end
    return x(self, ...)
end)