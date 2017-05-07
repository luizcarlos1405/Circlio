Tank = Component("tank", {
	arena = false,
	pos = 0,
	color = Color.blue,
	}, function(arena, pos, color, holdbar)
		return {arena = arena, pos = pos, color = color}
	end)

PlayerInput = Component("input", {
	left = "a",
	right = "d",
	shoot = "w"
	}, function(l,r,s)
		return {left = l, right = r, shoot = s}
	end)

PlayerStatus = Component("status", {
	life = 100,
	cooldown = 0,
	holdtime = 0,
	fireRate = 0.5,
	name = "Player"
	}, function(l, c, h, f, n)
		return {life = l, cooldown = c, holdtime = h, fireRate = f, name = n}
	end
)

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
