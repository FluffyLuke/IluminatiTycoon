local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local Variables = require(game.ReplicatedStorage.Shared.Variables)
local Base = require(game.ServerScriptService.Server.Base.base)

local Bases = {
	game.Workspace:WaitForChild("BaseDrago") :: Model,
	-- game.Workspace:WaitForChild("BaseDavid") :: Model,
}

for i: number, b: Model in Bases do
	local team: string = b:GetAttribute("Team") :: string
	local initButton: BasePart = b:FindFirstChild("InitBaseButton") :: BasePart

	Base.InitLevel0SpawnerLogic(b)
	Base.InitSellLogic(b)
	Base.DestroyBase(b)

	initButton.Touched:Connect(function(otherPart: BasePart)
		local teamName: string
		if team == "Drago" then
			teamName = Teams[Variables.DragoTeamName]
		else
			teamName = Teams[Variables.DavidTeamName]
		end

		local player = Players:GetPlayerFromCharacter(otherPart.Parent)
		if not player then
			return
		end

		if player:HasTag(Variables.PlayerTag) then
			print("Button touched by a player!")
			Players:GetPlayerFromCharacter(otherPart.Parent).Team = teamName
			Base.SpawnBase(b)
		end
	end)
end
