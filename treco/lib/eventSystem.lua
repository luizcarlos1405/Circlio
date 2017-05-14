local event = {}
local list = {}

function event.trigger(e, ...)
	if not list[e] then return end
	for k in pairs(list[e]) do
		k(...);
	end
end

function event.listen(e, f)
	if not list[e] then
		list[e] = {}
	end
	list[e][f] = true
end

function event.stop(e,f)
	if not list[e] or not list[e][f] then return end
	list[e][f] = nil
end

return event