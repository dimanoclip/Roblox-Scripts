-- https://www.roblox.com/games/6461766546
local PlaceId = 6461766546
if game.PlaceId ~= PlaceId then warn(string.format("Wrong game detected. %s expected, got %s", PlaceId, game.PlaceId)) return end
if not game:IsLoaded() then game.Loaded:Wait() end
_G.working = false; task.wait(0.5); _G.working = true
local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local SettingsLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/SaveSettingsLibrary.lua"))()
local InputLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Suricato006/Scripts-Made-by-me/master/Libraries/InputFunctions%20Library.lua"))()
local msg = loadstring(game:HttpGet("https://raw.githubusercontent.com/dimanoclip/Roblox-Luas/refs/heads/main/Libs/msgs.lua"))()
local convs = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/Libs/convs.lua"))()
msg.Notify("Welcome", "Thank you for using my script.\nGood luck and have fun!", 5)
local Players = game.Players
local Player = Players.LocalPlayer
local Character = Player.Character
local UserInputService=game:GetService("UserInputService")
Character:WaitForChild('CharacterOutline').Enabled = true
local Humanoid = Character:WaitForChild('Humanoid')
local RootPart = Character:WaitForChild('HumanoidRootPart')
local PG = Player.PlayerGui
local RP = game:GetService("ReplicatedStorage")
local net = RP:WaitForChild("Modules"):WaitForChild("Net")
local CombatEvent = net:WaitForChild("RE/CombatEvent")
local UpgradeStat = net:WaitForChild("RE/UpgradeStat")
local UpgradeAscendStat = net:WaitForChild("RE/UpgradeAscendantStat")
local Quest = net:WaitForChild("RE/Quest")
local StoreClass = net:WaitForChild("RE/StoreClass")
local Ascend = net:WaitForChild("RE/Ascend")
local SpinClass = net:WaitForChild("RF/SpinClass")
local PurchaseSpin = net:WaitForChild("RE/PurchaseSpin")
local PurchaseAscendantSpin = net:WaitForChild("RE/PurchaseAscendantSpin")
local EquipRelic = net:WaitForChild("RE/EquipRelic")
local PurchaseClothing = net:WaitForChild("RF/PurchaseClothing")
local EquipPants = net:WaitForChild("RE/EquipPants")
local EquipShirt = net:WaitForChild("RE/EquipShirt")
local function getdata()
	local data = net:WaitForChild("RF/GetData"):InvokeServer()
	data = data.Slots[data.ActiveSlot]
	return data
end
PurchaseClothing:InvokeServer("Monarch")
local train = function() CombatEvent:FireServer("Train") end
local FileName = "AHeroDestiny.CRAB"
local SettingsTable = SettingsLibrary.LoadSettings(FileName)
local bb=game:GetService('VirtualUser')
Player.Idled:Connect(function() bb:CaptureController()bb:ClickButton2(Vector2.new()) end)
local function RemoteAttack(Number, AttackPosition)
	local class = getdata().Class
	if class == "Angel" then
		class = "Puri Puri"
	elseif class == "Toxin" then
		class = "Broly"
	end
	local ClassString = string.gsub(class, " ", "")
	local AttackArg = ClassString.."Attack"..tostring(Number)
	CombatEvent:FireServer(AttackArg, AttackPosition)
end
local function AwakeningBug()
	if Player:GetAttribute("Form") ~= "" then return end
	StoreClass:FireServer(1); task.wait(0.08)
	RemoteAttack(6, nil); task.wait(0.08)
	Ascend:FireServer(); task.wait(0.08)
	Ascend:FireServer(); task.wait(0.08)
	StoreClass:FireServer(1)
end
AwakeningBug()
local function IncreseStat(stat: number, amount: number, ascendant: boolean)
	if stat == 1 then
		if ascendant then UpgradeAscendStat:FireServer("Authority", amount) end
	elseif stat == 2 then
		if ascendant then UpgradeAscendStat:FireServer("Presence", amount)
		else UpgradeStat:FireServer('Health', amount) end
	elseif stat == 3 then
			if ascendant then UpgradeAscendStat:FireServer("Grace", amount)
			else UpgradeStat:FireServer('Form', amount) end
	end
