local CollectionService = game:GetService("CollectionService")

local Common = require(game.ReplicatedStorage.Shared.Common)
local EventBus = require(game.ReplicatedStorage.Shared.EventBus)
local TeamsConfig = require(game.ReplicatedStorage.Shared.TeamsConfig)

local Unlockables = {}

for _, inst in CollectionService:GetTagged("Unlockable") do
	Unlockables[inst] = inst:GetAttribute("UnlockCondition")
end

CollectionService:GetInstanceAddedSignal("Unlockable"):Connect(function(Instance)
	Unlockables[Instance] = Instance:GetAttribute("UnlockCondition")
end)

CollectionService:GetInstanceRemovedSignal("Unlockable"):Connect(function(Instance)
	Unlockables[Instance] = nil
end)

EventBus.On("Unlock", function(team: TeamsConfig.TeamDef, condition: "Unlock")
	for u: Instance, c: string in Unlockables do
		print(u.Name)
		local unlockableTeam = TeamsConfig.GetTeam(u)
		if team == unlockableTeam and c == condition then
			Common.SetActive(u, true)
		end
	end
end)
