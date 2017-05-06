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
	Player1 = Treco(Tank(trecoArena, 0, Color.green), PlayerInput("a","d","w"))
	Player2 = Treco(Tank(trecoArena, math.pi, Color.red), PlayerInput("j","l","i"))
	gameArena = trecoArena.arena
end

function gameScene:update(dt)
	--gameArena.raio = gameArena.raio-10*dt
end

function gameScene:draw()

end

return gameScene