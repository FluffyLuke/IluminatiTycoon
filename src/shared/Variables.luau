local Globals = {
	DragoTeamName = "Drago's Guard",
	DavidTeamName = "David's Revolution",

	PlayerCollisionGroup = "Players",

	PlayerTag = "Player",
	DragoTag = "Drago",
	DavidTag = "David",
}

function Globals:GetTeamNameFromName(name: string): string
	if name == "Drago" then
		return self.DragoTeamName
	else
		return self.DavidTeamName
	end
end

return Globals
