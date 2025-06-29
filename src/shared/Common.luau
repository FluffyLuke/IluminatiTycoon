local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local Variables = require(game.ReplicatedStorage.Shared.Variables)

local Common = {}

Common.SetActive = function(thing: Instance, active: boolean)
	for i, d in thing:GetDescendants() do
		if d:IsA("BasePart") then
			d.CanCollide = active
			d.CanQuery = active
			d.CanTouch = active
			d.Transparency = active and 0 or 1
		end
	end

	if thing:IsA("BasePart") then
		thing.CanCollide = active
		thing.CanQuery = active
		thing.CanTouch = active
		thing.Transparency = active and 0 or 1
	end
end

Common.GetPlayerInTeam = function(team: string): Player?
	for i: number, p: Player in Players:GetPlayers() do
		if p.Team == Teams[Variables:GetTeamNameFromName(team)] then
			return p
		end
	end

	warn("Cannot find player")
	return nil
end

return Common
