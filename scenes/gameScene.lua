gameScene = Scene("gameScene")

raio = gameHeight/2 - 10

Tank = Component("tank", {
	pos = 0
	})

Bullet = Component("bullet", {
	dir = false
	})

require("TankRenderer")
require("BulletRenderer")

function gameScene:init()
	Player = Treco("asdqwe", {Tank})

end

function gameScene:update(dt)
	if (love.keyboard.isDown("a")) then
		Player.tank.pos = Player.tank.pos + 5*dt
	end
	if (love.keyboard.isDown("d")) then
		Player.tank.pos = Player.tank.pos - 5*dt
	end

	if (love.keyboard.isDown("space")) then
		Treco("bul", {Position({x = Player.pos.x, y = Player.pos.y}), Bullet({dir = vector.normalize(gameCenter-Player.pos)})})
	end
end

function gameScene:draw()
	love.graphics.setColor(Color.white:value())
    love.graphics.setLineWidth(10)
    love.graphics.circle("line", gameWidth/2, gameHeight/2, raio)
end

return gameScene
