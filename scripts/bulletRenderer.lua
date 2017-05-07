BulletRenderer = Script({Bullet})

local maxBounce = 1
local bulletRadius = 8

function BulletRenderer:init(b)
	b.bullet.bounceCount = 0
end

function BulletRenderer:update(b, dt)

	local bulletFilter = function(item, other)
		if other.tank then return "cross"
		elseif other.bullet then return "slide"
		end
	end

	local nX, nY, cols = Physics:move(b, b.bullet.dir*b.bullet.speed*dt, bulletFilter)

	for k,col in pairs(cols) do
		if col.other.bullet then
			col.other:destroy()
			b:destroy()
			return
		end

		if col.other.tank then
			if not (col.other.status.name == b.bullet.source and b.bullet.bounceCount == 0) then
				col.other.status.life = col.other.status.life - 25
				b:destroy()
				return
			end
		end
	end

	b.pos.x = nX
	b.pos.y = nY

	if vector.dist(b.pos, gameCenter)+bulletRadius>gameArena.raio then
		b.bullet.bounceCount = b.bullet.bounceCount + 1
		if b.bullet.bounceCount > maxBounce then
			b:destroy()
		else
			b.bullet.dir = -b.bullet.dir
		end
	end

end

function BulletRenderer:draw(b)
	love.graphics.setColor(Color.blue:value())
	love.graphics.circle("fill", b.pos.x, b.pos.y, bulletRadius)
end
