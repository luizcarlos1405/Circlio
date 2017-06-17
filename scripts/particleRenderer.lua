ParticleRenderer = Script()

local psystem



local particles = {}

event.listen("tank_die", function(tank)
	local psystem = love.graphics.newParticleSystem(R.texture.tankDie, 100)
	psystem:setParticleLifetime(1.5,2) -- Particles live at least 2s and at most 5s.
	psystem:setEmissionRate(200)
	psystem:setSizeVariation(1)
	psystem:setSizes(0.2,1,0.5)
	psystem:setSpin(-10,10)
	psystem:setSpinVariation(1)
	psystem:setAreaSpread("normal", tank.size, tank.size)
	--psystem:setLinearAcceleration( -3, -3, 3, 3)
	psystem:setLinearDamping(1,2)
	psystem:setSpeed(-200,200)
	psystem:setSpread(2*math.pi)
	--psystem:setLinearAcceleration(-20, -20, 20, 20) -- Random movement in all directions.
	psystem:setColors(255, 255, 255, 255, 255, 255, 255, 0) -- Fade to transparency.

	particles[tank] = {
		system = psystem,
		pos = tank.treco.pos,
		color = tank.color:clone()
	}
	
	timer.after(1.2, function()
		psystem:stop()
		timer.after(2,function()
			particles[tank] = nil
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

	particles[1] = {
		system = psystem,
		pos = gameCenter,
		color = Color(5,7,109)
	}
end

fundo()

function ParticleRenderer.drawOnce()

	for k,v in pairs(particles) do
		love.graphics.setColor(v.color:value())
		love.graphics.draw(v.system, v.pos.x, v.pos.y)
	end
end

function ParticleRenderer:updateOnce(dt)
	for k,v in pairs(particles) do
		v.system:update(dt)
	end
end