gameScene = Scene("gameScene")

require("gameComponents")

--Scripts
require("scripts.arenaRenderer")
require("scripts.tankRenderer")
require("scripts.tankMotor")
require("scripts.bulletScript")
require("scripts.keyboardInputHandler")
require("scripts.tankIA")
require("scripts.tankPowerUp")
require("scripts.powerUpControler")
require("scripts.asteroidScript")
require("scripts.circollider")
require("scripts.deathMatch")
--require("scripts.gravity")

local trecoArena, Player1, Player2, Player3

function gameScene:init()
	trecoArena = Treco(Position(gameCenter), Arena(gameHeight/2 - 30), Circoll(gameHeight/2 - 30, true))
    trecoArena.arena.treco = trecoArena

	-- Position dos Player1 e Player2 iniciados em (0, 0) apenas para utilizar o component AllCollider
	-- Seria isso uma gambiarra?
	Player1 = Treco(Position(vector(0, 0)), Tank("Player1", trecoArena, 0, Color(0, 255, 255)), KeyboardInput("a","d","w"), Circoll(20))
	-- Player2 = Treco(Position(vector(0, 0)), Tank("Player2", trecoArena, 2*math.pi/3, Color.red), KeyboardInput("j","l","i"), Circoll(20))
	-- Player3 = Treco(Position(vector(0, 0)), Tank("Player3", trecoArena, 4*math.pi/3, Color.blue), KeyboardInput("left","right","up"), Circoll(20))

	-- arenaFundo = Treco(Position(vector(200,250)), Arena(100))

	Treco(Position(vector(0, 0)), Tank("Bot1", trecoArena, 0, Color.green), Bot, Circoll(20))
	Treco(Position(vector(0, 0)), Tank("Bot2", trecoArena, math.pi/3, Color.red), Bot, Circoll(20))
	Treco(Position(vector(0, 0)), Tank("Bot3", trecoArena, 2*math.pi/3, Color.blue), Bot, Circoll(20))
	-- Treco(Position(vector(0, 0)), Tank("Bot4", trecoArena, 3*math.pi/3, Color.orange), Bot, Circoll(20))
	-- Treco(Position(vector(0, 0)), Tank("Bot5", trecoArena, 4*math.pi/3, Color.grey), Bot, Circoll(20))
	-- Treco(Position(vector(0, 0)), Tank("Bot6", trecoArena, 5*math.pi/3, Color.white), Bot, Circoll(20))

	--Treco(Position(gameCenter), Asteroid)

	gameArena = trecoArena.arena
end

function gameScene:update(dt)
	--Velocidade do jogador precisa ser relativa ao raio da arena
    -- gameArena.raio = math.max(gameArena.raio-10*dt, 50)
end

function gameScene:draw()

end

return gameScene
