BulletScript = Script({Bullet})
--[[
	BulletScript
	Renderiza e lida com colisão de bullets

	Teoricamente deveria ser 2 scripts, mas tem pouca coisa ainda
]]

local bulletRadius = 10

function BulletScript:init(b)
	b.bullet.lifeTimer = love.timer.getTime()
end

function BulletScript:update(b, dt)

	local bulletFilter = function(item, other)
		if other.tank then return "cross" end
		if other.bullet then return "cross" end
	end

	local cols, mtv = b.circoll:move(b.bullet.dir*b.bullet.speed*dt, bulletFilter)

	for k,col in pairs(cols) do
		-- Colisão com bullet
		if col.treco.bullet then
			if b.bullet.size < col.treco.bullet.size then
				b:destroy()
                return
			end
		--Colisão com tank
        elseif col.treco.tank then
            -- Se colide com tank pra não poder "pegar na faca"
            if (love.timer.getTime() - b.bullet.lifeTimer > gconf.bullet.minlife) then
                if not (col.treco.tank.name == b.bullet.source.tank.name) then
                    col.treco.tank:damage(-1, b)
                    b:destroy()
                    event.trigger("tank_hit", col.treco)
                    return
                end
            end
        --Colisão com powerup
        elseif col.treco.powerup then

			local normal = vector.normalize(b.pos-col.treco.pos)
			local aux = 2 * vector.dot(b.bullet.dir, normal)
			vector.mul(normal, aux)
			vector.sub(b.bullet.dir, normal)

			vector.add(col.treco.powerup.vel,  normal * b.bullet.speed/15)

    		--Não sei o que mtv faz, mas isso aqui parece funcionar
    		vector.add(b.pos, mtv)

        --Colisão com a arena
        elseif col.treco.arena then
			if (love.timer.getTime() - b.bullet.lifeTimer > gconf.bullet.maxlife) then
                b:destroy()
				return
			end
			local normal = vector.normalize(b.pos-b.bullet.source.tank.arena.pos)
			local aux = 2 * vector.dot(b.bullet.dir, normal)

			--jeito "normal"
			-- b.bullet.dir = b.bullet.dir - normal * aux

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
