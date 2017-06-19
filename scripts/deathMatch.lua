deathMatch = Script({Arena})

local tanks = {}
local killLog = {}

local tankCont = 0

local gameTimer = 0

local reseting = false

local function reset(t)
    if reseting then return end
    reseting = true
    t.arena.decals = {}

    tanks = {}
    killLog = {}

    timer.tween(1.5, t.arena, {winnerCircle = 0}, "in-out-quint")
    timer.tween(1.5, t.arena, {raio = gconf.arena.size}, "in-out-quint")
    timer.tween(1.5, t.circoll, {radius = gconf.arena.size}, "in-out-quint")
    timer.tween(1.5, t.arena.bgColor, {a = 0, r = 255, g = 255, b = 255}, "in-out-quint")
    timer.tween(1.5, t.arena.winner, {size = 0, pos = 10}, "in-out-quint", function()
        t.arena.winner.treco:destroy()
        t.arena.gameOver = false
        t.arena.started = false
        t.arena.winner = nil
        tankCont = 0
        gameTimer = 0
        reseting = false
    end)
end

function deathMatch:init(t)

    t.arena.gameOver = false
    t.arena.winner = nil
    t.arena.winnerCircle = 0

    event.listen("tank_spawn", function(t)
        tanks[t.tank] = 0
        tankCont = tankCont + 1
    end)

    event.listen("tank_die", function(tank, source)
        tankCont = tankCont - 1
        killLog[#killLog+1] = {
            killer = source.bullet.source.tank,
            killed = tank
        }
        tanks[source.bullet.source.tank] = tanks[source.bullet.source.tank] +1

        if tankCont == 1 then
            t.arena.gameOver = true
            for k,v in pairs(tanks) do
                if k.active then
                    t.arena.winner = k
                    k.active = false
                    k.freeze = true
                    timer.tween(1.5, t.arena, {winnerCircle = 100}, "in-out-quint")
                    timer.tween(1.5, t.arena, {raio = 0}, "in-out-quint")
                    timer.tween(1.5, t.circoll, {radius = 0}, "in-out-quint")
                    timer.tween(1.5, t.arena.bgColor, {a = 255, r = k.color.r, g = k.color.g, b = k.color.b}, "in-out-quint")
                    timer.tween(1.5, k.treco.pos, {x = t.pos.x, y = t.pos.y}, "in-out-quint")
                    timer.tween(1.5, k, {size = 1.5, pos = k.pos-(k.pos%(2*math.pi)) + math.pi/2}, "in-out-quint")
                    break
                end
            end
            event.trigger("gameOver", t.arena)

            --[[timer.after(5, function()
                reset(t)
            end)]]
        end
    end)
end

function deathMatch:draw(t)
    love.graphics.setColor(Color.white:value())
    -- for k,v in pairs(killLog) do
    --     love.graphics.print(v.killer.name.." matou "..v.killed.name, 0, 30*k)
    -- end
    for i= 1, #killLog do
        love.graphics.setColor(255, 255, 255, 155 + i * 20)
        love.graphics.print(killLog[i].killer.name.." matou "..killLog[i].killed.name, gameWidth - 200, 30*i - 20)
    end
    if #killLog >= 6 then
        for i=1,#killLog-5 do
            table.remove(killLog, i)
        end
    end

    love.graphics.setColor(255, 255, 255, 255)

    local i = 0
    for k,v in pairs(tanks) do
        i = i + 1
        love.graphics.print(k.name..": \t"..v, 10, 30*i - 20)
    end


    love.graphics.print(string.format("%02d:%02d", math.floor(gameTimer/60), math.floor(gameTimer%60)), gameCenter.x-25, 10)

    if t.arena.gameOver then
        love.graphics.setColor(Color.white:value(200))
        love.graphics.circle("fill", t.pos.x, t.pos.y, t.arena.winnerCircle)
        love.graphics.setColor(t.arena.bgColor:value())
        love.graphics.print("Winner!", t.pos.x-30, t.pos.y-80)
        love.graphics.print(t.arena.winner.name, t.pos.x-font:getWidth(t.arena.winner.name)/2, t.pos.y+40)

        love.graphics.setColor(Color.white:value())
        love.graphics.print("[R]eset", t.pos.x-font:getWidth("[R]eset")/2, push:getHeight()-40)

    end

end

function deathMatch:update(t, dt)
    if t.arena.started and not t.arena.gameOver then
        gameTimer = gameTimer + dt
    end
    -- Se tiver menos de três começa a diminuir a arena
    if tankCont <= 3 and tankCont > 1  and t.arena.started then
        t.circoll.radius = math.max(t.circoll.radius-20*dt, 100)
        t.arena.raio = t.circoll.radius
    end
    if tankCont == 1 and t.arena.started then
        t.arena.ended = true
    end
end

function deathMatch:keyreleased(t, k)
    if t.arena.gameOver and k == "r" then
        reset(t)    end
end
