BulletScript = Script({Bullet})
--[[
	BulletScript
	Renderiza e lida com colisão de bullets

	Teoricamente deveria ser 2 scripts, mas tem pouca coisa ainda
]]


--local maxBounce = 1		--Máximo de vezes que a bala pode quicar antes de explodir
local bulletRadius = 10

function BulletScript:init(b)
	b.bullet.lifeTimer = love.timer.getTime()
end

function BulletScript:update(b, dt)

	local bulletFilter = function(item, other)
		if other.tank then return "cross" end
		if other.bullet then return "cross" end
	end

	cols = b.circoll:move(b.bullet.dir*b.bullet.speed*dt, bulletFilter)

	if (love.timer.getTime() - b.bullet.lifeTimer > BS.bullet.minlife) then
		for k,col in pairs(cols) do
			-- Colisão com bullet
			if col.treco.bullet then
				if b.bullet.size < col.treco.bullet.size then
					b:destroy()
				end
				return
			end

			--Colisão com tank
            if col.treco.tank then
                if not (col.treco.tank.name == b.bullet.source.tank.name) then
                    col.treco.tank:damage(-1)
                    b:destroy()
                    return
                end
            end

            --Colisão com a arena
            if col.treco.arena then
				if (love.timer.getTime() - b.bullet.lifeTimer > BS.bullet.maxlife) then
	                b:destroy()
					return
				end
				local normal = vector.normalize(b.pos-b.bullet.source.tank.arena.pos)
				local aux = 2 * vector.dot(b.bullet.dir, normal)

				--jeito "normal"
				--b.bullet.dir = b.bullet.dir - normal * aux

				--Melhor desempenho
				vector.mul(normal, aux)
				vector.sub(b.bullet.dir, normal)
            end
		end

		--[[if vector.dist(b.pos, b.bullet.source.tank.arena.pos) + b.bullet.size > b.bullet.source.tank.arena.arena.raio then
		end]]
	end
end

function BulletScript:draw(b)
	love.graphics.setColor(b.bullet.source.tank.color:value())
    -- print(pos)
	love.graphics.circle("fill", b.pos.x, b.pos.y, b.bullet.size)
end
