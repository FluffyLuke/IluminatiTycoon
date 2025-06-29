local Base = {}

local Players = game:GetService("Players")
local Common = require(game.ReplicatedStorage.Shared.Common)
local MoneyBlock: Part = game.ReplicatedStorage:WaitForChild("MoneyBlock")

Base.GetSpawner = function(baseModel, level: number): Model?
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

Base.InitLevel0SpawnerLogic = function(baseModel: Model)
	local spawner = Base.GetSpawner(baseModel, 0)
	local button: ClickDetector = spawner.Button.ClickDetector

	local pipeEnd: Part = spawner.End
	local offset: Vector3 = pipeEnd:GetAttribute("Offset") :: Vector3

	local value: number = spawner:GetAttribute("Value")

	button.MouseClick:Connect(function()
		local moneyBlockClone: Part = MoneyBlock:Clone()
		moneyBlockClone.Parent = workspace
		moneyBlockClone:SetAttribute("Value", value)
		moneyBlockClone.Position = pipeEnd.Position + offset

		print("Clicked! " .. (pipeEnd.Position + offset).X)
	end)
end

Base.InitSellLogic = function(baseModel)
	local team: string = baseModel:GetAttribute("Team") :: string

	local sellArea: Part = baseModel.DropZone.SellArea

	sellArea.Touched:Connect(function(otherPart)
		if not otherPart:HasTag("MoneyBlock") then
			return
		end

		otherPart:Destroy()

		local value: number = otherPart:GetAttribute("Value")
		local player = Common.GetPlayerInTeam(team) :: Player
		local leaderstats = player and player:FindFirstChild("leaderstats")

		local moneyStat = leaderstats and leaderstats:FindFirstChild("Money")

		if moneyStat then
			moneyStat.Value += value
		end
	end)
end

Base.SpawnSpawner = function(baseModel: Model, level: number)
	local spawnerFolder = baseModel:FindFirstChild("Spawners")
	if not spawnerFolder then
		error("Spawners folder not found in baseModel.")
		return
	end

	local spawner = spawnerFolder:FindFirstChild("Spawner" .. level)
	if not spawner then
		error("Spawner" .. level .. " not found in Spawners folder.")
		return
	end

	local pipeEnd: Part = spawner.End
	local offset: Vector3 = pipeEnd:GetAttribute("Offset") :: Vector3

	if level < 0 then
		print("NOT IMPLEMENTED")
	end

	Common.SetActive(spawner, true)
end

Base.DestroySpawners = function(baseModel: Model)
	local spawnerFolder = baseModel:FindFirstChild("Spawners")
	if not spawnerFolder then
		error("Spawners folder not found in baseModel.")
		return
	end

	Common.SetActive(spawnerFolder, false)
end

Base.SpawnBase = function(base: Model)
	print("Spawning base for team: " .. base:GetAttribute("Team") :: string)
	Base.SpawnSpawner(base, 0)
	local initButton: BasePart = base:FindFirstChild("InitBaseButton") :: BasePart
	Common.SetActive(initButton, false)
end

Base.DestroyBase = function(base: Model)
	print("Destroying base for team: " .. base:GetAttribute("Team") :: string)
	Base.DestroySpawners(base)
	local initButton: BasePart = base:FindFirstChild("InitBaseButton") :: BasePart
	Common.SetActive(initButton, true)
end

return Base
