local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local TeamsConfig = require(game.ReplicatedStorage.Shared.TeamsConfig)

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

return Common
