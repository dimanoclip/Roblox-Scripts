---@diagnostic disable-next-line: unbalanced-assignments
local ball, closest, settargethl = nil, {nil, 1e99, 1e99}
h = workspace.ChildAdded:Connect(function(child)
    if child.Name:find("CLIENT_BALL") then
        ball = child
    end
end)
local function hlplayer(ply, fillcolor, outlinecolor, transparency)
    fillcolor = fillcolor or Color3.fromRGB(0,0,0)
    outlinecolor = outlinecolor or Color3.fromRGB(255,255,255)
    transparency = transparency or 0
    local hl = Instance.new("Highlight")
    hl.Parent = ply.Character
    hl.FillColor = fillcolor
    hl.OutlineColor = outlinecolor
    hl.DepthMode = Enum.HighlightDepthMode.Occluded
    hl.FillTransparency = transparency
    return hl
end
local lp = game.Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait() and lp.Character
local mypp = char.PrimaryPart
lp.CharacterAdded:Connect(function(character)
    char = character
    mypp = character.PrimaryPart
end)
local net = workspace:WaitForChild("Map"):WaitForChild("BallNoCollide"):WaitForChild("Net")
workspace.ChildAdded:Connect(function(child)
    if child.Name == "map" then
        net = child:WaitForChild("BallNoCollide"):WaitForChild("Net")
    end
end)
task.spawn(function()
    while true do
		-- pcall(function() char:FindFirstChildOfClass('Highlight').OutlineColor = Color3.fromHSV(tick() % 7.5 / 7.5, 0.6, 0.6) end)
        -- pcall(function() char:FindFirstChildOfClass('Highlight').FillColor = Color3.fromHSV(tick() % 7.5 / 7.5, 0.6, 0.6) end)
        -- local aim = workspace.Map.BallNoCollide.Positions["2"]["1"]
        -- closest = {aim, (aim.Position-mypp.Position).magnitude}
        if closest[1] then
            local target = closest[1]
            local camera_lv =workspace.CurrentCamera.CFrame.LookVector
            local hit_dist = math.floor((target.Position-(mypp.Position+Vector3.new(camera_lv.X, mypp.CFrame.LookVector.Y, camera_lv.Z)*50)).magnitude)
            local me_dist = math.floor((target.Position-mypp.Position).magnitude)
            closest[2] = hit_dist
            closest[3] = me_dist
        end
        for i,v in pairs(game.Players:GetChildren()) do task.wait()
            if v.Team ~= lp.Team or v == lp or not v.Character or not net then continue end
            local pp = v.Character.PrimaryPart
            local camera_lv =workspace.CurrentCamera.CFrame.LookVector
            local hit_dist = math.floor((pp.Position-(mypp.Position+Vector3.new(camera_lv.X, mypp.CFrame.LookVector.Y, camera_lv.Z)*50)).magnitude)
            -- local net_dist = math.floor((pp.Position-net.Position).magnitude)
            local me_dist = math.floor((pp.Position-mypp.Position).magnitude)
            if hit_dist < closest[2] then
                closest = {pp, hit_dist, me_dist}
                -- print(v.Name)
                if settargethl then settargethl:Destroy() end
                settargethl = hlplayer(v, Color3.fromRGB(100,40,255), nil, 0.5)
            end
            -- if pp.Position.y > 2 or me_dist < closest[3] and me_dist >= 5 then closest = {pp, net_dist, me_dist} end
        end
        task.wait(0.1)
    end
end)
local interact = game:GetService("ReplicatedStorage"):WaitForChild("Packages")._Index["sleitnick_knit@1.7.0"].knit.Services.BallService.RF.Interact
-- local hitbox = game:GetService("ReplicatedStorage"):WaitForChild("Packages")._Index["sleitnick_knit@1.7.0"].knit.Services.BallService.RF.CreateHitbox
local x
x = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    if self == interact and args[1]["Action"] == "JumpSet" then
        local tilt = args[1]["TiltDirection"]
        if closest[1] then
            local target = closest[1]
            local actpos = Vector3.new(target.Position.x, target.Position.y+1.5, target.Position.z)
            local cf = CFrame.new(actpos + target.CFrame.LookVector*1.5, actpos)
            if closest[3] <= 3 then tilt = Vector3.yAxis
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
    end
    return x(self, ...)
end)