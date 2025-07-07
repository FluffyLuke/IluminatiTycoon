local RemoteEventBus = require(game.ReplicatedStorage.Shared.RemoteEventBus)
local EventBus = require(game.ReplicatedStorage.Shared.EventBus)
local TeamsConfig = require(game.ReplicatedStorage.Shared.TeamsConfig)

RemoteEventBus.OnServer("ChooseTeam", function(player: Player, team: string)
	if TeamsConfig.IsTeamDef(team) then
		if TeamsConfig.JoinTeam(player, team :: TeamsConfig.TeamDef) then
			EventBus.Emit("SpawnBase:" .. team)
		end
	end
end)
