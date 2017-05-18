Tank = Component("tank", {
    name = "Player",
    arena = false,
    pos = 0,
    color = Color.blue,
    life = gconf.tank.maxLife,
    firerate = 0.5,
    maxSpeed = 1.4,
    powerups = {FastFire = false,
    SpreadShot = false,
    SpeedBoost = false
    },
}, function(name, arena, pos, color, life, firerate, maxSpeed)
        return {name = name, arena = arena, pos = pos, color = color, life = life, firerate = firerate, maxSpeed = maxSpeed}
	end)

KeyboardInput = Component("kbInput", {
	left = "a",
	right = "d",
	shoot = "w"
	}, function(l,r,s)
		return {left = l, right = r, shoot = s}
	end)

JoystickInput = Component("jsInput", {
    jsnumber = 1,
    shoot = 1
}, function(n, s)
		return {jsnumber = n, shoot = s}
	end)


Bullet = Component("bullet", {
	dir = false,
	speed = gconf.bullet.speed,
	size = gconf.bullet.radius,
	source = "none"
	})

Trail = Component("trail", {
	trails = {}
	}
)

Arena = Component("arena", {
	raio = 100
	}, function(raio)
		return {raio = raio}
	end)

Bot = Component("bot", {})

Asteroid = Component("asteroid", {
	dir = vector(),
	size = 27
	})

PowerUp = Component("powerup",{
        name = "Life",
        vel = vector.zero,
        color = gconf.powerup.color
    }, function(name, vel)
        return {name = name, vel = vel}
    end)

Circoll = Component("circoll",{
	radius = 10,
	invert = false
	}, function(r, i)
		return {radius = r, invert = i}
	end)
