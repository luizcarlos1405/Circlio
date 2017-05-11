require("treco.trecoCore")
require("gameconf")

local push = require("lib.push")
require("lib.util")

gameWidth, gameHeight = 1080, 720 --fixed game resolution
windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth*.7, windowHeight*.7 --make the window a bit smaller than the screen itself

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, vsync = false})


gameCenter = vector(push:getWidth()/2,push:getHeight()/2)

function love.load()
	--love.window.setMode(1080, 720, {vsync=false})
	tCore.loadScene(R.scene.gameScene)
end

function love.update(dt)
	tCore.update(dt)
end

function love.draw()
	love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    push:start()

	tCore.draw()

    push:finish()
end

function love.keypressed(key, scancode, isrepeat)
    --print("keypressed: ", key)
    tCore:keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyreleased(key)
    --print("keyreleased: ", key)
	tCore:keyreleased(key)
end
