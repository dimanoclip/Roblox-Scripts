-- https://www.roblox.com/games/4566572536
local PlaceId = 4566572536
if game.PlaceId ~= PlaceId then warn(string.format("Wrong game detected. %s expected, got %s", PlaceId, game.PlaceId)) return end
function getdist(pos)
    return math.floor(((game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")).Position - pos).magnitude)
end
function checkdist(car, dist)
    if car then
        if getdist(car.PrimaryPart.Position) < (dist or 15) then
            return true 
        else
            return false
        end
    end
end
function getcar(own)
    own = own or false
    for i, v in pairs(game:GetService("Workspace").Vehicles:GetChildren()) do 
        if own == true then
            if string.find(v.Name, game.Players.LocalPlayer.Name) then
                return v
            end
        else
            if checkdist(v) then
                return v 
            end
        end
    end
end
function getcars()
    local cars = {}
    for i, v in pairs(game:GetService("Workspace").Vehicles:GetChildren()) do 
        table.insert(cars, v)
    end
    return cars
end
local holding,free
local uis = game:GetService("UserInputService")
local holdingw,holdings,holdingctrl = false,false,false
local msg = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/messages.lua"))()
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/KavoUI.lua"))()
local gui = Library.CreateLib("Vehicle Legends", "Useless")
local main = gui:NewTab("Main")
local carboost = main:NewSection("Car Boost")
function modify(own)
    own = own or false
    local curcar = getcar(own)
    local MyForce = curcar.Weight.boostForce:Clone()
    MyForce.Name = "MyBoost"
    MyForce.Parent = curcar.Weight.boostForce.Parent
    local function boost()
        if curcar then 
            curcar.Weight.MyBoost.Force = curcar.Weight.CFrame.LookVector * 10000
        end
    end
    local function cboost()
        if curcar then 
            curcar.Weight.MyBoost.Force = curcar.Weight.CFrame.LookVector * 100000
        end
    end
    local function deboost()
        if curcar then 
            curcar.Weight.MyBoost.Force = curcar.Weight.CFrame.LookVector * (-15000)
        end
    end
    holding = uis.InputBegan:Connect(function(inpt)
        if inpt.KeyCode == Enum.KeyCode.W then
            holdingw = true
        elseif inpt.KeyCode == Enum.KeyCode.S then
            holdings = true
            curcar.Weight.MyBoost.Force = curcar.Weight.CFrame.LookVector * 0
        end
        if inpt.KeyCode == Enum.KeyCode.LeftControl then
            holdingctrl = true
        end
    end)
    free = uis.InputEnded:Connect(function(inpt)
        if inpt.KeyCode == Enum.KeyCode.W then
            holdingw = false
            curcar.Weight.MyBoost.Force = curcar.Weight.CFrame.LookVector * 0
        end
        if inpt.KeyCode == Enum.KeyCode.S then
            holdings = false
            curcar.Weight.MyBoost.Force = curcar.Weight.CFrame.LookVector * 0
        end
        if inpt.KeyCode == Enum.KeyCode.LeftControl then
            holdingctrl = false
            curcar.Weight.MyBoost.Force = curcar.Weight.CFrame.LookVector * 0
        end
    end)
    spawn(function()
        while task.wait() do 
            if holdingw and getdist(curcar.PrimaryPart.Position) <= 15 then
                boost()
            end
            if holdingctrl and getdist(curcar.PrimaryPart.Position) <= 15 then
                cboost()
            end
            if holdings and getdist(curcar.PrimaryPart.Position) <= 15 then
                deboost()
            end
            if getdist(curcar.PrimaryPart.Position) <= 50 and getdist(curcar.PrimaryPart.Position) > 15 then
                MyForce:Remove()
                holding:Disconnect()
                free:Disconnect()
                break
            end
        end
    end)
    msg.Notify("Modified "..curcar.Name)
end
carboost:NewButton("Modify Nearest Car", "It would modify ur nearest car", function(state)
    modify(false)
end)
carboost:NewButton("Modify Your Car", "It would modify ur car", function(state)
    modify(true)
end)
carboost:NewButton("Remove All Modifiers", "It would remove modifiers from every cars (if it possible)", function(state)
    for i,car in getcars() do
        pcall(function() car.Weight.MyBoost:Remove() end)
        holding:Disconnect()
        free:Disconnect()
    end
end)