deathMatch = Script({Arena})

local tanks = {}
local killLog = {}

local tankCont = 0

function deathMatch:init(t)
    event.listen("tank_spawn", function(t)
        tanks[t.tank] = 0
        tankCont = tankCont + 1
    end)

    event.listen("tank_die", function(t, source)
        tankCont = tankCont - 1
        killLog[#killLog+1] = {
            killer = source.bullet.source.tank,
            killed = t
        }
        tanks[source.bullet.source.tank] = tanks[source.bullet.source.tank] +1
    end)
end

function deathMatch:draw(t)
    love.graphics.setColor(Color.white:value())
    for k,v in pairs(killLog) do
        love.graphics.print(v.killer.name.." matou "..v.killed.name, 0, 30*k)
    end
    local i = 0
    for k,v in pairs(tanks) do
        i = i + 1
        love.graphics.print(k.name..": \t"..v, 0, 400+30*i)
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
