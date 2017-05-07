gameScene = Scene("gameScene")

require("gameComponents")


--Scripts
require("scripts.arenaRenderer")
require("scripts.tankRenderer")
require("scripts.bulletScript")
require("scripts.playerController")

local trecoArena, Player1, Player2

function gameScene:init()
	trecoArena = Treco(Position(gameCenter), Arena(gameHeight/2 - 10))

	-- Position dos Player1 e Player2 iniciados em (0, 0) apenas para utilizar o component BoxCollider
	-- Seria isso uma gambiarra?
	Player1 = Treco(Position(vector(0, 0)), Tank(trecoArena, 0, Color.green), PlayerInput("a","d","w"), PlayerStatus(0, 0, 0.5, "Player1"), BoxCollider(20, 20, vector(-10, -10)))
	Player2 = Treco(Position(vector(0, 0)), Tank(trecoArena, 2*math.pi/3, Color.red), PlayerInput("j","l","i"), PlayerStatus(0, 0, 0.5, "Player2"), BoxCollider(20, 20, vector(-10, -10)))
	Player3 = Treco(Position(vector(0, 0)), Tank(trecoArena, 4*math.pi/3, Color.blue), PlayerInput("left","right","up"), PlayerStatus(0, 0, 0.5, "Player3"), BoxCollider(20, 20, vector(-10, -10)))

	gameArena = trecoArena.arena
end

function gameScene:update(dt)
	--Velocidade do jogador precisa ser relativa ao raio da arena
	--gameArena.raio = gameArena.raio-10*dt
end

function gameScene:draw()

end

return gameScene
