BulletScript = Script({Bullet})
--[[
	BulletScript
	Renderiza e lida com colisão de bullets

	Teoricamente deveria ser 2 scripts, mas tem pouca coisa ainda
]]


--local maxBounce = 1		--Máximo de vezes que a bala pode quicar antes de explodir
local bulletRadius = 10	
local maxLife = 3
local minLife = 0.2		--Minimo de tempo para não colidir com nada(evita colidir com o próprio canhão de onde sai)

function BulletScript:init(b)
	b.bullet.lifeTimer = love.timer.getTime()
end

function BulletScript:update(b, dt)

	local bulletFilter = function(item, other)
		if other.tank then return "cross" end
		if other.bullet then return "cross" end
	end

	local nX, nY, cols = Physics:move(b, b.bullet.dir*b.bullet.speed*dt, bulletFilter)

	b.pos.x = nX
	b.pos.y = nY
	if (love.timer.getTime() - b.bullet.lifeTimer > minLife) then
		for k,col in pairs(cols) do
			--Colisão com bullet
			if col.other.bullet then
				if b.bullet.size > col.other.bullet.size then
					col.other:destroy()
				else
					b:destroy()
				end
				return
			end

			--Colisão com tank
			if col.other.tank then
				if not (col.other.tank.name == b.bullet.source.tank.name) then
					col.other.tank:damage(-1)
					b:destroy()
					return
				end
			end
		end

		--Colisão com a arena
		if vector.dist(b.pos, gameCenter) + b.bullet.size > gameArena.raio then
			if (love.timer.getTime() - b.bullet.lifeTimer > maxLife) then
				b:destroy()
				return
			end
			local normal = vector.normalize(b.pos-gameCenter)
			local aux = 2 * vector.dot(b.bullet.dir, normal)
					
			--jeito "normal"
			--b.bullet.dir = b.bullet.dir - normal * aux

			--Melhor desempenho
			vector.mul(normal, aux)
			vector.sub(b.bullet.dir, normal)
		end
	end

end

function BulletScript:draw(b)
	love.graphics.setColor(b.bullet.source.tank.color:value())
	love.graphics.circle("fill", b.pos.x, b.pos.y, b.bullet.size)
end