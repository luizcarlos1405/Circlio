
vector = require("lib.vector")
local push = require "push"

gameWidth, gameHeight = 1080, 720 --fixed game resolution
gameCenter = vector(gameWidth/2,gameWidth/2)
windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth*.7, windowHeight*.7 --make the window a bit smaller than the screen itself

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false})
require("trecoCore")

gameCenter = vector(push:getWidth()/2,push:getHeight()/2)

function love.load()
	cCore.loadScene(R.scene.gameScene)
end

function love.update(dt)
	cCore.update(dt)
end

function love.draw()
    push:start()

	cCore.draw()

    push:finish()
end

function love.keypressed(key, scancode, isrepeat)
    if key == 'escape' then
        love.event.quit()
    end
end
