local Teams = game:GetService("Teams")
local Players = game:GetService("Players")

local TeamsConfig = {
	Drago = Teams:FindFirstChild("Drago's Guard"),
	David = Teams:FindFirstChild("David's Revolution"),
	Default = Teams:FindFirstChild("Peasants"),
}

function TeamsConfig.HasTeam(player: Player): boolean
	return player.Team == TeamsConfig.Default
end

function TeamsConfig.GetPlayerInTeam(team: string): Player?
	for i: number, p: Player in Players:GetPlayers() do
		if p.Team == TeamsConfig[team] then
			return p
		end
	end

	warn("Cannot find player")
	return nil
end

return TeamsConfig
