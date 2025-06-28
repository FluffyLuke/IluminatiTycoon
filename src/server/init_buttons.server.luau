local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local Variables = require(game.ReplicatedStorage.Shared.Variables)
local EventBus = require(game.ReplicatedStorage.Shared.EventBus)

local buttons: { BasePart } = CollectionService:GetTagged("InitBaseButton")

for i: number, b: BasePart in buttons do
	local team: string = b:GetAttribute("Team") :: string
	local teamName: string

	if team == "Drago" then
		teamName = Teams[Variables.DragoTeamName]
	else
		teamName = Teams[Variables.DavidTeamName]
	end

	b.Touched:Connect(function(otherPart: BasePart)
		local player = Players:GetPlayerFromCharacter(otherPart.Parent)
		if not player then
			return
		end

		if player:HasTag(Variables.PlayerTag) then
			print("Button touched by a player!")
			Players:GetPlayerFromCharacter(otherPart.Parent).Team = teamName
			EventBus.InvokeServer("CreateBase", team)
		end
	end)
end
