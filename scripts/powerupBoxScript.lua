PowerupBoxScript = Script({PowerUp})

function PowerupBoxScript:update(t, dt)

	local cols, mtv = t.circoll:move(t.powerup.vel * dt)
	for _,col in pairs(cols) do
		--Colisão com tank
		if col.treco.tank then
			tankPowerUp:setPowerUp(col.treco, t.powerup.name)
			t:destroy()
			event.trigger("powerup_pickup", t.powerup, col.treco.tank)
        -- Colisão com a arena
		elseif col.treco.arena then
			local normal = vector.normalize(t.pos-gameCenter)
			local aux = 2 * vector.dot(t.powerup.vel, normal)

			vector.mul(normal, aux)
			vector.sub(t.powerup.vel, normal)
        -- Colisão com outro powerup
		elseif col.treco.powerup then
			-- Move o powerup e acelera na direção da colisão
			t.circoll:move(mtv/2)
			t.powerup.vel.x = t.powerup.vel.x + mtv.x * gconf.powerup.mtvFactor
			t.powerup.vel.y = t.powerup.vel.y + mtv.y * gconf.powerup.mtvFactor

			-- Move o outro powerup
			col.treco.circoll:move(mtv/-2)
			col.treco.powerup.vel.x = col.treco.powerup.vel.x - mtv.x * gconf.powerup.mtvFactor
			col.treco.powerup.vel.y = col.treco.powerup.vel.y - mtv.y * gconf.powerup.mtvFactor
		else
			-- Colisão genérica, move apenas o powerup
			-- Move o powerup e acelera na direção da colisão
			t.circoll:move(mtv/2)
			t.powerup.vel.x = t.powerup.vel.x + mtv.x * gconf.powerup.mtvFactor
			t.powerup.vel.y = t.powerup.vel.y + mtv.y * gconf.powerup.mtvFactor
		end

	end
end

function PowerupBoxScript:draw(t)
	love.graphics.setLineWidth(gconf.powerup.linewidth)
	love.graphics.setColor(t.powerup.color.r, t.powerup.color.g, t.powerup.color.b)
	love.graphics.circle('fill', t.pos.x, t.pos.y, t.circoll.radius)

	-- Nome
	local s = t.powerup.name:match("."):upper()
	for uppercase in string.gmatch(t.powerup.name, "%u") do
		s = s..uppercase
	end
	love.graphics.setColor(255, 255, 255)
	love.graphics.print(s, t.pos.x - 5 * s:len(), t.pos.y - 15)
end
