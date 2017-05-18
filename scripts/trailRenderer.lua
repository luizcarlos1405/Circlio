TrailRenderer = Script({Trail})

function TrailRenderer:update(t, dt)
	for _, v in pairs(t.trail.trails) do
		v:setPosition(t.pos.x, t.pos.y)
		v:update(dt)
	end
end

function TrailRenderer:draw(t)
	love.graphics.setColor(t.trail.color:value())
	for _, v in pairs(t.trail.trails) do
		v:draw()
	end
end
