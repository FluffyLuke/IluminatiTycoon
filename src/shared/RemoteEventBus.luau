local RemoteClientEvents: Folder = game.ReplicatedStorage.Shared.RemoveEvents.Client
local RemoteServerEvents: Folder = game.ReplicatedStorage.Shared.RemoveEvents.Server

local RemoteEvents = {}

function RemoteEvents.OnClient(eventName: string, callback: (...any) -> ()): boolean
	local instance: Instance? = RemoteClientEvents:FindFirstChild(eventName)
	if not instance or not instance:IsA("RemoteEvent") then
		warn("Cannot find valid RemoteEvent (Client) named: " .. eventName)
		return false
	end

	local event: RemoteEvent = instance :: RemoteEvent
	event.OnClientEvent:Connect(callback)

	return true
end

function RemoteEvents.OnServer(eventName: string, callback: (...any) -> ()): boolean
	local instance: Instance? = RemoteServerEvents:FindFirstChild(eventName)
	if not instance or not instance:IsA("RemoteEvent") then
		warn("Cannot find valid RemoteEvent (Server) named: " .. eventName)
		return false
	end

	local event: RemoteEvent = instance :: RemoteEvent
	event.OnServerEvent:Connect(callback)

	return true
end

function RemoteEvents.FireClient(eventName: string, ...): boolean
	local instance: Instance? = RemoteClientEvents:FindFirstChild(eventName)
	if not instance or not instance:IsA("RemoteEvent") then
		warn("Cannot find valid RemoteEvent (Server) named: " .. eventName)
		return false
	end

	local event: RemoteEvent = instance :: RemoteEvent
	event:FireClient(...)

	return true
end

function RemoteEvents.FireServer(eventName: string, ...): boolean
	local instance: Instance? = RemoteServerEvents:FindFirstChild(eventName)
	if not instance or not instance:IsA("RemoteEvent") then
		warn("Cannot find valid RemoteEvent (Server) named: " .. eventName)
		return false
	end

	local event: RemoteEvent = instance :: RemoteEvent
	event:FireServer(...)

	return true
end

return RemoteEvents
