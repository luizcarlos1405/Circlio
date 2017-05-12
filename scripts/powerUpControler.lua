powerUpControler = Script({Arena})

function powerUpControler:init(a)
    self.timer = love.math.random(PU.controler.mintime, PU.controler.maxtime)
    self.powerups = {}
end

function powerUpControler:update(a, dt)
    self.timer = self.timer - dt

    if self.timer < 0 then
        self.timer = love.math.random(PU.controler.mintime, PU.controler.maxtime)
        self:spawn(a)
    end

    for k,v in pairs(self.powerups) do
        local cols, mtv = k.circoll:move(k.powerup.vel)
        for _,col in pairs(cols) do
            --Colisão com tank
            if col.treco.tank then
                tankPowerUp:setPowerUp(col.treco, k.powerup.name)
                self.powerups[k] = nil
                k:destroy()
            -- Colisão com as balas
            elseif col.treco.bullet then
                -- Colisão com qualquer outra coisa
                -- Move o powerup e acelera na direção da colisão
                k.circoll:move(mtv/2)
                k.powerup.vel.x = k.powerup.vel.x + mtv.x/50
                k.powerup.vel.y = k.powerup.vel.y + mtv.y/50
                -- Move a bala e acelera na direção da colisão
                col.treco.circoll:move(mtv/-2)
                col.treco.bullet.dir = vector.normalize(vector(col.treco.bullet.dir.x - mtv.x/20, col.treco.bullet.dir.y - mtv.y/20))
                return
            --Colisão com a arena
            elseif col.treco.arena then
                local normal = vector.normalize(k.pos-gameCenter)
                local aux = 2 * vector.dot(k.powerup.vel, normal)

                --jeito "normal"
                --b.bullet.dir = b.bullet.dir - normal * aux

                --Melhor desempenho
                vector.mul(normal, aux)
                vector.sub(k.powerup.vel, normal)
            elseif col.treco.powerup then
                -- Move o powerup e acelera na direção da colisão
                k.circoll:move(mtv/2)
                k.powerup.vel.x = k.powerup.vel.x + mtv.x/50
                k.powerup.vel.y = k.powerup.vel.y + mtv.y/50

                -- Move o outro powerup
                col.treco.circoll:move(mtv/-2)
                col.treco.powerup.vel.x = col.treco.powerup.vel.x - mtv.x/50
                col.treco.powerup.vel.y = col.treco.powerup.vel.y - mtv.y/50
            else
                -- COlisão genérica, move apenas o powerup
                -- Move o powerup e acelera na direção da colisão
                k.circoll:move(mtv/2)
                k.powerup.vel.x = k.powerup.vel.x + mtv.x/50
                k.powerup.vel.y = k.powerup.vel.y + mtv.y/50
            end

        end
    end
end

function powerUpControler:draw(a)
    for k,v in pairs(self.powerups) do
        love.graphics.setLineWidth(PU.linewidth)
        love.graphics.setColor(k.powerup.color.r, k.powerup.color.g, k.powerup.color.b)
        love.graphics.circle('line', k.pos.x, k.pos.y, PU.radius)
    end
end

function powerUpControler:spawn(a)
    local angle = love.math.random(0, 2*math.pi)
    local dist = love.math.random(0, a.arena.raio)
    local r = love.math.random(1, #tankPowerUp.indices)
    print(#tankPowerUp.indices, r)

    local pu = Treco(Position(gameCenter.x+math.cos(angle)*dist, gameCenter.y+math.sin(angle)*dist),
    Circoll(PU.radius),
    PowerUp(tankPowerUp.indices[r]))
    self.powerups[pu] = true
end
