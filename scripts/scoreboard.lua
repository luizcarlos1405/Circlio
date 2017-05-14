Scoreboard = Script({Arena})

local tanks = {}
local killLog = {}

function Scoreboard:init(t)
	event.listen("tank_spawn", function(t)
		tanks[t.tank] = 0
	end)

	event.listen("tank_die", function(t, source)
		killLog[#killLog+1] = {
			killer = source.bullet.source.tank,
			killed = t
		}
		tanks[source.bullet.source.tank] = tanks[source.bullet.source.tank] +1
	end)
end

function Scoreboard:draw(t)
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