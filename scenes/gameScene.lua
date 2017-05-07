gameScene = Scene("gameScene")

require("gameComponents")


--Scripts
require("scripts.arenaRenderer")
require("scripts.tankRenderer")
require("scripts.bulletRenderer")
require("scripts.playerController")

local trecoArena, Player1, Player2

function gameScene:init()
	trecoArena = Treco(Position(gameCenter), Arena(gameHeight/2 - 10))

	-- Position dos Player1 e Player2 iniciados em (0, 0) apenas para utilizar o component BoxCollider
	-- Seria isso uma gambiarra?
	Player1 = Treco(Position(vector(0,0)), Tank(trecoArena, 0, Color.green), PlayerInput("a","d","w"), PlayerStatus(100, 0, 0, 0.5), BoxCollider(20, 20, vector(-10, -10)))
	Player2 = Treco(Position(vector(0,0)), Tank(trecoArena, math.pi, Color.red), PlayerInput("j","l","i"), PlayerStatus(100, 0, 0, 0.5), BoxCollider(20, 20, vector(-10, -10)))

	gameArena = trecoArena.arena
end

function gameScene:update(dt)
	--gameArena.raio = gameArena.raio-10*dt
end

function gameScene:draw()

end

return gameScene
