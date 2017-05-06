PlayerController = Script({Tank, PlayerInput})

local cooldown = 0
local holdTime = 0

function PlayerController:update(t, dt)
	if (love.keyboard.isDown(t.input.left)) then
		t.tank.pos = t.tank.pos + dt
	end
	if (love.keyboard.isDown(t.input.right)) then
		t.tank.pos = t.tank.pos - dt
	end

	holdTime = holdTime + dt
	cooldown = cooldown + dt
end 

function PlayerController:keypressed(t, key)
	if key == t.input.shoot then
		holdTime = 0
	end
end

function PlayerController:keyreleased(t, key)
	if key == t.input.shoot and holdTime > t.tank.strong then
		cooldown = 0
		Treco(Position(t.pos.x, t.pos.y), Bullet({dir = vector.normalize(gameCenter-t.pos), speed = 400}))
	elseif key == t.input.shoot and cooldown > t.tank.fireRate then
		cooldown = 0
		Treco(Position(t.pos.x, t.pos.y), Bullet({dir = vector.normalize(gameCenter-t.pos)}))
	end
end