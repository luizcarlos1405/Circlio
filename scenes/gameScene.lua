gameScene = Scene("gameScene")

function gameScene:init()

end

function gameScene:update(dt)

end

function gameScene:draw()
    love.graphics.setLineWidth(10)
    love.graphics.circle("line", gameWidth/2, gameHeight/2, gameHeight/2 - 10, segments)
end

return gameScene
