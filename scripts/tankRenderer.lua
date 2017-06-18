TankRenderer = Script({Tank})
--[[
	TankRenderer
	Renderiza o tank e seus respectivos indicadores de vida e tal
]]


local barSize = 14	--Tamanho em graus da barra dos indicadores de potencia e vida

local letterSpacing = math.rad(1.6)

local singleLifeRad = math.floor(barSize/gconf.tank.maxLife)
local lifeBarSpacing = barSize/gconf.tank.maxLife


--Escala da textura
local scale = 0.06

function TankRenderer:init(t)
	t.tank.nameText = {}
	local stringAng = letterSpacing * string.len(t.tank.name)
	for i=1, t.tank.name:len() do
		t.tank.nameText[i] = love.graphics.newText(love.graphics.getFont(), string.sub(t.tank.name, i, i))
	end
end

function TankRenderer:update(t, dt)
end

function TankRenderer:draw(t)
	--hack pra separar as letras quando a arena encolhe
	letterSpacing = math.rad(1.6) + ((gconf.arena.size - t.tank.arena.arena.raio)/7000)
	
	love.graphics.setLineWidth(10)

	--Desenha tank
	--love.graphics.circle("fill", t.pos.x, t.pos.y, t.tank.size)
	love.graphics.setColor(t.tank.color:value())
	love.graphics.draw(R.texture.asa, t.pos.x, t.pos.y, t.tank.pos-math.pi/2, scale*t.tank.size, scale*t.tank.size, 317, 356)
	--love.graphics.draw(R.texture.asa2, t.pos.x, t.pos.y, t.tank.pos-math.pi/2, scale, scale, 317, 356)
	love.graphics.setColor(Color.white:value(t.tank.color.a))
	--love.graphics.draw(R.texture.asa3, t.pos.x, t.pos.y, t.tank.pos-math.pi/2, scale, scale, 317, 356)
	love.graphics.draw(R.texture.base, t.pos.x, t.pos.y, t.tank.pos-math.pi/2, scale*t.tank.size, scale*t.tank.size, 317, 356)
	love.graphics.setColor(t.tank.color:value())

	--love.graphics.arc("line", "open", t.tank.arena.pos.x, t.tank.arena.pos.y, t.tank.arena.arena.raio-7, t.tank.pos-0.1, t.tank.pos+0.1)

	if not t.tank.active  then return end

	if t.tank.life>0 then
		--Desenha vida
		--love.graphics.setColor(Color.red:value())
		for i=0,t.tank.life-1 do
			--print(i, i * lifeBarSpacing - barSize/2, i * lifeBarSpacing - barSize/2 + singleLifeRad)
			love.graphics.arc("line", "open", t.tank.arena.pos.x, t.tank.arena.pos.y, t.tank.arena.arena.raio+18, t.tank.pos-math.rad(i * lifeBarSpacing - barSize/2), t.tank.pos-math.rad(i * lifeBarSpacing - barSize/2 + singleLifeRad))
		end
		love.graphics.setLineWidth(2)
		for i=t.tank.life, gconf.tank.maxLife-1 do
			--print(i, i * lifeBarSpacing - barSize/2, i * lifeBarSpacing - barSize/2 + singleLifeRad)
			love.graphics.arc("line", "open", t.tank.arena.pos.x, t.tank.arena.pos.y, t.tank.arena.arena.raio+18, t.tank.pos-math.rad(i * lifeBarSpacing - barSize/2), t.tank.pos-math.rad(i * lifeBarSpacing - barSize/2 + singleLifeRad))
		end
	end

	if not t.tank.freeze then 	
		--Desenha bullet crescendo
		local bulletPos = t.tank.arena.pos+vector(math.cos(t.tank.pos)*(t.tank.arena.arena.raio-35), math.sin(t.tank.pos)*(t.tank.arena.arena.raio-35))
		if t.tank.isCharging then
			local bsize = 0.10+t.tank.holdtime/16
			local rndPos = t.tank.holdtime/2
			love.graphics.draw(R.texture.ball, bulletPos.x + math.random(-rndPos, rndPos), bulletPos.y + math.random(-rndPos, rndPos), 0, bsize, bsize, 50, 50)
			--love.graphics.circle("fill", bulletPos.x, bulletPos.y, 5+t.tank.holdtime*5)
		else
			local bsize = t.tank.cooldownBulletSize/4
			love.graphics.draw(R.texture.ball, bulletPos.x, bulletPos.y, 0, bsize, bsize, 50, 50)
			
			--love.graphics.circle("fill", bulletPos.x, bulletPos.y, t.tank.cooldownBulletSize)
		end
	end

	love.graphics.setLineWidth(10)
	--Desenha força do tiro
	--[[love.graphics.setColor(map(t.tank.holdtime, 0, 3, 255, 0), map(t.tank.holdtime, 0, 3, 0, 150), map(t.tank.holdtime, 0, 3, 0, 255))
	love.graphics.arc("line", "open", t.tank.arena.pos.x, t.tank.arena.pos.y, t.tank.arena.arena.raio+36,
		t.tank.pos - math.rad(barSize/2) + map(t.tank.holdtime, 3, 0, 0, math.rad(barSize/2)),
		t.tank.pos + math.rad(barSize/2) - map(t.tank.holdtime, 3, 0, 0, math.rad(barSize/2)))]]

	--love.graphics.setColor(r.label.color.r, r.label.color.g, r.label.color.b, r.label.color.a)

	local stringAng = letterSpacing * string.len(t.tank.name)
	for i,text in ipairs(t.tank.nameText) do
		love.graphics.draw(text,
			t.tank.arena.pos.x + (math.cos((t.tank.pos - stringAng/2 + letterSpacing/2)+letterSpacing*(i-1))*(t.tank.arena.arena.raio+40)),
			t.tank.arena.pos.y + (math.sin((t.tank.pos - stringAng/2 + letterSpacing/2)+ letterSpacing*(i-1))*(t.tank.arena.arena.raio+40)),
			math.rad(90)+(t.tank.pos - stringAng/2 + letterSpacing/2)+ letterSpacing*(i-1),
			1, 1, text:getWidth()/2, text:getHeight()/2)
	end

end
