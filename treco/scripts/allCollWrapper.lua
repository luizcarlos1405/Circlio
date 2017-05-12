require(BASE.."lib.allcoll")
local circle = require(BASE.."lib.circle")

acWrapper = Script({BoxCollider})

function acWrapper:init(c)
	self.debug = true
    c.collider.shape = circle(c.collider.r)
    c.collider.shape:moveTo(c.pos.x, c.pos.y)
    c.collider.shape.bullet = c.bullet
    c.collider.shape.tank = c.tank
    table.insert(AC.shapes, c.collider.shape)
end

function acWrapper:update(dt)

end

function acWrapper:draw()
    love.graphics.setLineWidth(2)
    if self.debug then
        AC:drawAllShapes()
    end
end

function acWrapper:move(c, m, ...)
    local cols = c.collider.shape:move(m.x, m.y)
    nx, ny = c.collider.shape.x, c.collider.shape.y
    return nx, ny, cols
end
