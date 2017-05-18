TrailRenderer = Script({Trail})

function TrailRenderer:update(t, dt)
	for _, v in pairs(t.trail.trails) do
		v:setPosition(t.pos.x, t.pos.y)
		v:update(dt)
	end
end

function TrailRenderer:draw(t)
	r, g, b, a = t.bullet.source.tank.color:value()
	love.graphics.setColor(r, g, b, a)
	for _, v in pairs(t.trail.trails) do
		v:draw()
	end
end
