local Players = game:GetService("Players")

local Variables = require(game.ReplicatedStorage.Shared.Variables)

local function setCollisionGroup(model)
	-- Apply collision group to all existing parts in the model

	for _, descendant in model:GetDescendants() do
		if descendant:IsA("BasePart") then
			descendant.CollisionGroup = Variables.PlayerCollisionGroup
		end
	end
end

Players.PlayerAdded:Connect(function(player)
	print(player.Name .. " joined the world!")
	print(Variables)
	player:AddTag(Variables.PlayerTag)

	player.CharacterAdded:Connect(function(character)
		setCollisionGroup(character)
	end)

	-- If the player already has a character, apply the collision group immediately

	if player.Character then
		setCollisionGroup(player.Character)
	end
end)