end

local function WearOutfit(name) EquipPants:FireServer(name); EquipShirt:FireServer(name) end
WearOutfit("Monarch")

local function DistAttack(target)
	local class = getdata().Class
    if not target:FindFirstChild('HumanoidRootPart') then return end
	local pos = target:FindFirstChild('HumanoidRootPart').Position
	if class == "Limitless" then
		CombatEvent:FireServer("LimitlessAttack5", pos)
	elseif class == "Cosmic" then
		CombatEvent:FireServer("CosmicAttack1", pos); task.wait(0.5); if not target:FindFirstChild('Humanoid') or target:FindFirstChild('Humanoid').Health <= 0 then return end
		CombatEvent:FireServer("CosmicAttack2", pos); task.wait(0.5); if not target:FindFirstChild('Humanoid') or target:FindFirstChild('Humanoid').Health <= 0 then return end
	elseif class == "Blast" then
		CombatEvent:FireServer("BlastAttack2", pos)
	elseif class == "Bing Bong" then
		CombatEvent:FireServer("BingBongAttack5", pos)
	elseif class == "Frost Phoenix" then
		CombatEvent:FireServer("FrostPhoenixAttack2", pos)
	elseif class == "Atomic" then
		CombatEvent:FireServer("AtomicAttack2", Vector3.New(pos.X+10, pos.Y, pos.Z-10), Vector3.New(-0.5, 0, 0.5)); task.wait(0.5); if not target:FindFirstChild('Humanoid') or target:FindFirstChild('Humanoid').Health <= 0 then return end
		CombatEvent:FireServer("AtomicAttack5", pos); task.wait(0.5); if not target:FindFirstChild('Humanoid') or target:FindFirstChild('Humanoid').Health <= 0 then return end
	elseif class == "Esoteric Knight" then
		CombatEvent:FireServer("EsotericKnightAttack5", pos)
	elseif class == "Psycho" then
		CombatEvent:FireServer("PsychoAttack1", pos); task.wait(0.5); if not target:FindFirstChild('Humanoid') or target:FindFirstChild('Humanoid').Health <= 0 then return end
		CombatEvent:FireServer("PsychoAttack2", pos); task.wait(0.5); if not target:FindFirstChild('Humanoid') or target:FindFirstChild('Humanoid').Health <= 0 then return end
		CombatEvent:FireServer("PsychoAttack5", pos); task.wait(0.5); if not target:FindFirstChild('Humanoid') or target:FindFirstChild('Humanoid').Health <= 0 then return end
		CombatEvent:FireServer("PsychoAttack3", pos); task.wait(0.5); if not target:FindFirstChild('Humanoid') or target:FindFirstChild('Humanoid').Health <= 0 then return end
	elseif class == "Slime" then
		CombatEvent:FireServer("SlimeAttack1", Vector3.new(pos.X, pos.Y+50, pos.Z), pos); task.wait(0.5); if not target:FindFirstChild('Humanoid') or target:FindFirstChild('Humanoid').Health <= 0 then return end
		CombatEvent:FireServer("SlimeAttack2", pos); task.wait(0.5); if not target:FindFirstChild('Humanoid') or target:FindFirstChild('Humanoid').Health <= 0 then return end
		CombatEvent:FireServer("SlimeAttack5", Vector3.new(pos.X, pos.Y+50, pos.Z), pos); task.wait(0.5); if not target:FindFirstChild('Humanoid') or target:FindFirstChild('Humanoid').Health <= 0 then return end
		CombatEvent:FireServer("SlimeAttack3", pos); task.wait(0.5); if not target:FindFirstChild('Humanoid') or target:FindFirstChild('Humanoid').Health <= 0 then return end
	elseif class == "Infinity" then
		CombatEvent:FireServer("InfinityAttack1", Vector3.new(pos.X, pos.Y+50, pos.Z), pos); task.wait(0.5); if not target:FindFirstChild('Humanoid') or target:FindFirstChild('Humanoid').Health <= 0 then return end
		CombatEvent:FireServer("InfinityAttack2", pos); task.wait(0.5); if not target:FindFirstChild('Humanoid') or target:FindFirstChild('Humanoid').Health <= 0 then return end
	elseif class == "Malevolent" then
		CombatEvent:FireServer("MalevolentAttack1", pos); task.wait(0.5); if not target:FindFirstChild('Humanoid') or target:FindFirstChild('Humanoid').Health <= 0 then return end
		CombatEvent:FireServer("MalevolentAttack3", pos); task.wait(0.5); if not target:FindFirstChild('Humanoid') or target:FindFirstChild('Humanoid').Health <= 0 then return end
		CombatEvent:FireServer("MalevolentAttack5", Vector3.new(pos.X, pos.Y+50, pos.Z), pos); task.wait(0.5); if not target:FindFirstChild('Humanoid') or target:FindFirstChild('Humanoid').Health <= 0 then return end
	elseif class == "Rose" then
		CombatEvent:FireServer("RoseAttack3", pos)
	end
