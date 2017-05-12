Tank = Component("tank", {
    name = "Player",
    arena = false,
    pos = 0,
    color = Color.blue,
    life = 3,
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

Bullet = Component("bullet", {
	dir = false,
	speed = 200,
	size = 10,
	source = "none"
	})

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
        name = "Life"
    }, function(name)
        return {name = name}
    end)

Circoll = Component("circoll",{
	radius = 10,
	invert = false
	}, function(r, i)
		return {radius = r, invert = i}
	end)
