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
                return
            end

            -- Colisão com qualquer outra coisa
            -- print(mtv.x, mtv.y)
            k.circoll:move(mtv)
            k.powerup.vel.x = k.powerup.vel.x + mtv.x/50
            k.powerup.vel.y = k.powerup.vel.y + mtv.y/50
        end
        -- if gameCenter:dist(k.pos) > a.arena.raio then
        --     k.powerup.vel = vector.zero
        -- end
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
