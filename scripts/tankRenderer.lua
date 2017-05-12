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
	t.pos = t.tank.arena.pos+vector(math.cos(t.tank.pos)*(t.tank.arena.arena.raio-7), math.sin(t.tank.pos)*(t.tank.arena.arena.raio-7))
end

function TankRenderer:draw(t)
	--Atualiza posição real com a posição com rad
	t.pos = t.tank.arena.pos+vector(math.cos(t.tank.pos)*(t.tank.arena.arena.raio-7), math.sin(t.tank.pos)*(t.tank.arena.arena.raio-7))
	
	love.graphics.setLineWidth(10)
	love.graphics.setColor(t.tank.color:value())

	--Desenha tank
	love.graphics.circle("fill", t.pos.x, t.pos.y, 15)
	--love.graphics.arc("line", "open", t.tank.arena.pos.x, t.tank.arena.pos.y, t.tank.arena.arena.raio-7, t.tank.pos-0.1, t.tank.pos+0.1)	

	--Desenha vida
	--love.graphics.setColor(Color.red:value())
	for i=0,t.tank.life-1 do
		--print(i, i * lifeBarSpacing - barSize/2, i * lifeBarSpacing - barSize/2 + singleLifeRad)
		love.graphics.arc("line", "open", t.tank.arena.pos.x, t.tank.arena.pos.y, t.tank.arena.arena.raio+18, t.tank.pos-math.rad(i * lifeBarSpacing - barSize/2), t.tank.pos-math.rad(i * lifeBarSpacing - barSize/2 + singleLifeRad))	
	end
	love.graphics.setLineWidth(2)
	for i=t.tank.life, lifeMax-1 do
		--print(i, i * lifeBarSpacing - barSize/2, i * lifeBarSpacing - barSize/2 + singleLifeRad)
		love.graphics.arc("line", "open", t.tank.arena.pos.x, t.tank.arena.pos.y, t.tank.arena.arena.raio+18, t.tank.pos-math.rad(i * lifeBarSpacing - barSize/2), t.tank.pos-math.rad(i * lifeBarSpacing - barSize/2 + singleLifeRad))	
	end

	--Desenha bullet crescendo
	local bulletPos = t.tank.arena.pos+vector(math.cos(t.tank.pos)*(t.tank.arena.arena.raio-35), math.sin(t.tank.pos)*(t.tank.arena.arena.raio-35))
	if t.tank.isCharging then
		love.graphics.circle("fill", bulletPos.x, bulletPos.y, 5+t.tank.holdtime*5)
	else
		love.graphics.circle("fill", bulletPos.x, bulletPos.y, t.tank.cooldownBulletSize)
	end

	love.graphics.setLineWidth(10)
	--Desenha força do tiro
	love.graphics.setColor(map(t.tank.holdtime, 0, 3, 255, 0), map(t.tank.holdtime, 0, 3, 0, 150), map(t.tank.holdtime, 0, 3, 0, 255))
	love.graphics.arc("line", "open", t.tank.arena.pos.x, t.tank.arena.pos.y, t.tank.arena.arena.raio+36, 
		t.tank.pos - math.rad(barSize/2) + map(t.tank.holdtime, 3, 0, 0, math.rad(barSize/2)), 
		t.tank.pos + math.rad(barSize/2) - map(t.tank.holdtime, 3, 0, 0, math.rad(barSize/2)))

	
	
end
