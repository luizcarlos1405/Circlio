gameScene = Scene("gameScene")

require("gameComponents")

--Scripts
require("scripts.trailRenderer")
require("scripts.arenaRenderer")
require("scripts.powerupSpawner")
require("scripts.powerupBoxScript")
require("scripts.deathMatch")
require("scripts.tankRenderer")
require("scripts.tankMotor")
require("scripts.bulletScript")
require("scripts.keyboardInputHandler")
require("scripts.joystickInputHandler")
require("scripts.tankIA")
require("scripts.tankPowerUp")
require("scripts.asteroidScript")
require("scripts.circollider")
--require("scripts.scoreboard")
--require("scripts.gravity")
require("scripts.lobby")

require("soundManager")

local trecoArena, Player1, Player2, Player3

function gameScene:init()
	trecoArena = Treco(Position(gameCenter), Arena(1), Circoll(gconf.arena.size, true))
    trecoArena.arena.treco = trecoArena

    timer.tween(0.5, trecoArena.arena, {raio = gconf.arena.size}, "in-out-quint")

    -- Para jogar com controle descomente a linha abaixo
	-- Player1 = Treco(Position(vector(0, 0)), Tank("Luiz", trecoArena, love.math.random(0, 2*math.pi), Color(0, 255, 255)), JoystickInput(3, 4), Circoll(20))
    -- Player2 = Treco(Position(vector(0, 0)), Tank("Eric", trecoArena, love.math.random(0, 628)/100, Color(255, 255, 0)), JoystickInput(1, 4), Circoll(20))
    -- Player3 = Treco(Position(vector(0, 0)), Tank("Luiz", trecoArena, love.math.random(0, 628)/100, Color.green), JoystickInput(2, 4), Circoll(20))
    -- Teclado
    --Player1 = Treco(Position(vector(0, 0)), Tank("Player2", trecoArena, 2*math.pi/3, Color(0, 255, 170)), KeyboardInput("left","right","space", "lshift"), Circoll(20))
	-- Player2 = Treco(Position(vector(0, 0)), Tank("Player2", trecoArena, 2*math.pi/3, Color.red), KeyboardInput("j","l","i"), Circoll(20))
	-- Player3 = Treco(Position(vector(0, 0)), Tank("Player3", trecoArena, 4*math.pi/3, Color.blue), KeyboardInput("left","right","up"), Circoll(20))

	-- arenaFundo = Treco(Position(vector(200,250)), Arena(100))

    --[[Treco(Position(vector(0, 0)), Tank("Bot1", trecoArena, 0, Color.green), Bot, Circoll(20))
	Treco(Position(vector(0, 0)), Tank("Bot2", trecoArena, math.pi/3, Color.red), Bot, Circoll(20))
	Treco(Position(vector(0, 0)), Tank("Bot3", trecoArena, 2*math.pi/3, Color.blue), Bot, Circoll(20))
	Treco(Position(vector(0, 0)), Tank("Bot4", trecoArena, 3*math.pi/3, Color.orange), Bot, Circoll(20))
	Treco(Position(vector(0, 0)), Tank("Bot5", trecoArena, 4*math.pi/3, Color.grey), Bot, Circoll(20))
	Treco(Position(vector(0, 0)), Tank("Bot6", trecoArena, 5*math.pi/3, Color.white), Bot, Circoll(20))]]

	--Treco(Position(gameCenter), Asteroid)

	gameArena = trecoArena.arena

    -- Inicia musica de fundo
    if gconf.music.active then
        --music.battle:play()
    end
end

function gameScene:update(dt)
    music.battle:update(dt)
	--Velocidade do jogador precisa ser relativa ao raio da arena
    -- gameArena.raio = math.max(gameArena.raio-10*dt, 50)
end

function gameScene:keypressed(key)
    
end

return gameScene
