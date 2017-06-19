gconf = {}
-- Música e sons
gconf.music = {
	active = true,
	volume = 1	-- Volume de 0 a 1
}

gconf.tank = {
	firerate = 0.2,
	maxLife = 5,
    dashCooldown = 1
}

-- Power Ups
gconf.powerup = {
	radius = 20,
	color = Color(32, 5, 183),
	linewidth = 4,
	mtvFactor = 30, -- Varia nível de desvio ao atingir uma bala
	fastfire = {
		time = 8,
		mod = 0.5
	},
	speedboost = {
		time = 5,
		mod = 2
	},
	spreadshot = {
		time = 4,
		mod = math.pi/20
	},
	spawner = {
		mintime = 5,
		maxtime = 10
	}
}

gconf.bullet = {
	speed = 200,
	radius = 10,
	maxlife = 3,
	minlife = 0.2,
    maxHoldTime = 3,
	mtvFactor = 20, 	-- Varia nível de desvio ao atingir um powerupp
	size = 5,
	inercia = math.pi/30, -- O quanto a bala vai desviar em radianos por ser atirada andando
    collOffset = 1.4 -- Multiplica o offset que é baseado no raio da bullet
}

gconf.arena = {
	size = gameHeight/2 - 50
}
