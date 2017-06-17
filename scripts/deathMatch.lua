deathMatch = Script({Arena})

local tanks = {}
local killLog = {}

local tankCont = 0

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
                    --timer.tween(2, t.arena, {winnerCircle = t.arena.raio-7}, "out-quint")
                    timer.tween(1.5, t.arena, {raio = 0}, "in-out-quint")
                    timer.tween(1.5, k.treco.pos, {x = t.pos.x, y = t.pos.y}, "in-out-quint")
                    timer.tween(1.5, k, {pos = k.pos-(k.pos%(2*math.pi)) + math.pi/2}, "in-out-quint")
                    break
                end
            end
            event.trigger("gameOver", t.arena)
        end
    end)
end

function deathMatch:draw(t)
    love.graphics.setColor(Color.black:value())
    for k,v in pairs(killLog) do
        love.graphics.print(v.killer.name.." matou "..v.killed.name, 0, 30*k)
    end
    local i = 0
    for k,v in pairs(tanks) do
        i = i + 1
        love.graphics.print(k.name..": \t"..v, 0, 400+30*i)
    end

    
    if t.arena.gameOver then
        love.graphics.setColor(Color.white:value())
        love.graphics.circle("fill", t.pos.x, t.pos.y, t.arena.winnerCircle)
        love.graphics.setColor(t.arena.winner.color:value())
        love.graphics.print("Winner!", t.pos.x-30, t.pos.y-80)
        love.graphics.print(t.arena.winner.name, t.pos.x-font:getWidth(t.arena.winner.name)/2, t.pos.y+40)
    end

end


function deathMatch:update(t, dt)
    -- Se tiver menos de três começa a diminuir a arena
    if tankCont <= 3 and tankCont > 1  and t.arena.started then
        t.circoll.radius = math.max(t.circoll.radius-20*dt, 100)
        t.arena.raio = t.circoll.radius
    end
    if tankCont == 1 and t.arena.started then
        t.arena.ended = true
    end
end
