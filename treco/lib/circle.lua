local vector = require(BASE .. "lib.vector-light")
local circle
do
  local _class_0
  local _base_0 = {
    drawShape = function(self)
      love.graphics.circle("line", self.x, self.y, self.r)
      love.graphics.setColor(255, 0, 255)
      love.graphics.setPointSize(4)
      love.graphics.points(self.x, self.y)
      return love.graphics.setColor(255, 255, 255)
    end,
    move = function(self, dx, dy)
      self.x = self.x + dx
      self.y = self.y + dy
      local _list_0 = AC.shapes
      for _index_0 = 1, #_list_0 do
        local _continue_0 = false
        repeat
          local shape = _list_0[_index_0]
          if shape == self then
            _continue_0 = true
            break
          end
          local coll, mtv = AC:isColliding(shape, self)
          if coll then
            table.insert(self.cols, {
              shape = shape,
              mtv = mtv
            })
          end
          _continue_0 = true
        until true
        if not _continue_0 then
          break
        end
      end
      return self:collided()
    end,
    moveTo = function(self, x, y)
      self.x = x
      self.y = y
    end,
    collided = function(self)
      local r = self.cols
      self.cols = { }
      return r
    end,
    destroy = function(self)
      for k, v in pairs(AC.shapes) do
        if v == self then
            self = nil
            table.remove(AC.shapes, k)
        end
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, r, behavior, name)
      if r == nil then
        r = 0
      end
      if behavior == nil then
        behavior = "static"
      end
      if name == nil then
        name = "circle"
      end
      self.cols = { }
      self.x = 0
      self.y = 0
      self.r = r
      self.behavior = behavior
      self.name = name
      self.type = "circle"
      if behavior ~= "static" and behavior ~= "dynamic" then
        error("Invalid shape behavior. Valids shape behaviors are 'kynetic' and 'dynamic'")
      end

      return AC:addShape(self)
    end,
    __base = _base_0,
    __name = "circle"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  circle = _class_0
end
return circle
