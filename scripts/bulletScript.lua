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
			-- Colisão com bullet
			if col.shape.bullet then
				if b.bullet.size > col.shape.bullet.size then
					col.shape:destroy()
				else
					b.collider.shape:destroy()
                    b:destroy()
				end
				return
			end

			--Colisão com tank
            if col.shape.tank then
                if not (col.shape.tank.name == b.bullet.source.tank.name) then
                    col.shape.tank:damage(-1)
                    b.collider.shape:destroy()
                    b:destroy()
                    return
                end
            end
		end

		--Colisão com a arena
		if vector.dist(b.pos, b.bullet.source.tank.arena.pos) + b.bullet.size > b.bullet.source.tank.arena.arena.raio then
			if (love.timer.getTime() - b.bullet.lifeTimer > maxLife) then
                b.collider.shape:destroy()
                print("DESTROY")
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
end

function BulletScript:draw(b)
	love.graphics.setColor(b.bullet.source.tank.color:value())
    -- print(pos)
	love.graphics.circle("fill", b.pos.x, b.pos.y, b.bullet.size)
end
