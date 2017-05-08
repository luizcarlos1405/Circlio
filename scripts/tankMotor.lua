TankMotor = Script({Tank})

local function canFire(t)
	return love.timer.getTime() - t.lastFire > t.firerate
end

local function chargeFire(t)
	t.holdtime = 0
	t.isCharging = true
end

local function fire(t) 
	if not t:canFire() then return end

	--A fazer: Animar a volta do cooldown a zero, de acordo com o firerate
	t.lastFire = love.timer.getTime()
	t.isCharging = false

	local var = vector()
	local aux = 0

	if t.dir>0 then
		aux = 1
	elseif t.dir<0 then
		aux = -1
	end
	
	var.x = (aux * math.sin(t.pos - math.pi) * 100) --/ math.min(t.tank.holdtime + 1, 4)
	var.y = (aux * math.cos(t.pos - math.pi) * 100) 
	
	Treco(Position(t.treco.pos.x, t.treco.pos.y), Bullet({dir = vector.normalize(gameCenter-var-t.treco.pos), speed = 100 + (1.913^t.holdtime) * 100, source = t.treco}), BoxCollider(14,14, vector(-7,-7)))
	t.holdtime = 0
end

local function move(t, d)
	t.dir = d
end

local function damage(t, d)
	t.life = t.life + d
	if (t.life <= 0) then
		t.treco:destroy()
	end
end

function TankMotor:init(t)
	--Inicializa variaveis internas
	t.tank.lastFire = love.timer.getTime()
	t.tank.holdtime = 0
	t.tank.speed = 0
	t.tank.dir = 0

	--Referencia as funções locais
	t.tank.canFire = canFire
	t.tank.chargeFire = chargeFire
	t.tank.fire = fire
	t.tank.move = move
	t.tank.damage = damage

	--Referencia de volta ao treco, pois as funções daqui vao receber a table do componente direto, e não do treco
	t.tank.treco = t	
end

local maxSpeed = 1.8

function TankMotor:update(t, dt)
	if(t.tank.isCharging and t.tank:canFire()) then
		t.tank.holdtime = math.min(t.tank.holdtime + dt, 3)
	end

	t.tank.speed = approach(t.tank.dir*maxSpeed, t.tank.speed, dt*15)
	
	t.tank.pos = t.tank.pos + t.tank.speed * dt

	Physics:updateRect(t)
end