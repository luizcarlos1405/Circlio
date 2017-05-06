PlayerController = Script({Tank, PlayerInput})

function PlayerController:update(t, dt)
	if (love.keyboard.isDown(t.input.left)) then
		t.tank.pos = t.tank.pos + dt
	end
	if (love.keyboard.isDown(t.input.right)) then
		t.tank.pos = t.tank.pos - dt
	end

	if (love.keyboard.isDown(t.input.shoot)) then
		Treco(Position(t.pos.x, t.pos.y), Bullet({dir = vector.normalize(gameCenter-t.pos)}))
	end
end 