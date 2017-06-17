ArenaRenderer = Script({Arena})

local decal = R.texture.decal3

local decalOffset = vector(decal:getWidth()/2, decal:getHeight()/2)

local function addDecal(a, p, color, s)
	a.decals[#a.decals+1] = {
		p = p,
		color = color:clone(),
		r = math.random(0, 2*math.pi),
		s = s or 1
	}
	a.decals[#a.decals].color.a = 200
end

function ArenaRenderer:init(t)

	t.arena.decals = {}
	for i=1,10 do
		--addDecal(t.arena, math.random(0,2*math.pi), Color.blue)
	end
	
	t.arena.addDecal = addDecal
	t.drawFunc = function()
		--Diminuir apenas raio interno
		--[[local outer = 348-t.arena.raio
	    love.graphics.setLineWidth(outer)
	    love.graphics.circle("line", t.pos.x, t.pos.y, t.arena.raio+outer/2)]]

	    love.graphics.setLineWidth(15)
	    love.graphics.circle("line", t.pos.x, t.pos.y, t.arena.raio)

	end
	t.drawFunc2 = function()
	    love.graphics.circle("fill", t.pos.x, t.pos.y, t.arena.raio-8)
	end
end

function ArenaRenderer:draw(t)
	love.graphics.setColor(Color.white:value())
    t.drawFunc()
    love.graphics.stencil(t.drawFunc, "replace", 1)
    love.graphics.setStencilTest("greater", 0)    

    --Comenta essas 4 linhas pra voltar pra trilho
    --[[love.graphics.stencil(t.drawFunc2, "replace", 1)
    love.graphics.setColor(Color(200):value())
    love.graphics.setStencilTest("less", 1)
    love.graphics.rectangle("fill", 0, 0, 2000, 1200)]]

    for i,v in ipairs(t.arena.decals) do
    	love.graphics.circle("fill", t.pos.x, t.pos.y, 10)
        love.graphics.setColor(v.color:value())
        if type(v.p)=="number" then
	    	love.graphics.draw(decal, t.pos.x + math.cos(v.p)*t.arena.raio, t.pos.y + math.sin(v.p)*t.arena.raio,v.r, v.s, v.s, decalOffset.x, decalOffset.y)
	    else

	    	love.graphics.draw(decal, v.p.x, v.p.y,v.r, v.s, v.s, decalOffset.x, decalOffset.y)
	    end
    end
    love.graphics.setStencilTest()
end