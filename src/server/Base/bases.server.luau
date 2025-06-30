local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")

local EventBus = require(game.ReplicatedStorage.Shared.EventBus)
local Base = require(game.ServerScriptService.Server.Base.base)

local Bases = {
	game.Workspace:WaitForChild("BaseDrago") :: Model,
	-- game.Workspace:WaitForChild("BaseDavid") :: Model,
}

for i: number, b: Model in Bases do
	Base.InitLevel0SpawnerLogic(b)
	Base.InitSellLogic(b)
	Base.DestroyBase(b)

	team = b:GetAttribute("Team")

	EventBus.On("SpawnBase:" .. team, function()
		Base.SpawnBase(b)
	end)
end