end

local function punch(target) CombatEvent:FireServer("PunchHit", {target}) end

local function anchor_teleport_return(target, callback)
	local lastpos = RootPart.CFrame
	for _,v in pairs(Character:GetDescendants()) do if v:IsA('BasePart') and v.CanCollide then v.CanCollide = false end end
	RootPart.Anchored = false
	RootPart.Velocity = Vector3.new(0,0,0)
	Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(target.PrimaryPart.Position.X, target.PrimaryPart.Position.Y-20, target.PrimaryPart.Position.Z)
	task.wait(0.1)
	RootPart.Anchored = true
	callback()
	RootPart.Anchored = false
	for _,v in pairs(Character:GetDescendants()) do if v:IsA('BasePart') and not v.CanCollide then v.CanCollide = true end end
	RootPart.CFrame = lastpos
end

local function DestroyQuest()
	if Player:FindFirstChild('Quest') then
		Player:FindFirstChild('Quest'):Destroy()
	end
end

local function TakeQuest(Ascendant, id)
	if Player:FindFirstChild('Quest') then 
		local quest = Player:WaitForChild('Quest')
		if quest:FindFirstChild('Number') and quest:FindFirstChild('AscendantQuest') then
			local quest_info = {quest.Number.Value, quest.AscendantQuest.Value}
			if quest_info[1] ~= id and quest_info[2] ~= Ascendant then DestroyQuest() end
		end
	end
	Quest:FireServer(Ascendant and "GetAscendantQuest" or "GetQuest", id)
end

local Useless = Material.Load({
	Title = "A Hero Dentiny",
	Style = 1,
	SizeX = 500,
	SizeY = 350,
	Theme = "Mocha",
})

