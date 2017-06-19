TankMotor = Script({Tank})

local function canFire(t)
	return love.timer.getTime() - t.lastFire > t.firerate
end

local function canDash(t)
    -- Da dash se estiver no cooldown e se estiver andando
    return (love.timer.getTime() - t.lastDash > t.dashCooldown) and (t.dir ~= 0)
end

local function chargeFire(t)
	if t.freeze then return end
	t.holdtime = 0
	t.isCharging = true
end

local function resetBullet(t)
	t.lastFire = love.timer.getTime()
	t.cooldownBulletSize = 0
	timer.tween(t.firerate, t, {cooldownBulletSize = t.firerate}, "out-quint")
	t.isCharging = false
end

local function fire(t)
	if not t:canFire() or t.freeze then return end

	resetBullet(t)

    local bulletPos = gameCenter+vector(math.cos(t.pos)*(t.arena.arena.raio-35), math.sin(t.pos)*(t.arena.arena.raio-35))

    -- Calcula tamanho da bala em relação ao tempo segurado
    local bulletSize = gconf.bullet.size + t.holdtime*gconf.bullet.size
    -- Cria bullet
    spawnBullet(t, bulletPos, bulletSize, vector.rotate(vector.normalize(gameCenter-t.treco.pos), -t.dir * gconf.bullet.inercia))

	t.holdtime = 0

    event.trigger("tank_shoot", t, bulletSize)
end

local function move(t, d)
	if t.freeze then return end
	t.dir = d
end

local function dash(t)
	if not t:canDash() or t.freeze then return end
	event.trigger("tank_dash")
    t.lastDash = love.timer.getTime()

	timer.tween(0.1, t, {pos = t.pos + t.dir * 0.2}, "in-out-quad")
end


local function die(t)
	t.active = false
	t.freeze = true
	t.dir = 0
	t.isCharging = false
	timer.during(0.6, function()
		t.color.a = math.random(128,255)
	end)
	--timer.tween(0.6,t.color, {r=255,g=255,b=255}, "out-quad");
	timer.tween(0.6,t, {size = 1.5}, "in-quad", function()
		timer.tween(0.3,t.color, {a=0}, "out-quad");
		timer.tween(0.3, t, {size = 0}, "out-quad", function()
			t.treco:destroy()
		end)
	end)

	t.arena.arena:addDecal(t.treco.pos:clone(), t.color)
end

local function damage(t, d, source)
	if t.freeze then return end
	t.life = math.min(gconf.tank.maxLife, t.life + d)
	if (t.life <= 0) then
		screenShake(0.5)
		die(t)
		event.trigger("tank_die", t, source)
		--t.treco:destroy()
	else
		event.trigger("tank_damage", t, source)
		screenShake(0.1, 1)
	end
end


function TankMotor:init(t)
	--Inicializa variaveis internas
	t.tank.lastFire = love.timer.getTime()
    t.tank.lastDash = t.tank.lastFire
	t.tank.holdtime = 0
	t.tank.speed = 0
	t.tank.dir = 0
	t.tank.size = 1

	t.tank.cooldownBulletSize = 5

	--Referencia as funções locais
	t.tank.canFire = canFire
    t.tank.canDash = canDash
	t.tank.chargeFire = chargeFire
	t.tank.resetBullet = resetBullet
	t.tank.fire = fire
	t.tank.move = move
	t.tank.dash = dash
	t.tank.damage = damage

	--Referencia de volta ao treco, pois as funções daqui vao receber a table do componente direto, e não do treco
	t.tank.treco = t

	event.trigger("tank_spawn", t)
end

function TankMotor:update(t, dt)


	if not t.tank.active then return end
	--Atualiza posição real com a posição com rad
	t.pos = t.tank.arena.pos+vector(math.cos(t.tank.pos)*(t.tank.arena.arena.raio-7), math.sin(t.tank.pos)*(t.tank.arena.arena.raio-7))

	if t.tank.freeze then return end

	if(t.tank.isCharging and t.tank:canFire()) then
		--FastFire
		--t.tank:fire()
		--t.tank.isCharging = true

		t.tank.holdtime = math.min(t.tank.holdtime + dt*t.tank.chargeMultiplier, gconf.bullet.maxHoldTime)
	end

	t.tank.speed = approach(t.tank.dir*t.tank.maxSpeed, t.tank.speed, dt*15)

	t.tank.pos = t.tank.pos + t.tank.speed * dt
end
