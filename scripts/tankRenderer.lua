TankRenderer = Script({Tank})
--[[
	TankRenderer
	Renderiza o tank e seus respectivos indicadores de vida e tal
]]


local lifeMax = 3	--Podia pegar isso de outro lugar..
local barSize = 14	--Tamanho em graus da barra dos indicadores de potencia e vida

local singleLifeRad = math.floor(barSize/lifeMax)
local lifeBarSpacing = barSize/lifeMax

function TankRenderer:update(t, dt)
	t.pos = gameCenter+vector(math.cos(t.tank.pos)*(gameArena.raio-7), math.sin(t.tank.pos)*(gameArena.raio-7))
end

function TankRenderer:draw(t)
	--Atualiza posição real com a posição com rad
	t.pos = gameCenter+vector(math.cos(t.tank.pos)*(gameArena.raio-7), math.sin(t.tank.pos)*(gameArena.raio-7))
	
	--Desenha tank
	love.graphics.setColor(t.tank.color:value())
	love.graphics.circle("fill", t.pos.x, t.pos.y, 15)

	--Desenha vida
	--love.graphics.setColor(Color.red:value())
	for i=0,t.status.life-1 do
		--print(i, i * lifeBarSpacing - barSize/2, i * lifeBarSpacing - barSize/2 + singleLifeRad)
		love.graphics.arc("line", "open", gameCenter.x, gameCenter.y, gameArena.raio+18, t.tank.pos-math.rad(i * lifeBarSpacing - barSize/2), t.tank.pos-math.rad(i * lifeBarSpacing - barSize/2 + singleLifeRad))	
	end

	--Desenha força do tiro
	love.graphics.setLineWidth(10)
	love.graphics.setColor(map(t.status.holdtime, 0, 3, 255, 0), map(t.status.holdtime, 0, 3, 0, 150), map(t.status.holdtime, 0, 3, 0, 255))
	love.graphics.arc("line", "open", gameCenter.x, gameCenter.y, gameArena.raio+36, t.tank.pos-math.rad(barSize/2), t.tank.pos-math.rad(barSize/2) + map(t.status.holdtime, 0, 3, 0, math.rad(barSize)))

	
	
end
