require(BASE.."lib.allcoll")
local circle = require(BASE.."lib.circle")

acWrapper = Script({AllCollider})
acWrapper.debug = true

function acWrapper:init(c)
    c.collider.shape = circle(c.collider.r)
    c.collider.shape:moveTo(c.pos.x, c.pos.y)
    c.collider.shape.bullet = c.bullet
    c.collider.shape.tank = c.tank
    c.collider.shape.treco = c

    -- Reescreve função de destruir para desruir também o shape
    function c:destroy()
    	self.toDestroy = true
    	tCore.removeTreco(self)
        c.collider.shape:destroy()
    end
end

function acWrapper:update(c, dt)

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
