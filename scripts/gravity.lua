Gravity = Script({Bullet})

local force = 1

function Gravity:update(t, dt)
	t.bullet.dir = t.bullet.dir + (t.pos-gameCenter):normalize()*force*dt

	--Gravidade real: estupidamente forte no centro
	--[[local relative = (t.pos-gameCenter)
	intensity = (1 / (relative:magnitude())) * force*dt;
	t.bullet.dir = t.bullet.dir + relative:normalize()*intensity]]

end