local vector = require(BASE .. "lib.vector-light")
local allcoll
do
  local _class_0
  local _base_0 = {
    setGravity = function(self, gx, gy)
      self.gravity = {
        x = gx,
        y = gy
      }
    end,
    isColliding = function(self, fix, move)
      local mtv = {
        x = 0,
        y = 0
      }
      local _ = fix.type == "circle" and move.type == "circle"
      local Vx, Vy = move.x - fix.x, move.y - fix.y
      local distance = vector.len(Vx, Vy)
      if distance < fix.r + move.r then
        Vx, Vy = vector.normalize(Vx, Vy)
        mtv = {
          x = Vx * (fix.r + move.r - distance),
          y = Vy * (fix.r + move.r - distance)
        }
        return true, mtv
      else
        return false, {
          x = 0,
          y = 0
        }
      end
    end,
    addShape = function(self, shape)
      return table.insert(self.shapes, shape)
    end,
    processAllPoints = function(self, S1, S2)
      local mtv = {
        0,
        0
      }
      local proj = 0
      local Vx, Vy = nil, nil
      local overlap = 0
      local S1MinProj = nil
      local S1MaxProj = nil
      local S2MinProj = nil
      local S2MaxProj = nil
      local minOverlap = nil
      for i = 1, #S1.points do
        if i == #S1.points then
          Vx, Vy = vector.sub(S1.points[1].x, S1.points[1].y, S1.points[i].x, S1.points[i].y)
        else
          Vx, Vy = vector.sub(S1.points[i + 1].x, S1.points[i + 1].y, S1.points[i].x, S1.points[i].y)
        end
        Vx, Vy = vector.perpendicular(Vx, Vy)
        Vx, Vy = vector.normalize(Vx, Vy)
        S1MinProj = vector.dot(S1.points[1].x, S1.points[1].y, Vx, Vy)
        S1MaxProj = S1MinProj
        for j = 2, #S1.points do
          proj = vector.dot(S1.points[j].x, S1.points[j].y, Vx, Vy)
          S1MinProj = math.min(proj, S1MinProj)
          S1MaxProj = math.max(proj, S1MaxProj)
        end
        S2MinProj = vector.dot(S2.points[1].x, S2.points[1].y, Vx, Vy)
        S2MaxProj = S2MinProj
        for j = 2, #S2.points do
          proj = vector.dot(S2.points[j].x, S2.points[j].y, Vx, Vy)
          S2MinProj = math.min(proj, S2MinProj)
          S2MaxProj = math.max(proj, S2MaxProj)
        end
        if S1MaxProj < S2MinProj or S2MaxProj < S1MinProj then
          return 0, {
            0,
            0
          }
        end
        local auxOverlap1 = S1MaxProj - S2MinProj
        local auxOverlap2 = S1MinProj - S2MaxProj
        if math.abs(auxOverlap1) < math.abs(auxOverlap2) then
          overlap = auxOverlap1
        else
          overlap = auxOverlap2
        end
        if i == 1 then
          minOverlap = overlap
          mtv = {
            Vx,
            Vy
          }
        elseif math.abs(overlap) < math.abs(minOverlap) then
          minOverlap = overlap
          mtv = {
            Vx,
            Vy
          }
        end
      end
      return minOverlap, mtv
    end,
    processRectanglePoints = function(self, S1, S2)
      local mtv = {
        0,
        0
      }
      local proj = 0
      local Vx, Vy = nil, nil
      local overlap = 0
      local S1MinProj = nil
      local S1MaxProj = nil
      local S2MinProj = nil
      local S2MaxProj = nil
      local minOverlap = nil
      local S1points = {
        {
          x = S1.points[1].x,
          y = S1.points[1].y
        },
        {
          x = S1.points[2].x,
          y = S1.points[2].y
        },
        {
          x = S1.points[4].x,
          y = S1.points[4].y
        }
      }
      for i = 1, 2 do
        if i == 1 then
          Vx, Vy = vector.sub(S1points[2].x, S1points[2].y, S1points[1].x, S1points[1].y)
        else
          Vx, Vy = vector.sub(S1points[3].x, S1points[3].y, S1points[1].x, S1points[1].y)
        end
        Vx, Vy = vector.perpendicular(Vx, Vy)
        Vx, Vy = vector.normalize(Vx, Vy)
        for j = 1, #S1.points do
          if j == 1 then
            S1MinProj = vector.dot(S1.points[j].x, S1.points[j].y, Vx, Vy)
            S1MaxProj = S1MinProj
          else
            proj = vector.dot(S1.points[j].x, S1.points[j].y, Vx, Vy)
            S1MinProj = math.min(proj, S1MinProj)
            S1MaxProj = math.max(proj, S1MaxProj)
          end
        end
        for j = 1, #S2.points do
          if j == 1 then
            S2MinProj = vector.dot(S2.points[j].x, S2.points[j].y, Vx, Vy)
            S2MaxProj = S2MinProj
          else
            proj = vector.dot(S2.points[j].x, S2.points[j].y, Vx, Vy)
            S2MinProj = math.min(proj, S2MinProj)
            S2MaxProj = math.max(proj, S2MaxProj)
          end
        end
        if S1MaxProj < S2MinProj or S2MaxProj < S1MinProj then
          return 0, {
            0,
            0
          }
        end
        local auxOverlap1 = S1MaxProj - S2MinProj
        local auxOverlap2 = S1MinProj - S2MaxProj
        if math.abs(auxOverlap1) < math.abs(auxOverlap2) then
          overlap = auxOverlap1
        else
          overlap = auxOverlap2
        end
        if i == 1 then
          minOverlap = overlap
          mtv = {
            Vx,
            Vy
          }
        elseif math.abs(overlap) < math.abs(minOverlap) then
          minOverlap = overlap
          mtv = {
            Vx,
            Vy
          }
        end
      end
      return minOverlap, mtv
    end,
    rotatePolygon = function(self, da, polygon)
      polygon.r = polygon.r + da
      for i = 1, #polygon.points do
        local nx, ny = vector.rotate(da, polygon.points[i].x - polygon.x, polygon.points[i].y - polygon.y)
        polygon.points[i].x = nx + polygon.x
        polygon.points[i].y = ny + polygon.y
      end
      if polygon.r > 2 * math.pi then
        polygon.r = polygon.r % (2 * math.pi)
      elseif polygon.r < -2 * math.pi then
        polygon.r = -polygon.r % (2 * math.pi)
      end
      local _list_0 = self.shapes
      for _index_0 = 1, #_list_0 do
        local _continue_0 = false
        repeat
          local shape = _list_0[_index_0]
          if shape == polygon then
            _continue_0 = true
            break
          end
          local coll, mtv = self:isColliding(shape, polygon)
          if coll then
            polygon:collided(shape, mtv, true)
          end
          _continue_0 = true
        until true
        if not _continue_0 then
          break
        end
      end
    end,
    setPolygonAngle = function(self, a, polygon)
      local da = a - polygon.r
      polygon.r = a
      for i = 1, #polygon.points do
        local nx, ny = vector.rotate(da, polygon.points[i].x - polygon.x, polygon.points[i].y - polygon.y)
        polygon.points[i].x = nx + polygon.x
        polygon.points[i].y = ny + polygon.y
      end
      if polygon.r > 2 * math.pi then
        polygon.r = polygon.r % (2 * math.pi)
      elseif polygon.r < 0 then
        polygon.r = 2 * math.pi - polygon.r % (2 * math.pi)
      end
    end,
    movePolygon = function(self, dx, dy, polygon)
      polygon.x = polygon.x + dx
      polygon.y = polygon.y + dy
      for i = 1, #polygon.points do
        polygon.points[i].x = polygon.points[i].x + dx
        polygon.points[i].y = polygon.points[i].y + dy
      end
      local _list_0 = self.shapes
      for _index_0 = 1, #_list_0 do
        local _continue_0 = false
        repeat
          local shape = _list_0[_index_0]
          if shape == polygon then
            _continue_0 = true
            break
          end
          local coll, mtv = self:isColliding(shape, polygon)
          if coll then
            polygon:collided(shape, mtv, false)
          end
          _continue_0 = true
        until true
        if not _continue_0 then
          break
        end
      end
    end,
    movePolygonTo = function(self, x, y, polygon)
      local dx, dy = x - polygon.x, y - polygon.y
      polygon.x = polygon.x + dx
      polygon.y = polygon.y + dy
      for i = 1, #polygon.points do
        polygon.points[i].x = polygon.points[i].x + dx
        polygon.points[i].y = polygon.points[i].y + dy
      end
    end,
    update = function(self, dt)
      for i = 1, #self.shapes do
        if self.shapes[i].behavior ~= "static" then
          self.shapes[i]:move(self.gravity.x * dt, self.gravity.y * dt, self.shapes[i])
        end
      end
    end,
    drawAllShapes = function(self)
      for i = 1, #self.shapes do
        self.shapes[i]:drawShape()
      end
    end,
    collisionStandardTreatment = function(self, shape, other, mtv, rotated)
      if rotated then
        if shape.behavior == "dynamic" then
          if other.behavior == "static" then
            return shape:moveTo(shape.x + mtv.x, shape.y + mtv.y)
          elseif other.behavior == "dynamic" then
            shape:moveTo(shape.x + mtv.x / 2, shape.y + mtv.y / 2)
            return other:moveTo(other.x - mtv.x / 2, other.y - mtv.y / 2)
          end
        elseif shape.behavior == "static" then
          if other.behavior == "dynamic" then
            return other:moveTo(other.x - mtv.x, other.y - mtv.y)
          end
        end
      else
        if other.behavior == "static" then
          return shape:moveTo(shape.x + mtv.x, shape.y + mtv.y)
        elseif other.behavior == "dynamic" then
          shape:moveTo(shape.x + mtv.x / 2, shape.y + mtv.y / 2)
          return other:moveTo(other.x - mtv.x / 2, other.y - mtv.y / 2)
        end
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.shapes = { }
      self.gravity = {
        x = 0,
        y = 0
      }
    end,
    __base = _base_0,
    __name = "allcoll"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  allcoll = _class_0
end
AC = allcoll()
