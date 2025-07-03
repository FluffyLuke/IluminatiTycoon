local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")

local TeamsConfig = require(game.ReplicatedStorage.Shared.TeamsConfig)
local EventBus = require(game.ReplicatedStorage.Shared.EventBus)
local Base = require(game.ServerScriptService.Server.Base.Base)

local Bases = {
	game.Workspace:WaitForChild("BaseDrago") :: Model,
	-- game.Workspace:WaitForChild("BaseDavid") :: Model,
}

for i: number, b: Model in Bases do
	Base.InitSellLogic(b)
	Base.DestroyBase(b)

	team = b:GetAttribute("Team")
	if not TeamsConfig.IsTeamDef(team) then
		warn('"Team" attribute was set to wrong value: ' .. team)
		continue
	end

	EventBus.On("SpawnBase:" .. team, function()
		Base.SpawnBase(b)
	end)
end
