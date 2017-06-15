Gravity = Script({Bullet})

local force = 3
local pos = 0
local center = gameCenter-- +vector(100,100)

function Gravity:update(t, dt)
	t.bullet.dir = t.bullet.dir - (t.pos-center):normalize()*force*dt

	--Gravidade real: estupidamente forte no centro
	--[[local relative = (t.pos-gameCenter)
	intensity = (1 / (relative:magnitude())) * force*dt;
	t.bullet.dir = t.bullet.dir + relative:normalize()*intensity]]
end

function Gravity:updateOnce(dt)
	pos = pos + dt
	center = gameCenter + vector(math.cos(pos)*(100), math.sin(pos)*(100))
end

function Gravity:draw(t)
	love.graphics.setColor(Color.white:value())
	love.graphics.circle("fill", center.x, center.y, 10)
end