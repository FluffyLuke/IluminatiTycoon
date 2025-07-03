local CollectionService = game:GetService("CollectionService")

local SpawnerManager = require(game.ServerScriptService.Server.Spawners.SpawnerManager)

local Spawners = CollectionService:GetTagged("Spawner")
local clickSpawner = CollectionService:GetTagged("ClickSpawner")[1]

local button: ClickDetector = clickSpawner.Button.ClickDetector
button.MouseClick:Connect(function()
	SpawnerManager.SpawnMoneyBlock(clickSpawner)
end)
