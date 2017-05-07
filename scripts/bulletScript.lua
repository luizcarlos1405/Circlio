BulletScript = Script({Bullet})
--[[
	BulletScript
	Renderiza e lida com colisão de bullets

	Teoricamente deveria ser 2 scripts, mas tem pouca coisa ainda
]]


local maxBounce = 1		--Máximo de vezes que a bala pode quicar antes de explodir
local bulletRadius = 8	

function BulletScript:init(b)
	b.bullet.bounceCount = 0
end

function BulletScript:update(b, dt)

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
				col.other.status.life = col.other.status.life - 1
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

function BulletScript:draw(b)
	love.graphics.setColor(Color.blue:value())
	love.graphics.circle("fill", b.pos.x, b.pos.y, bulletRadius)
end
