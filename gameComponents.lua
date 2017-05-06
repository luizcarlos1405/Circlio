Tank = Component("tank", {
	arena = false,
	pos = 0,
	fireRate = 0.5,
	strong = 1,
	color = Color.blue
	}, function(arena, pos, color)
		return {arena = arena, pos = pos, color = color}
	end)

PlayerInput = Component("input", {
	left = "a",
	right = "d",
	shoot = "w"
	}, function(l,r,s)
		return {left = l, right = r, shoot = s}
	end)

Bullet = Component("bullet", {
	dir = false,
	speed = 200
	})

Arena = Component("arena", {
	raio = 100
	}, function(raio)
		return {raio = raio}
	end)
