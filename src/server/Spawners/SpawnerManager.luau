local CollectionService = game:GetService("CollectionService")

local Common = require(game.ReplicatedStorage.Shared.Common)
local TeamsConfig = require(game.ReplicatedStorage.Shared.TeamsConfig)

local MoneyBlock = game.ReplicatedStorage.MoneyBlock

local activeSpawners = {}

local SpawnerManager = {}

function SpawnerManager.SpawnMoneyBlock(spawner)
	local moneyBlockClone: Part = MoneyBlock:Clone()

	local value: number = spawner:GetAttribute("Value") :: number
	local pipeEnd: Part = spawner.End
	local offset: Vector3 = pipeEnd:GetAttribute("Offset") :: Vector3

	moneyBlockClone.Parent = workspace
	moneyBlockClone:SetAttribute("Value", value)
	moneyBlockClone.Position = pipeEnd.Position + offset
end

SpawnerManager.SpawnSpawner = function(team: TeamsConfig.TeamDef, spawnerName): boolean
	local baseModel = TeamsConfig.GetBase(team)
	local spawnerFolder = baseModel:FindFirstChild("Spawners")
	if not spawnerFolder then
		warn("Spawners folder not found in " .. baseModel.Name)
		return false
	end

	local spawner = spawnerFolder:FindFirstChild(spawnerName)
	if not spawner then
		warn('Spawner "' .. spawnerName .. '" not found in Spawners folder.')
		return false
	end

	if activeSpawners[spawner] then
		warn("Spawner is already active")
		return false
	end

	Common.SetActive(spawner, true)
	activeSpawners[spawner] = task.spawn(function()
		local cooldown: number = spawner:GetAttribute("Cooldown")
		while true do
			task.wait(cooldown)
			SpawnerManager.SpawnMoneyBlock(spawner)
		end
	end)

	return true
end

SpawnerManager.DespawnSpawner = function(team: TeamsConfig.TeamDef, spawnerName): boolean
	local baseModel = TeamsConfig.GetBase(team)
	local spawnerFolder = baseModel:FindFirstChild("Spawners")
	if not spawnerFolder then
		error("Spawners folder not found in baseModel.")
		return false
	end

	local spawner = spawnerFolder:FindFirstChild(spawnerName)
	if not spawner then
		error("Spawner" .. spawnerName .. " not found in Spawners folder.")
		return false
	end

	Common.SetActive(spawner, false)

	local handle = activeSpawners[spawner]
	if handle then
		handle.cancel()
	else
		warn("Spawner is not active")
	end

	return true
end

return SpawnerManager
