-- Power Ups
PU = {fastfire = {}, speedboost = {}, spreadshot = {}, controler = {}}
PU.radius = 20
PU.color = Color(255, 0, 0)
PU.linewidth = 4
-- tankPowerUp.lua Fast Fire
PU.fastfire.time = 3
PU.fastfire.mod = 0.5
-- tankPowerUp.lua  Speed Boost
PU.speedboost.time = 3
PU.speedboost.mod = 2
-- tankPowerUp.lua  Spread Shot
PU.spreadshot.time = 3
PU.spreadshot.mod = math.pi/20
-- powerUpControler.lua  Controlador
PU.controler.mintime = 2
PU.controler.maxtime = 5
-- bulletScript.lua BulletScript
BS = {bullet = {}}
BS.bullet.speed = 200
BS.bullet.radius = 10
BS.bullet.maxlife = 3
BS.bullet.minlife = 0.2
