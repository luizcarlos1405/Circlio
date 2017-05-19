function map(value, input_min, input_max, output_min, output_max)
	return (value - input_min) * (output_max - output_min) / (input_max - input_min) + output_min
end

function approach(g, c, dt)
	local diff = g-c
	if (diff>dt) then
		return c+dt
	elseif (diff < -dt) then
		return c-dt
	else
		return g
	end
end

function measure(f, ...)
	local startTime = love.timer.getTime()
	f(...)
	return love.timer.getTime() - startTime
end