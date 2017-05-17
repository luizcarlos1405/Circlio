-- Primeiro define tamanho de tela e outros
gameWidth, gameHeight = 1080, 720
windowWidth, windowHeight = love.window.getDesktopDimensions()
local fs = true
if not fs then
    windowWidth, windowHeight = windowWidth*.7, windowHeight*.7 --make the window a bit smaller than the screen itself
end

require("treco.trecoCore")
require("gameconf")

push = require("lib.push")
require("lib.util")

require("sounds")
timer = require("lib.timer")

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = fs, vsync = false})

gameCenter = vector(push:getWidth()/2,push:getHeight()/2)

function love.load()
	--love.window.setMode(1080, 720, {vsync=false})
	tCore.loadScene(R.scene.gameScene)
end

function love.update(dt)
	tCore.update(dt)
    timer.update(dt)
end

function love.draw()
	love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    push:start()

	tCore.draw()

    push:finish()
end

function love.keypressed(key, scancode, isrepeat)
    -- print("keypressed: ", key)
    tCore:keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    -- Muta som do jogo apertando m
    if key == "m" then
        gconf.music.active = not gconf.music.active
        if gconf.music.active then
            tags.master:setVolume(gconf.music.volume)
        else
            tags.master:setVolume(0)
        end
    end
end

function love.keyreleased(key)
    --print("keyreleased: ", key)
	tCore:keyreleased(key)
end

function love.joystickpressed(joystick, button)
    tCore:joystickpressed(joystick, button)
end

function love.joystickreleased(joystick, button)
    tCore:joystickreleased(joystick, button)
end
