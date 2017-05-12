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
        --local nX, nY, cols = Physics:move(v, {x=0,y=0})
        v:destroy()
    end

end

function powerUpControler:spawn(a)
    local angle = love.math.random(0, 2*math.pi)
    local pu = Treco(Position(gameCenter.x+math.cos(angle)*a.arena.raio, gameCenter.y+math.sin(angle)*a.arena.raio),
    AllCollider(12),
    PowerUp("Life"))
    table.insert(self.powerups, pu)
end
