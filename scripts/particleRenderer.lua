ParticleRenderer = Script()

local psystem



local particles = {}

event.listen("tank_die", function(tank)
	local dir = math.pi + tank.pos
	local psystem = love.graphics.newParticleSystem(R.texture.tankDie, 100)
	psystem:setParticleLifetime(1,1.5) -- Particles live at least 2s and at most 5s.
	psystem:setEmissionRate(200)
	psystem:setSizeVariation(1)
	psystem:setSizes(0.5,1,1.5)
	psystem:setSpin(-10,10)
	psystem:setSpinVariation(1)
	--psystem:setAreaSpread("normal", tank.size, tank.size)
	psystem:setLinearAcceleration(-math.cos(dir)*200, -math.sin(dir)*200, -math.cos(dir)*100, -math.sin(dir)*100)
	psystem:setLinearDamping(1,2)
	psystem:setSpeed(400)
	psystem:setSpread(3)
	psystem:setDirection(dir)
	psystem:setLinearAcceleration(-20, -20, 20, 20) -- Random movement in all directions.
	psystem:setColors(255, 255, 255, 255, 255, 255, 255, 0) -- Fade to transparency.

local tab = {
		system = psystem,
		pos = tank.treco.pos,
		color = tank.color:clone()
	}
	particles[tab] = true
	
	timer.after(1, function()
		psystem:stop()
		timer.after(2,function()
			particles[tab] = nil
		end)
	end)
end)

local function fundo()
	local psystem = love.graphics.newParticleSystem(R.texture.bolaredonda, 750)
	psystem:setParticleLifetime(10,30) -- Particles live at least 2s and at most 5s.
	psystem:setEmissionRate(25)
	psystem:setSizeVariation(1)
	psystem:setSizes(0.2,1,0.5)
	psystem:setSpinVariation(1)
	psystem:setAreaSpread("normal", 400,400)
	--psystem:setLinearAcceleration( -3, -3, 3, 3)
	--psystem:setLinearDamping(1,2)
	psystem:setSpeed(-10,10)
	psystem:setSpread(2*math.pi)
	psystem:setTangentialAcceleration(-20,20)
	--psystem:setLinearAcceleration(-20, -20, 20, 20) -- Random movement in all directions.
	psystem:setColors(255, 255, 255, 255, 255, 255, 255, 0) -- Fade to transparency.

	psystem:emit(100)

	particles[{
		system = psystem,
		pos = gameCenter,
		color = Color(5,7,109)
	}] = true
end

fundo()

function ParticleRenderer.drawOnce()

	for k in pairs(particles) do
		love.graphics.setColor(k.color:value())
		love.graphics.draw(k.system, k.pos.x, k.pos.y)
	end
end

function ParticleRenderer:updateOnce(dt)
	for k in pairs(particles) do
		k.system:update(dt)
	end
end