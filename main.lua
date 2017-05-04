require("coisaCore")

local push = require "push"

local gameWidth, gameHeight = 1080, 720 --fixed game resolution
local windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth*.7, windowHeight*.7 --make the window a bit smaller than the screen itself

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false})

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
