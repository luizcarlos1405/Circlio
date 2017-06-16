ArenaRenderer = Script({Arena})

local function addDecal(a, p, color)
	a = a.arena
	a.decals[#a.decals+1] = {
		p = p,
		color = color:clone(),
		r = math.random(0, 2*math.pi)
	}
	a.decals[#a.decals].color.a = 200
end

function ArenaRenderer:init(t)

	t.arena.decals = {}
	for i=1,10 do
		--addDecal(t.arena, math.random(0,2*math.pi), Color.blue)
	end
	
	t.addDecal = addDecal
	t.drawFunc = function()
	    love.graphics.setLineWidth(15)
	    love.graphics.circle("line", t.pos.x, t.pos.y, t.arena.raio)
	end
end

function ArenaRenderer:draw(t)
	love.graphics.setColor(Color.white:value())
    t.drawFunc()
    love.graphics.stencil(t.drawFunc, "replace", 1)
    love.graphics.setStencilTest("greater", 0)
    for i,v in ipairs(t.arena.decals) do
    	love.graphics.circle("fill", t.pos.x, t.pos.y, 10)
        love.graphics.setColor(v.color:value())
	    love.graphics.draw(R.texture.decal, t.pos.x + math.cos(v.p)*t.arena.raio, t.pos.y + math.sin(v.p)*t.arena.raio,v.r, 1, 1, 109, 83)
    end
    
    love.graphics.setStencilTest()
end
