CirCollider = Script({Circoll})

local debug = true
local tCirc = {}

local function move(c, m)
	local newPos = c.treco.pos + m
	local cols = {}
    local mtv = vector.zero
	for k in pairs(tCirc) do
		if k ~= c then
            local distance = newPos:dist(k.treco.pos)
			if k.invert then
				if distance > k.radius-c.radius then
					cols[#cols+1] = k
					local overlap = newPos:dist(k.treco.pos) - k.radius-c.radius
					newPos = k.treco.pos + (newPos-k.treco.pos):normalize()*(k.radius-c.radius)
				end
			else
                if distance < c.radius + k.radius then
                    cols[#cols+1] = k
                    -- Calcula mtv
                    local V = vector.normalize(vector(c.treco.pos.x - k.treco.pos.x, c.treco.pos.x - k.treco.pos.x))
                    -- local V = vector.normalize(V)
                    mtv = V * (k.radius + c.radius - distance)
                    if type(mtv.x) == "number" and type(mtv.y) == "number" then
                        print(mtv.x, mtv.y)
                    end
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
	love.graphics.setLineWidth(2)
	love.graphics.setColor(Color.grey:value())
	if debug then
		for c in pairs(tCirc) do
			love.graphics.circle("line", c.treco.pos.x, c.treco.pos.y, c.radius)
		end
	end
end

function CirCollider:onRemoval(c)
	tCirc[c.circoll] = nil
end
