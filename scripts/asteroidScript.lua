AsteroidScript = Script({Asteroid})

function AsteroidScript:init(t)

end

function AsteroidScript:update(t, dt)

end

function AsteroidScript:draw(t)
	love.graphics.setColor(200, 200, 200)
	love.graphics.circle("fill", t.pos.x, t.pos.y, t.asteroid.size)
end