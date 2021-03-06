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

function spawnBullet(t, bpos, bsize, bdir)
    Treco(Position(bpos.x, bpos.y),
	    Bullet({dir = bdir,
	    speed = 300 + (1.913^t.holdtime) * 100,
	    size = bsize,
	    source = t.treco}),
	    Circoll(bsize),
		Trail({ trails = { trail:new({
				type = "mesh",
                initPosition = {bpos.x, bpos.y},
				content = {
					source = bsize<10 and R.texture.bullet1 or R.texture.bullet2,
					width = bsize*2,
					mode = "stretch"
				},
				duration = bsize<10 and 0.2 or 0.15
			}) -- Passando imgPos como argumento para a função new do trail.lua modificada que impede o bug
		}, color = Color(t.color:value())})
	)
end

function screenShake(t, pot)
	pot = pot or 2
	local orig_x, orig_y = cmr:position()
	timer.during(t, function()
		cmr:lookAt(orig_x + math.random(-pot,pot), orig_y + math.random(-pot,pot))
	end, function()
		-- reset cmr position
		cmr:lookAt(orig_x, orig_y)
	end)
end