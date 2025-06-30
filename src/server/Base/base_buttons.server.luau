local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local EventBus = require(game.ReplicatedStorage.Shared.EventBus)
local TeamsConfig = require(game.ReplicatedStorage.Shared.TeamsConfig)

local buttons = CollectionService:GetTagged("InitBaseButton")

for _, b in buttons do
	b.Touched:Connect(function(otherPart: BasePart)
		local team = b.Parent:GetAttribute("Team")
		local teamName = TeamsConfig[team]

		local player = Players:GetPlayerFromCharacter(otherPart.Parent)
		if not player then
			return
		end

		if TeamsConfig.HasTeam(player) then
			print("Button touched by a peasant, assiging team and spawing base...")
			Players:GetPlayerFromCharacter(otherPart.Parent).Team = teamName
			EventBus.Emit("SpawnBase:" .. team)
		end
	end)
end
