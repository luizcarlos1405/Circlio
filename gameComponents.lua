Tank = Component("tank", {
	name = "Player",
	arena = false,
	pos = 0,
	color = Color.blue,
	life = 3,
	firerate = 0.5
	}, function(name, arena, pos, color, life, firerate)
		return {name = name, arena = arena, pos = pos, color = color, life = life, firerate = firerate}
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
	source = "none"
	})

Arena = Component("arena", {
	raio = 100
	}, function(raio)
		return {raio = raio}
	end)

Bot = Component("bot", {})