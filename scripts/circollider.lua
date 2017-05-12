CirCollider = Script({Circoll})

local debug = true
local tCirc = {}

local function move(c, m)
	local newPos = c.treco.pos + m
	local cols = {}
	for k in pairs(tCirc) do
		if k ~= c then
			if k.invert then
				if newPos:dist(k.treco.pos) > k.radius-c.radius then
					cols[#cols+1] = k
					local overlap = newPos:dist(k.treco.pos) - k.radius-c.radius
					newPos = k.treco.pos + (newPos-k.treco.pos):normalize()*(k.radius-c.radius)
				end
			else
				if newPos:dist(k.treco.pos) < k.radius+c.radius then
					cols[#cols+1] = k
				end
			end
		end
	end
	c.treco.pos.x = newPos.x
	c.treco.pos.y = newPos.y
	return cols
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