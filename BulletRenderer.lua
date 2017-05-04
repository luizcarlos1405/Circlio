BulletRenderer = Script({Bullet})

local vel = 50

function BulletRenderer:update(b, dt)
	b.pos = b.pos + b.bullet.dir*vel*dt
end

function BulletRenderer:draw(b)
	love.graphics.setColor(Color.blue:value())
	love.graphics.circle("fill", b.pos.x, b.pos.y, 5)	
end