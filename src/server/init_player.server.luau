local Players = game:GetService("Players")

local CollisionGroups = require(game.ReplicatedStorage.Shared.CollisionGroups)

Players.PlayerAdded:Connect(function(player)
	print(player.Name .. " joined the world!")
end)
