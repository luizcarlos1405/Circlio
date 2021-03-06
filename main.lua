require("loverun")

-- Primeiro define tamanho de tela e outros
gameWidth, gameHeight = 1366, 768
windowWidth, windowHeight = love.window.getDesktopDimensions()
local fs = false
if not fs then
    windowWidth, windowHeight = windowWidth*.7, windowHeight*.7 --make the window a bit smaller than the screen itself
end

require("treco.trecoCore")
require("gameconf")

push = require("lib.push")
require("lib.util")
cpml = require("lib.cpml.init")

require("sounds")
timer = require("lib.timer")
camera = require("lib.camera")

trail = require("lib.trail")

click = require("lib.Click")

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = fs, vsync = false})

gameCenter = vector(push:getWidth()/2,push:getHeight()/2)

cmr = camera()


font = love.graphics.newFont("/font/encode-sans.compressed-black.ttf", 20)
bigFont = love.graphics.newFont("/font/encode-sans.compressed-black.ttf", 50)
love.graphics.setFont(font)

function love.load()
	--love.window.setMode(1080, 720, {vsync=false})
	tCore.loadScene(R.scene.menuScene)
end

local startTime
local _dt
local fpsCont = 0
local fps = 0
function love.update(dt)
    _dt = dt
    startTime = love.timer.getTime()
    tCore.update(dt)
    timer.update(dt)
end

function love.draw()
    -- cmr:attach()
    push:start()
    --ParticleRenderer.drawOnce()

    --love.graphics.draw(R.texture.bg, 0,0)
	tCore.draw()

    push:finish()
    -- cmr:detach()
end

function drawFPS()
    fpsCont = fpsCont + 1
    if fpsCont == 20 then
        fpsCont = 0
        fps = math.floor(1/(_dt + (love.timer.getTime()-startTime)))
    end

    love.graphics.print("FPS: "..fps, 10, 10)
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
