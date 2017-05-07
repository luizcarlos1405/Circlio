PlayerController = Script({Tank, PlayerInput, PlayerStatus})
--[[
	PlayerController
	Controla um tank com input do jogador pelo teclado

	Não deveria ter lógica de atirar e mudar posição aqui, só entrada. O certo seria estar num script "TankMotor"
	Isso serve pra separar a entrada da lógica, asim facilitando a criação de novas formas de entrada, e também uma IA
]]

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
