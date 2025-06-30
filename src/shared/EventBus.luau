local EventBus = {}
local Collection = {}

function EventBus.On(eventName: string, callback: (...any) -> ())
	if not Collection[eventName] then
		print('Creating new event called: "' .. eventName .. '"')
		local bindable = Instance.new("BindableEvent")
		Collection[eventName] = bindable
	end
	return Collection[eventName].Event:Connect(callback)
end

function EventBus.Emit(eventName: string, ...)
	if Collection[eventName] then
		Collection[eventName]:Fire(...)
	else
		warn("Cannot find event of name: " .. eventName)
	end
end

return EventBus