local function convert(text)
	if text:sub(-1):lower() == "b" then return tonumber(text:sub(1, #text-1), 10)*1e9
	elseif text:sub(-1):lower() == "m" then return tonumber(text:sub(1, #text-1), 10)*1e6
	else return tonumber(text:gsub(',',''), 10) end
end

local Quests = Useless.New({
	Title = "Quests"
})
local QuestsData = {}
local QuestTable = {}

for i, v in pairs(require(RP.Modules.Quests)) do
	v.id = i
	v.Ascendant = false
	QuestsData[v.Target] = v
	QuestTable[v.Target] = false 
end
for i, v in pairs(require(RP.Modules.AscendantQuests)) do
	v.id = i
	v.Ascendant = false
	QuestsData[v.Target] = v
	QuestTable[v.Target] = false 
end

if SettingsTable.SavedTable then
    for i, v in pairs(QuestTable) do
        if not SettingsTable.SavedTable[i] then
            SettingsTable.SavedTable[i] = false
        end
    end
else
    SettingsTable.SavedTable = QuestTable
end

local function start_killing(target)
    if not target.Parent:FindFirstChild(target.Name) then return end
	if SettingsTable.PunchAttacks and SettingsTable.AutoFinishQuests then
		anchor_teleport_return(target, function()
			repeat task.wait(0.1)
				if not SettingsTable.AutoFinishQuests then break end
				punch(target)
			until not Player:FindFirstChild('Quest')
		end)
        if SettingsTable.AutoBuySpins then PurchaseSpin:FireServer(true); PurchaseAscendantSpin:FireServer(true) end
	elseif SettingsTable.DistAttacks and SettingsTable.AutoFinishQuests then
        repeat task.wait(0.1)
            if not SettingsTable.AutoFinishQuests then break end
            DistAttack(target)
        until not Player:FindFirstChild('Quest')
        if SettingsTable.AutoBuySpins then PurchaseSpin:FireServer(true); PurchaseAscendantSpin:FireServer(true) end
	end
	DestroyQuest()
end

local function quest_finishing(quest_data)
	local model = workspace.Spawns:FindFirstChild(quest_data.Target):FindFirstChildOfClass("Model")
	if not model then return end
	local humanoid = model:FindFirstChild("Humanoid")
	if not humanoid or humanoid and humanoid.Health <= 0 then return end
	TakeQuest(SettingsTable.AscendantMode, quest_data.id)
	while Player:FindFirstChild('Quest') do task.wait()
		for i, v in pairs(workspace.Spawns:GetChildren()) do
			if v.Name == quest_data.Target then
				local target = v:FindFirstChild(quest_data.Target)
                if not target or not target:FindFirstChild('Humanoid') or target:FindFirstChild('Humanoid').Health == 0 then return end
                start_killing(target)
				print('killed '..target.Name)
			end
		end
        if SettingsTable.AutoBuySpins then PurchaseSpin:FireServer(true); PurchaseAscendantSpin:FireServer(true) end
	end
end

Quests.Toggle({Text = "Auto Quests", Callback = function(Value) 
	SettingsTable.AutoFinishQuests = Value 
	task.spawn(function()
		local success, err = pcall(function()
			while SettingsTable.AutoFinishQuests do task.wait()
				for target, state in pairs(SettingsTable.SavedTable) do
					if state and SettingsTable.AutoFinishQuests then
						local data = QuestsData[target]
						quest_finishing(data)
					end
				end
			end
		end)
		if err then error(err) end
	end)
end, Enabled = false})
Quests.Toggle({Text = "Only Distance Attacks", Callback = function(Value)  SettingsTable.DistAttacks = Value end, Enabled = SettingsTable.DistAttacks})

local QuestsDataTable = Quests.DataTable({
	Text = "Chipping away",
	Callback = function(ChipSet)
        for i, v in pairs(ChipSet) do
			QuestTable[i] = v
            SettingsTable.SavedTable[i] = v
        end
	end,
	Options = SettingsTable.SavedTable
})

local SpinTab = Useless.New({
	Title = "Spins"
})

local SpinTable = {}
local SpinToggle = nil
SpinToggle = SpinTab.Toggle({
	Text = "AutoSpin",
	Callback = function(Value)
		SettingsTable.AutoSpin = Value
		local class = getdata().Class
		coroutine.wrap(function()
			while SettingsTable.AutoSpin do task.wait()
				if class == "G.O.D." then class = "Beerus"
				elseif class == "Toxin" then class = "Broly"
				end
				for i, v in pairs(SpinTable) do
					if SpinTable[class] then
						SpinToggle:SetState(false)
						return
					end
				end
				if not SettingsTable.AscendantMode then class = SpinClass:InvokeServer() else class = SpinClass:InvokeServer("Ascendant") end
			end
		end)()
	end,
	Enabled = SettingsTable.AutoSpin
})

SpinTab.Button({
	Text = "BuySpins",
	Callback = function()
		PurchaseSpin:FireServer(true); PurchaseAscendantSpin:FireServer(true)
	end,
})

SpinBuyToggle = SpinTab.Toggle({
	Text = "AutoBuySpins",
	Callback = function(Value)
		SettingsTable.AutoBuySpins = Value
	end,
	Enabled = SettingsTable.AutoBuySpins
})

for i, v in pairs(require(RP.Modules.Classes).Lucky) do SpinTable[v.Item] = false end
for i, v in pairs(require(RP.Modules.Classes).AscendantLucky) do SpinTable[v.Item] = false end

if SettingsTable.SpinsTable then
    for i, v in pairs(SpinTable) do
        if not SettingsTable.SpinsTable[i] then
            SettingsTable.SpinsTable[i] = false
        end
    end
else
    SettingsTable.SpinsTable = SpinTable
end

SpinTab.DataTable({
	Text = "Chipping away",
	Callback = function(ChipSet)
		for i, v in pairs(ChipSet) do
			SpinTable[i] = v
			SettingsTable.SpinsTable[i] = v
		end
	end,
	Options = SettingsTable.SpinsTable 
})

local Misc = Useless.New({
	Title = "Misc"
})

Misc.Toggle({Text = "Ascendant mode", Callback = function(Value) SettingsTable.AscendantMode = Value
end, Enabled = SettingsTable.AscendantMode})

Misc.Label({Text = "AutoStats",})

Misc.Toggle({Text = "Strength", Callback = function(Value) SettingsTable.AutoStrength = Value end, Enabled = SettingsTable.AutoStrength and SettingsTable.AscendantMode})
local StrengthValue = Misc.TextField({Text = "Points", Callback = function(Value) SettingsTable.AutoStrengthValue = tonumber(Value) end, type="Default"})
Misc.Toggle({Text = "Health", Callback = function(Value) SettingsTable.AutoHealth = Value end, Enabled = SettingsTable.AutoHealth})
local HealthValue = Misc.TextField({Text = "Points", Callback = function(Value) SettingsTable.AutoHealthValue = tonumber(Value) end, type="Default"})
Misc.Toggle({Text = "Form", Callback = function(Value) SettingsTable.AutoForm = Value end, Enabled = SettingsTable.AutoForm})
local formValue = Misc.TextField({Text = "Points", Callback = function(Value) SettingsTable.AutoFormValue = tonumber(Value) end, type="Default"})

if SettingsTable.AutoStrengthValue then StrengthValue:SetText(tostring(SettingsTable.AutoStrengthValue)) end
if SettingsTable.AutoHealthValue then HealthValue:SetText(tostring(SettingsTable.AutoHealthValue)) end
if SettingsTable.AutoFormValue then formValue:SetText(tostring(SettingsTable.AutoFormValue)) end

Misc.Label({Text = "General",})
Misc.Button({Text = "ReJoin", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/rejoin.lua"))() end})
Misc.Button({Text = "ServerHop", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/Roblox-Luas/main/serverhop.lua"))() end})

game:GetService("RunService").Stepped:Connect(function()
	WearOutfit("Monarch")
	CombatEvent:FireServer("FlightOff")
	train()
	SettingsLibrary.SaveSettings(FileName, SettingsTable)
end)

task.spawn(function()
	while task.wait() do
		if not _G.working then break end
		pcall(function() Character:FindFirstChildOfClass('Highlight').OutlineColor = Color3.fromHSV(tick() % 7.5 / 7.5, 0.6, 0.6) end)
		if SettingsTable.AutoHealth then IncreseStat(2, SettingsTable.AutoHealthValue, SettingsTable.AscendantMode) end
		if SettingsTable.AutoForm then IncreseStat(3, SettingsTable.AutoFormValue, SettingsTable.AscendantMode) end
		if SettingsTable.AutoStrength then IncreseStat(1, SettingsTable.AutoStrengthValue, SettingsTable.AscendantMode) end
	end
end)

if not _G.DamageIndicators then
	for i, mob in pairs(workspace.Spawns:GetChildren()) do
		if mob:FindFirstChildOfClass("Model") then
			local model = mob:FindFirstChildOfClass("Model")
			local humanoid = model:FindFirstChild("Humanoid")
			local max_health = humanoid.MaxHealth
			local needed_dmg = max_health/100*15
			local healthbar = model:FindFirstChild('HumanoidRootPart'):FindFirstChild('HealthBar')
			if not healthbar then continue end
			local nametitle = healthbar.BG.NameLabel
			local name = nametitle.Text
			nametitle.Text = string.format("%s (%s %s)", name, convs.ToLetters(needed_dmg), humanoid.health <= max_health-needed_dmg and "✔" or "❌")
			humanoid.HealthChanged:Connect(function(health)
				nametitle.Text = string.format("%s (%s %s)", name, convs.ToLetters(needed_dmg), health <= max_health-needed_dmg and "✔" or "❌")
			end)
		end
		mob.ChildAdded:Connect(function(model)
			local humanoid = model:WaitForChild("Humanoid")
			if SettingsTable.SavedTable[model.Name] or QuestTable[model.Name] then msg.Notify('Notification', string.format('%s just respawned!', model.Name), 3) end
			local max_health = humanoid.MaxHealth
			local needed_dmg = max_health/100*15
			local healthbar = model:WaitForChild('HumanoidRootPart'):FindFirstChild('HealthBar')
			local nametitle = healthbar.BG.NameLabel
			local name = nametitle.Text
			nametitle.Text = string.format("%s (%s %s)", name, convs.ToLetters(needed_dmg), humanoid.health <= max_health-needed_dmg and "✔" or "❌")
			humanoid.HealthChanged:Connect(function(health)
				nametitle.Text = string.format("%s (%s %s)", name, convs.ToLetters(needed_dmg), health <= max_health-needed_dmg and "✔" or "❌")
			end)
		end)
	end
	_G.DamageIndicators = true
end

local autoquestmode = ""
PG.GameGui.MenuContainer.TeleportMenu.Sky.MouseButton1Click:Connect(function() autoquestmode = "Ascendant" end)
PG.GameGui.MenuContainer.TeleportMenu.Earth.MouseButton1Click:Connect(function() autoquestmode = "" end)
PG.GameGui.MenuContainer.TeleportMenu.OuterContainer.ScrollingFrame.ChildAdded:Connect(function(child)
	if child.ClassName == "Frame" then
		for i1,v1 in pairs(child:GetChildren()) do
			if v1.ClassName == "TextButton" then
				local callback, binds
				binds = UserInputService.InputBegan:Connect(function(a,b)
					if a.KeyCode == Enum.KeyCode.F6 then
						callback:Disconnect()
						binds:Disconnect()
					end
				end)
				callback = v1.MouseButton1Click:Connect(function()
					Quest:FireServer(("Get%sQuest"):format(autoquestmode), tonumber(child.QuestLabel.Text:gsub("Quest ", ""), 10))
				end)
			end
		end
	end
end)

for i,v in pairs(PG.GameGui.MenuContainer.TeleportMenu.OuterContainer.ScrollingFrame:GetChildren()) do
	if v.ClassName == "Frame" then
		for i1,v1 in pairs(v:GetChildren()) do
			if v1.ClassName == "TextButton" then
				local callback, binds
				binds = UserInputService.InputBegan:Connect(function(a,b)
					if a.KeyCode == Enum.KeyCode.F6 then
						callback:Disconnect()
						binds:Disconnect()
					end
				end)
				callback = v1.MouseButton1Click:Connect(function()
					Quest:FireServer("GetQuest", tonumber(v.QuestLabel.Text:gsub("Quest ", ""), 10))
				end)
			end
		end
	end
end

Player.CharacterAdded:Connect(function(char)
	Character = char
	Humanoid = char:WaitForChild('Humanoid')
	Humanoid.HealthChanged:Connect(function(health)
		if health < Humanoid.MaxHealth*0.4 then EquipRelic:FireServer("Dark Rose")
		else EquipRelic:FireServer("Eclipse Swordpack") end
	end)
	RootPart = char:WaitForChild('HumanoidRootPart')
	Character:WaitForChild('CharacterOutline').Enabled = true
	AwakeningBug()
	WearOutfit("Monarch")
end)
