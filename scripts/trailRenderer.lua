TrailRenderer = Script({Trail})

function TrailRenderer:update(t, dt)
    local pos = t.pos
    -- Se for trail de uma bullet então adicionar um offset pra colisão
    if t.bullet then
        pos = t.pos + (t.bullet.dir * t.bullet.size * gconf.bullet.collOffset)
    end
	for _, v in pairs(t.trail.trails) do
		v:setPosition(pos.x, pos.y):update(dt)
	end
end

function TrailRenderer:draw(t)
	love.graphics.setColor(t.trail.color:value())
	for _, v in pairs(t.trail.trails) do
		v:draw()
	end
end
