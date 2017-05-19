event.listen("tank_shoot", function(tank, bs)
    local maxBulletSize = gconf.bullet.size + gconf.bullet.maxHoldTime*gconf.bullet.size
	effect.shoot:play({pitch = 1.2 - cpml.utils.map(bs, gconf.bullet.size, maxBulletSize, 0, 0.4)})
end)

event.listen("tank_hit", function(tank)
    effect.hit:play({pitch = love.math.random(8, 12)/10})
end)

event.listen("powerup_spawn", function(pu)
 	-- Efeito sonoro variando a nota entre 70% e 100% do ton original
	effect.powerupAppear:play({pitch = love.math.random(7, 10)/10})
end)

event.listen("powerup_pickup", function(pu, tank)
	effect.powerupPick:play()
	narrative[pu.name]:play()
end)
