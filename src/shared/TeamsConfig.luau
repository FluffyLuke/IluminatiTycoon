local Teams = game:GetService("Teams")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")

local TeamsConfig = {
	Drago = Teams:FindFirstChild("Drago's Guard"),
	David = Teams:FindFirstChild("David's Revolution"),
	Default = Teams:FindFirstChild("Peasants"),
}

export type TeamDef = "Drago" | "David"
function TeamsConfig.IsTeamDef(team: string)
	return team == "Drago" or team == "David"
end

function TeamsConfig.HasTeam(player: Player): boolean
	return player.Team ~= TeamsConfig.Default
end

function TeamsConfig.GetPlayerInTeam(team: TeamDef): Player?
	for i: number, p: Player in Players:GetPlayers() do
		if p.Team == TeamsConfig[team] then
			return p
		end
	end

	warn("Cannot find player")
	return nil
end

function TeamsConfig.GetBase(team: TeamDef): Instance
	return CollectionService:GetTagged("Base:" .. team)[1]
end

function TeamsConfig.GetTeam(instance: Instance): TeamDef?
	local ancestor = instance:FindFirstAncestorWhichIsA("Model")
	while ancestor do
		if CollectionService:HasTag(ancestor, "Base") then
			return ancestor:GetAttribute("Team")
		end
		ancestor = ancestor.Parent
	end
	warn('Cannot find team for "' .. instance.Name .. '"')
	return nil
end

function TeamsConfig.TeamMoney(team: TeamDef): number
	local player = TeamsConfig.GetPlayerInTeam(team)
	if not player then
		warn('No player in team "' .. team .. '"')
		return 0
	end

	local moneyCounter = player.leaderstats.Money :: IntValue
	return moneyCounter.Value
end

function TeamsConfig.SubstractMoney(team: TeamDef, valueToSubtract: number): boolean
	local player = TeamsConfig.GetPlayerInTeam(team)
	if not player then
		warn('No player in team "' .. team .. '"')
		return false
	end

	local moneyCounter = player.leaderstats.Money :: IntValue
	if moneyCounter.Value - valueToSubtract < 0 then
		return false
	end

	moneyCounter.Value -= valueToSubtract

	return true
end

function TeamsConfig.JoinTeam(player: Player, team: TeamDef): boolean
	if TeamsConfig.HasTeam(player) then
		return false
	end

	player.Team = TeamsConfig[team]

	return true
end

return TeamsConfig
