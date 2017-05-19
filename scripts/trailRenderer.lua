TrailRenderer = Script({Trail})

function TrailRenderer:update(t, dt)
    imgPos = t.pos + (t.bullet.dir * gconf.bullet.imgOffset)
	for _, v in pairs(t.trail.trails) do
		v:setPosition(imgPos.x, imgPos.y)
		v:update(dt)
	end
end

function TrailRenderer:draw(t)
	love.graphics.setColor(t.trail.color:value())
	for _, v in pairs(t.trail.trails) do
		v:draw()
	end
end
