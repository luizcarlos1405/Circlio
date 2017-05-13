powerUpControler = Script({Arena})

local function spawn(a)
    local angle = love.math.random(0, 2*math.pi)
    local dist = love.math.random(0, a.arena.raio)
    local r = love.math.random(1, #tankPowerUp.indices)

    local pu = Treco(Position(gameCenter.x+math.cos(angle)*dist, gameCenter.y+math.sin(angle)*dist),
    Circoll(8),
    PowerUp(tankPowerUp.indices[r]))
    timer.tween(1, pu.circoll, {radius = PU.radius}, 'out-elastic')
    powerUpControler.powerups[pu] = true

    -- Efeito sonoro variando a nota entre 70% e 100% do ton original
    effect.powerupAppear:play({pitch = love.math.random(7, 10)/10})
end

function powerUpControler:init(a)
    self.timer = love.math.random(PU.controler.mintime, PU.controler.maxtime)
    self.powerups = {}
end

function powerUpControler:update(a, dt)
    self.timer = self.timer - dt

    if self.timer < 0 then
        self.timer = love.math.random(PU.controler.mintime, PU.controler.maxtime)
        spawn(a)
    end

    for k,v in pairs(self.powerups) do
        local cols, mtv = k.circoll:move(k.powerup.vel * dt)
        for _,col in pairs(cols) do
            --Colisão com tank
            if col.treco.tank then
                tankPowerUp:setPowerUp(col.treco, k.powerup.name)
                self.powerups[k] = nil
                k:destroy()
                -- Efeito sonoro de pegar powerup
                effect.powerupPick:play()
            -- Colisão com as balas
            elseif col.treco.bullet then
                -- Colisão com qualquer outra coisa
                -- Move o powerup e acelera na direção da colisão
                k.circoll:move(mtv/2)
                k.powerup.vel.x = k.powerup.vel.x + mtv.x * PU.mtvFactor
                k.powerup.vel.y = k.powerup.vel.y + mtv.y * PU.mtvFactor
                -- Move a bala e acelera na direção da colisão
                col.treco.circoll:move(mtv/-2)
                col.treco.bullet.dir = vector.normalize(vector(col.treco.bullet.dir.x - mtv.x/BS.bullet.mtvFactor, col.treco.bullet.dir.y - mtv.y/BS.bullet.mtvFactor))
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
                k.powerup.vel.x = k.powerup.vel.x + mtv.x * PU.mtvFactor
                k.powerup.vel.y = k.powerup.vel.y + mtv.y * PU.mtvFactor

                -- Move o outro powerup
                col.treco.circoll:move(mtv/-2)
                col.treco.powerup.vel.x = col.treco.powerup.vel.x - mtv.x * PU.mtvFactor
                col.treco.powerup.vel.y = col.treco.powerup.vel.y - mtv.y * PU.mtvFactor
            else
                -- COlisão genérica, move apenas o powerup
                -- Move o powerup e acelera na direção da colisão
                k.circoll:move(mtv/2)
                k.powerup.vel.x = k.powerup.vel.x + mtv.x * PU.mtvFactor
                k.powerup.vel.y = k.powerup.vel.y + mtv.y * PU.mtvFactor
            end

        end
    end
end

function powerUpControler:draw(a)
    for k,v in pairs(self.powerups) do
        love.graphics.setLineWidth(PU.linewidth)
        love.graphics.setColor(k.powerup.color.r, k.powerup.color.g, k.powerup.color.b)
        love.graphics.circle('fill', k.pos.x, k.pos.y, k.circoll.radius)

        -- Nome
        local s = ""
        for uppercase in string.gmatch(k.powerup.name, "%u") do
            s = s..uppercase
        end
        love.graphics.setColor(255, 255, 255)
        love.graphics.print(s, k.pos.x - 5 * s:len(), k.pos.y - 15)
    end
end
