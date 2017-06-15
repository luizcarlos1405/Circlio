event.listen("tank_shoot", function(tank, bs)
    local maxBulletSize = gconf.bullet.size + gconf.bullet.maxHoldTime*gconf.bullet.size
	if gconf.music.active then
        -- O pitch ta variando de 0.8 até 1.2, mais grave quando a bullet é maior
		effect.shoot:play({pitch = 1.2 - cpml.utils.map(bs, gconf.bullet.size, maxBulletSize, 0, 0.4)})
	end
end)

event.listen("tank_hit", function(tank)
    if gconf.music.active then
    	effect.hit:play({pitch = love.math.random(8, 12)/10})
    end
end)

event.listen("tank_die", function(tank)
    if gconf.music.active then
    	effect.die:play({pitch = love.math.random(10, 12)/10})
    end
end)

event.listen("powerup_spawn", function(pu)
 	if gconf.music.active then
		-- Efeito sonoro variando a nota entre 70% e 100% do ton original
		effect.powerupAppear:play({pitch = love.math.random(7, 10)/10})
	end
end)

event.listen("powerup_pickup", function(pu, tank)
	if gconf.music.active then
		effect.powerupPick:play()
		narrative[pu.name]:play()
	end
end)
