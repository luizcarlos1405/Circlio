CirCollider = Script({Circoll})

local debug = false
local tCirc = {}

local function move(c, m)
	local newPos = c.treco.pos + m
	local cols = {}
    local mtv = vector.zero
	for k in pairs(tCirc) do
		if k ~= c then
            local distance = newPos:dist2(k.treco.pos)
            -- Colisão com a parte interna do shape k
			if k.invert then
				if distance > math.pow(k.radius-c.radius,2) then
					cols[#cols+1] = k
					-- local overlap = newPos:dist(k.treco.pos) - k.radius-c.radius
					newPos = k.treco.pos + (newPos-k.treco.pos):normalize()*(k.radius-c.radius)
				end
            -- Colisão com o shape k
			else
                if distance < math.pow(c.radius + k.radius,2) then
                    cols[#cols+1] = k
                    -- Calcula mtv que separa k de c
                    local V = vector.normalize(vector(c.treco.pos.x - k.treco.pos.x, c.treco.pos.y - k.treco.pos.y))
                    mtv = V * (k.radius + c.radius - math.sqrt(distance))
                end
			end
		end
	end
	c.treco.pos.x = newPos.x
	c.treco.pos.y = newPos.y
	return cols, mtv
end

function CirCollider:init(t)
	tCirc[t.circoll] = true

	t.circoll.move = move

	t.circoll.treco = t
end

function CirCollider:drawBefore(t)
	if debug then
	love.graphics.setLineWidth(2)
	love.graphics.setColor(Color.grey:value())
		for c in pairs(tCirc) do
			love.graphics.circle("line", c.treco.pos.x, c.treco.pos.y, c.radius)
		end
	end
end
function CirCollider:onRemoval(c)
	tCirc[c.circoll] = nil
end
