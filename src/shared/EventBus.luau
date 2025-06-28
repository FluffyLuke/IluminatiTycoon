local RemoteClientEvents: Folder = game.ReplicatedStorage.Shared.RemoveEvents.Client
local RemoteServerEvents: Folder = game.ReplicatedStorage.Shared.RemoveEvents.Server

local function ConnectClientEvent(eventName: string, callback: (...any) -> ()): boolean
	local instance: Instance? = RemoteClientEvents:FindFirstChild(eventName)
	if not instance or not instance:IsA("RemoteEvent") then
		warn("Cannot find valid RemoteEvent (Client) named: " .. eventName)
		return false
	end

	local event: RemoteEvent = instance :: RemoteEvent
	event.OnClientEvent:Connect(callback)

	return true
end

local function ConnectServerEvent(eventName: string, callback: (...any) -> ()): boolean
	local instance: Instance? = RemoteClientEvents:FindFirstChild(eventName)
	if not instance or not instance:IsA("RemoteEvent") then
		warn("Cannot find valid RemoteEvent (Server) named: " .. eventName)
		return false
	end

	local event: RemoteEvent = instance :: RemoteEvent
	event.OnServerEvent:Connect(callback)

	return true
end

local function InvokeClient(eventName: string, ...): boolean
	local instance: Instance? = RemoteClientEvents:FindFirstChild(eventName)
	if not instance or not instance:IsA("RemoteEvent") then
		warn("Cannot find valid RemoteEvent (Server) named: " .. eventName)
		return false
	end

	local event: RemoteEvent = instance :: RemoteEvent
	event:FireClient(...)

	return true
end

local function InvokeServer(eventName: string, ...): boolean
	local instance: Instance? = RemoteServerEvents:FindFirstChild(eventName)
	if not instance or not instance:IsA("RemoteEvent") then
		warn("Cannot find valid RemoteEvent (Server) named: " .. eventName)
		return false
	end

	local event: RemoteEvent = instance :: RemoteEvent
	event:FireServer(...)

	return true
end

local Events = {
	ConnectClientEvent = ConnectClientEvent,
	ConnectServerEvent = ConnectServerEvent,
	InvokeClient = InvokeClient,
	InvokeServer = InvokeServer,
}

return Events
