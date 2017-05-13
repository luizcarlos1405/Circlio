deathMatch = Script({Tank})
deathMatch.tanks = {}

function deathMatch:init(t)
    -- Insere na tale todos os tanks
    table.insert(self.tanks, t)
end

function deathMatch:updateOnce(dt)
    -- Tira da table tanks destruídos
    for i,v in pairs(self.tanks) do
        if v.toDestroy == true then
            table.remove(self.tanks, i)
        end
    end

    -- Se tiver menos de três começa a diminuir a arena
    if #self.tanks <= 3 and #self.tanks > 1 then
        gameArena.treco.circoll.radius = math.max(gameArena.treco.circoll.radius-20*dt, 100)
        gameArena.raio = gameArena.treco.circoll.radius
    end
end
