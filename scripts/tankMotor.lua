TankMotor = Script({Tank})

local bulletImage = love.graphics.newImage("assets/bullet1flame.png")

local function canFire(t)
	return love.timer.getTime() - t.lastFire > t.firerate
end

local function chargeFire(t)
	t.holdtime = 0
	t.isCharging = true
end

local function fire(t)
	if not t:canFire() then return end

	t.lastFire = love.timer.getTime()
	t.cooldownBulletSize = 0
	timer.tween(t.firerate, t, {cooldownBulletSize = 5}, "out-quint")
	t.isCharging = false

    local bulletPos = gameCenter+vector(math.cos(t.pos)*(t.arena.arena.raio-35), math.sin(t.pos)*(t.arena.arena.raio-35))
    -- Calcula tamanho da bala em relação ao tempo segurado
    local bulletSize = gconf.bullet.size + t.holdtime*gconf.bullet.size
    Treco(Position(bulletPos.x, bulletPos.y),
	    Bullet({dir = vector.rotate(vector.normalize(gameCenter-t.treco.pos), -t.dir * gconf.bullet.inercia),
	    speed = 300 + (1.913^t.holdtime) * 100,
	    size = bulletSize,
	    source = t.treco}),
	    Circoll(bulletSize),
		Trail({ trails = {trail:new({
				type = "point",
				content = {
					type = "circle",
					radius = bulletSize
				},
				fade = "shrink",
				amount = 5,
				duration = .2
			}), trail:new({
				type = "mesh",
				content = {
					source = bulletImage,
					width = bulletSize*6,
					mode = "stretch"
				},
				duration = 1
			})
		}})
	)

	t.holdtime = 0

    event.trigger("tank_shoot", t, bulletSize)
end

local function move(t, d)
	t.dir = d
end

local function damage(t, d, source)
	t.life = math.min(gconf.tank.maxLife, t.life + d)
	if (t.life <= 0) then
		event.trigger("tank_die", t, source)
		t.treco:destroy()
	end
end

function TankMotor:init(t)
	--Inicializa variaveis internas
	t.tank.lastFire = love.timer.getTime()
	t.tank.holdtime = 0
	t.tank.speed = 0
	t.tank.dir = 0

	t.tank.cooldownBulletSize = 5

	--Referencia as funções locais
	t.tank.canFire = canFire
	t.tank.chargeFire = chargeFire
	t.tank.fire = fire
	t.tank.move = move
	t.tank.damage = damage

	--Referencia de volta ao treco, pois as funções daqui vao receber a table do componente direto, e não do treco
	t.tank.treco = t

	event.trigger("tank_spawn", t)
end

function TankMotor:update(t, dt)
	if(t.tank.isCharging and t.tank:canFire()) then
		t.tank.holdtime = math.min(t.tank.holdtime + dt, 3)
	end

	t.tank.speed = approach(t.tank.dir*t.tank.maxSpeed, t.tank.speed, dt*15)

	t.tank.pos = t.tank.pos + t.tank.speed * dt
end
