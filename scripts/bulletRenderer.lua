BulletRenderer = Script({Bullet})


function BulletRenderer:update(b, dt)
	b.pos = b.pos + b.bullet.dir*b.bullet.speed*dt

	if vector.dist(b.pos, gameCenter)>gameArena.raio then
		b:destroy()
	end
end

function BulletRenderer:draw(b)
	love.graphics.setColor(Color.blue:value())
	love.graphics.circle("fill", b.pos.x, b.pos.y, 5)	
end