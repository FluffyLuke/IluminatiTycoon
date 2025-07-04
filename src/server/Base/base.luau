TeamsConfig = require(game.ReplicatedStorage.Shared.TeamsConfig)
SpawnerManager = require(game.ServerScriptService.Server.Spawners.SpawnerManager)
local EventBus = require(game.ReplicatedStorage.Shared.EventBus)
local Common = require(game.ReplicatedStorage.Shared.Common)

local Base = {}

Base.GetSpawner = function(baseModel, level: number): Model?
	local spawnerFolder = baseModel:FindFirstChild("Spawners")
	if not spawnerFolder then
		error("Spawners folder not found in baseModel.")
		return nil
	end

	local spawner = spawnerFolder:FindFirstChild("Spawner" .. level)
	if not spawner then
		error("Spawner" .. level .. " not found in Spawners folder.")
		return nil
	end
	return spawner
end

Base.InitSellLogic = function(baseModel)
	local team: string = baseModel:GetAttribute("Team") :: string

	local sellArea: Part = baseModel.DropZone.SellArea

	sellArea.Touched:Connect(function(otherPart)
		if not otherPart:HasTag("MoneyBlock") then
			return
		end

		otherPart:Destroy()

		local value: number = otherPart:GetAttribute("Value")
		local player = TeamsConfig.GetPlayerInTeam(team) :: Player
		local leaderstats = player and player:FindFirstChild("leaderstats")

		local moneyStat = leaderstats and leaderstats:FindFirstChild("Money")

		if moneyStat then
			moneyStat.Value += value
		end
	end)
end

Base.SpawnBase = function(base: Model)
	local team = base:GetAttribute("Team")

	print("Spawning base for team: " .. team :: string)
	EventBus.Emit("Unlock", team, "SpawnBase")
	SpawnerManager.SpawnSpawner(team, "Spawner0")
end

Base.DestroyBase = function(base: Model)
	local team = base:GetAttribute("Team")
	print("Destroying base for team: " .. team)

	local spawnerFolder = base:FindFirstChild("Spawners")
	for _, s in spawnerFolder:GetChildren() do
		SpawnerManager.DespawnSpawner(team, s.Name)
	end

	local buttons = base:FindFirstChild("Buttons")
	for _, b in buttons:GetChildren() do
		Common.SetActive(b, false)
	end
end

return Base
