-- Power Ups
PU = {fastfire = {}, speedboost = {}, spreadshot = {}, controler = {}}
PU.radius = 20
PU.color = Color(32, 5, 183)
PU.linewidth = 4
PU.mtvFactor = 30 -- Varia nível de desvio ao atingir uma bala
-- tankPowerUp.lua Fast Fire
PU.fastfire.time = 5
PU.fastfire.mod = 0.5
-- tankPowerUp.lua  Speed Boost
PU.speedboost.time = 5
PU.speedboost.mod = 2
-- tankPowerUp.lua  Spread Shot
PU.spreadshot.time = 7
PU.spreadshot.mod = math.pi/20
-- powerUpControler.lua  Controlador: tempo para aparecimento de novos powerups
PU.controler.mintime = 20
PU.controler.maxtime = 50
-- bulletScript.lua BulletScript
BS = {bullet = {}}
BS.bullet.speed = 200
BS.bullet.radius = 10
BS.bullet.maxlife = 3
BS.bullet.minlife = 0.2
BS.bullet.mtvFactor = 20 -- Varia nível de desvio ao atingir um powerupp
BS.bullet.size = 5
