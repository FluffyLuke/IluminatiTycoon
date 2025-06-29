local Spawner = {}

Spawner.SpawnSpawner = function(baseModel: Model, level: number)
	local spawnerFolder = baseModel:FindFirstChild("Spawners")
	if not spawnerFolder then
		error("Spawners folder not found in baseModel.")
		return nil
	end

	local spawner = spawnerFolder:FindFirstChild("Spawner" .. level)
	if not spawner then
		error("Spawner" .. level .. " not found in Spawners folder.")
		return nil
	end

	return spawner
end

return Spawner
