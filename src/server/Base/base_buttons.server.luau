local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local EventBus = require(game.ReplicatedStorage.Shared.EventBus)
local SpawnerManager = require(game.ServerScriptService.Server.Spawners.SpawnerManager)
local Common = require(game.ReplicatedStorage.Shared.Common)
local TeamsConfig = require(game.ReplicatedStorage.Shared.TeamsConfig)

-- local initButtons = CollectionService:GetTagged("InitBaseButton")

-- for _, b in initButtons do
-- 	local team = b.Parent:GetAttribute("Team")
-- 	if not TeamsConfig.IsTeamDef(team) then
-- 		warn('"Team" attribute was set to wrong value: ' .. team)
-- 		continue
-- 	end

-- 	b.Touched:Connect(function(otherPart: BasePart)
-- 		local teamName = TeamsConfig[team]

-- 		local player = Players:GetPlayerFromCharacter(otherPart.Parent)
-- 		if not player then
-- 			return
-- 		end

-- 		if not TeamsConfig.HasTeam(player) then
-- 			print("Button touched by a peasant, assiging team and spawing base...")
-- 			Players:GetPlayerFromCharacter(otherPart.Parent).Team = teamName
-- 			EventBus.Emit("SpawnBase:" .. team)
-- 		end
-- 	end)

-- 	EventBus.On("DestroyBase:" .. team, function()
-- 		Common.SetActive(b, true)
-- 	end)

-- 	EventBus.On("SpawnBase:" .. team, function()
-- 		Common.SetActive(b, false)
-- 	end)
-- end

local spawnerButtons = CollectionService:GetTagged("SpawnerButton")

for _, b in spawnerButtons do
	local team = b.Parent.Parent:GetAttribute("Team")
	local cost: number = b:GetAttribute("Cost")

	if not TeamsConfig.IsTeamDef(team) then
		warn('"Team" attribute was set to wrong value or not set at all')
		continue
	end

	b.Touched:Connect(function(otherPart: BasePart)
		local teamName = TeamsConfig[team]

		local player = Players:GetPlayerFromCharacter(otherPart.Parent)
		if not player then
			return
		end

		if player.Team ~= teamName then
			return
		end

		local spawnerName = b:GetAttribute("SpawnerName")

		if TeamsConfig.TeamMoney(team) < cost then
			return -- Team is too poor
		end

		SpawnerManager.SpawnSpawner(team, spawnerName)

		if not TeamsConfig.SubstractMoney(team, cost) then
			warn("Could not substract money from team?")
		end

		Common.SetActive(b, false)
		EventBus.Emit("Unlock", team, spawnerName)
	end)
end
