require("lib.map")

PlayerController = Script({Tank, PlayerInput, PlayerStatus})

function PlayerController:update(t, dt)

	if (love.keyboard.isDown(t.input.left)) then
		t.tank.pos = t.tank.pos + dt
	end
	if (love.keyboard.isDown(t.input.right)) then
		t.tank.pos = t.tank.pos - dt
	end
	if(love.keyboard.isDown(t.input.shoot) and t.status.cooldown > t.status.fireRate) then
		t.status.holdtime = math.min(t.status.holdtime + dt, 3)
	end

	t.status.cooldown = t.status.cooldown + dt

	Physics:updateRect(t)
end

function PlayerController:draw(t)
	love.graphics.print("HOLD" .. t.status.holdtime)

	love.graphics.setLineWidth(2)
	love.graphics.setColor(255, 0, 0)
	love.graphics.arc("line", "open", gameCenter.x, gameCenter.y, gameArena.raio+20, t.tank.pos-math.rad(5), t.tank.pos-math.rad(5) + math.rad(10))

	love.graphics.setLineWidth(10)
	love.graphics.setColor(map(t.status.holdtime, 0, 3, 255, 0), map(t.status.holdtime, 0, 3, 0, 150), map(t.status.holdtime, 0, 3, 0, 255))
	love.graphics.arc("line", "open", gameCenter.x, gameCenter.y, gameArena.raio+40, t.tank.pos-math.rad(5), t.tank.pos-math.rad(5) + map(t.status.holdtime, 0, 3, 0, math.rad(10)))

	love.graphics.setColor(255, 0, 0)
	love.graphics.arc("line", "open", gameCenter.x, gameCenter.y, gameArena.raio+20, t.tank.pos-math.rad(5), t.tank.pos-math.rad(5) + map(t.status.life, 0, 100, 0, math.rad(10)))

end

function PlayerController:keypressed(t, key)
	if key == t.input.shoot then
		t.status.holdtime = 0
	end
end

function PlayerController:keyreleased(t, key)
	if key == t.input.shoot and t.status.cooldown > t.status.fireRate then
		t.status.cooldown = 0
		Treco(Position(t.pos.x, t.pos.y), Bullet({dir = vector.normalize(gameCenter-t.pos), speed = 100 + (1.913^t.status.holdtime) * 100, source = t.status.name}), BoxCollider(10,10, vector(-5,-5)))
		t.status.holdtime = 0
	end
end
