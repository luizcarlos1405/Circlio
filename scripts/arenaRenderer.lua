ArenaRenderer = Script({Arena})

function ArenaRenderer:draw(a)
	love.graphics.setColor(Color.white:value())
    love.graphics.setLineWidth(10)
    love.graphics.circle("line", a.pos.x, a.pos.y, a.arena.treco.arena.raio)
end
