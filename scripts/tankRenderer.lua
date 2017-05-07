TankRenderer = Script({Tank})

function TankRenderer:update(t, dt)

	t.pos = gameCenter+vector(math.cos(t.tank.pos)*(gameArena.raio-7), math.sin(t.tank.pos)*(gameArena.raio-7))

end

function TankRenderer:draw(t)
	love.graphics.setColor(t.tank.color:value())
	love.graphics.circle("fill", t.pos.x, t.pos.y, 15)

end
