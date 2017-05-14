event.listen("tank_shoot", function(tank, bs)
	effect.shoot:play({pitch = gconf.bullet.size / (bs * 0.1 + gconf.bullet.size - 1)})
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

