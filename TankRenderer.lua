TankRenderer = Script({Tank})

function TankRenderer:update(t, dt)
	
	t.pos = gameCenter+vector(math.cos(t.tank.pos)*(raio-7), math.sin(t.tank.pos)*(raio-7))

end

function TankRenderer:draw(t)
	love.graphics.setColor(Color.red:value())

	love.graphics.circle("fill", t.pos.x, t.pos.y, 15)
	

	love.graphics.rectangle("fill", gameCenter.x, gameCenter.y, 10	, 10)
end