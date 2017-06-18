PowerupSpawner = Script({Arena})


local function spawn(t)
	local angle = love.math.random(0, 2*math.pi)
	local dist = love.math.random(0, t.arena.raio)
	local r = love.math.random(1, #tankPowerUp.indices)

	local pu = Treco(Position(gameCenter.x+math.cos(angle)*dist, gameCenter.y+math.sin(angle)*dist),
		Circoll(8),
		PowerUp(tankPowerUp.indices[r]),
		Trail({trails = {trail:new({
				type = "point",
				content = {
					type = "circle",
					radius = 20
				},
				fade = "shrink",
				amount = 5,
				duration = .5
			})}, color = Color.blue
		})
	)
	timer.tween(1, pu.circoll, {radius = gconf.powerup.radius}, 'out-elastic')
	--powerUpControler.powerups[pu] = true

	event.trigger("powerup_spawn", pu)
end

function PowerupSpawner:init(t)
	t.arena.powerupTimer = love.math.random(gconf.powerup.spawner.mintime, gconf.powerup.spawner.maxtime)
end

function PowerupSpawner:update(t, dt)
	t.arena.powerupTimer = t.arena.powerupTimer - dt

	if t.arena.powerupTimer < 0  and not t.arena.gameOver and t.arena.started then
		t.arena.powerupTimer = love.math.random(gconf.powerup.spawner.mintime, gconf.powerup.spawner.maxtime)
		spawn(t)
	end
end

function PowerupSpawner:keypressed(t,k)
	if k == "9" then
		spawn(t)
	end
end