local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")

local RemoteEventBus = require(game.ReplicatedStorage.Shared.RemoteEventBus)
local TeamsConfig = require(game.ReplicatedStorage.Shared.TeamsConfig)

local ui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("JoinGame")
local topFrame = ui:WaitForChild("TopContainer") :: Frame
local player: Player = game.Players.LocalPlayer
local startingTopFramePos = topFrame.Position

local JoinGameUI = {}

function JoinGameUI.HideUI()
	local teamUI = topFrame:WaitForChild("ChooseTeam")
	local background = topFrame:WaitForChild("Background")

	local goalTeam = {
		Position = UDim2.new(0.5, 0, 0.5, -3000),
	}

	local tweenTeamInfo = TweenInfo.new(2, Enum.EasingStyle.Cubic)
	local tweenTeam = TweenService:Create(teamUI, tweenTeamInfo, goalTeam)
	tweenTeam:Play()

	local goalBackground = {
		ImageTransparency = 1,
	}

	local tweenBackgroundInfo = TweenInfo.new(1, Enum.EasingStyle.Cubic)
	local tweenBackground = TweenService:Create(background, tweenBackgroundInfo, goalBackground)
	tweenBackground:Play()
end

function JoinGameUI.ShowUI()
	warn("NOT IMPLEMENTED")
	-- local teamUI = topFrame:WaitForChild("ChooseTeam")

	-- local goal = {
	-- 	Position = startingTopFramePos,
	-- 	BackgroundTransparency = 0.2,
	-- }

	-- local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Cubic)
	-- local tween = TweenService:Create(teamUI, tweenInfo, goal)
	-- tween:Play()
end

local function InitButtons()
	local frame = topFrame:WaitForChild("ChooseTeam")
	local chooseTeamButtons = {
		frame:WaitForChild("ChooseTeamDavid"),
		frame:WaitForChild("ChooseTeamDrago"),
	}
	for i, b: TextButton in chooseTeamButtons do
		print("Instance: " .. i)
		b.MouseButton1Click:Connect(function()
			local team = b:GetAttribute("Team")
			RemoteEventBus.FireServer("ChooseTeam", team)

			for i = 0, 5, 1 do
				task.wait(0.1)
				if TeamsConfig.HasTeam(player) then
					JoinGameUI.HideUI()
					return
				end
			end

			print("Cannot set team")
		end)
	end
end

function JoinGameUI.Init()
	-- Join world --
	InitButtons()
end

return JoinGameUI
