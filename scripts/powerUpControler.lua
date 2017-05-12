powerUpControler = Script({Arena})

function powerUpControler:init(a)
    self.timer = love.math.random(PU.controler.mintime, PU.controler.maxtime)
    self.powerups = {}
    self.vel = vector(0,0)
end

function powerUpControler:update(a, dt)
    self.timer = self.timer - dt

    if self.timer < 0 then
        self.timer = love.math.random(PU.controler.mintime, PU.controler.maxtime)
        self:spawn(a)
    end

    for k,v in pairs(self.powerups) do
        local cols, mtv = k.circoll:move(self.vel)
        for _,col in pairs(cols) do
            --Colisão com tank
            if col.treco.tank then
                tankPowerUp:setPowerUp(col.treco, k.powerup.name)
                self.powerups[k] = nil
                k:destroy()
                return
            end

            -- Colisão com bullet
            if col.treco.bullet then
                -- self.vel.x = self.vel.x + dt*mtv.x/20
                -- self.vel.y = self.vel.y + dt*mtv.y/20
            end
        end
    end
end

function powerUpControler:spawn(a)
    local angle = love.math.random(0, 2*math.pi)
    local pu = Treco(Position(gameCenter.x+math.cos(angle)*a.arena.raio, gameCenter.y+math.sin(angle)*a.arena.raio),
    Circoll(12),
    PowerUp("Life"))
    self.powerups[pu] = true
end
