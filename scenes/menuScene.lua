menuScene = Scene("menuScene")

require("scripts.particleRenderer")
local centro = vector(love.graphics.getWidth()/2,love.graphics.getHeight()*2+100)
centro.offset = 0
centro.width = 80

local bgColor = Color(100,100,100)
local animSpeed = 0.8

function menuScene:init()
	
	titulo = click:newArcButton({
		class = "titulo",
		text = {textString = "AROUND"},
		shape = {radius = love.graphics.getHeight()*2, startAng = math.rad(100), finalAng = math.rad(440)},
		func = function ()


		end
	})

	btPlay = click:newArcButton({
		class = "menu",
		text = {textString = "PLAY"},
		shape = {radius = love.graphics.getHeight()*2-180, startAng = math.rad(258), finalAng = math.rad(282)},
		border= {width = 2, color = {r = 200, g = 200, b = 200, a = 255}},
		func = function ()
			timer.tween(1, centro, {y = love.graphics.getHeight()/2}, "in-out-quad", function()
				tCore.loadScene(R.scene.gameScene)
		
			end)
			timer.tween(1, titulo.shape, {y = love.graphics.getHeight()/2}, "in-out-quad")
			timer.tween(1, btPlay.shape, {y = love.graphics.getHeight()/2}, "in-out-quad")
			timer.tween(1, btSett.shape, {y = love.graphics.getHeight()/2}, "in-out-cubic")
			timer.tween(1, btSair.shape, {y = love.graphics.getHeight()/2}, "in-out-quart")
			timer.tween(1, bgColor, {r = 10, g = 10, b = 10}, "in-out-quad")
			
		end
	})

	btSett = click:newArcButton({
		class = "menu",
		text = {textString = "SETTINGS"},
		shape = {radius = love.graphics.getHeight()*2-280, startAng = math.rad(260), finalAng = math.rad(280)},
		border= {width = 2, color = {r = 200, g = 200, b = 200, a = 255}},
		func = function ()
			timer.tween(animSpeed, btPlay.shape, {startAng = math.rad(258+90), finalAng = math.rad(282+90)}, "in-out-quad")
			timer.tween(animSpeed, btSett.shape, {startAng = math.rad(260+90), finalAng = math.rad(280+90)}, "in-out-cubic")
			timer.tween(animSpeed, btSair.shape, {startAng = math.rad(262+90), finalAng = math.rad(278+90)}, "in-out-quart")

			timer.tween(animSpeed, btMusica.shape, {startAng = math.rad(258), finalAng = math.rad(282)}, "in-out-quart")
			timer.tween(animSpeed, btVoltar.shape, {startAng = math.rad(262), finalAng = math.rad(278)}, "in-out-cubic")
		end
	})

	btMusica = click:newArcButton({
		class = "menu",
		text = {textString = "MUSIC: ON"},
		shape = {radius = love.graphics.getHeight()*2-180, startAng = math.rad(258-90), finalAng = math.rad(282-90)},
		border= {width = 2, color = {r = 200, g = 200, b = 200, a = 255}},
		func = function ()
			gconf.music.active = not gconf.music.active
			btMusica.text.textString = gconf.music.active and "MUSIC: ON" or "MUSIC: OFF"
			
		end
	})

	btVoltar = click:newArcButton({
		class = "menu",
		text = {textString = "BACK"},
		shape = {radius = love.graphics.getHeight()*2-380, startAng = math.rad(262-90), finalAng = math.rad(278-90)},
		border= {width = 2, color = {r = 200, g = 200, b = 200, a = 255}},
		func = function ()
			timer.tween(animSpeed, btPlay.shape, {startAng = math.rad(258), finalAng = math.rad(282)}, "in-out-quad")
			timer.tween(animSpeed, btSett.shape, {startAng = math.rad(260), finalAng = math.rad(280)}, "in-out-cubic")
			timer.tween(animSpeed, btSair.shape, {startAng = math.rad(262), finalAng = math.rad(278)}, "in-out-quart")
			
			timer.tween(animSpeed, btMusica.shape, {startAng = math.rad(258-90), finalAng = math.rad(282-90)}, "in-out-quart")
			timer.tween(animSpeed, btVoltar.shape, {startAng = math.rad(262-90), finalAng = math.rad(278-90)}, "in-out-cubic")
		end
	})

	btSair = click:newArcButton({
		class = "menu",
		text = {textString = "EXIT"},
		shape = {radius = love.graphics.getHeight()*2-380, startAng = math.rad(262), finalAng = math.rad(278)},
		border= {width = 2, color = {r = 200, g = 200, b = 200, a = 255}},
		func = function ()
			love.event.quit()
		end
	})

	click:setHoverByClass("titulo", {hover = {color = {r = 255, g = 255, b = 255, a = 255}}})
	click:setTextByClass("titulo", {text = {space = math.rad(4), file = "font/encode-sans.compressed-black.ttf", size=110, 
		color={r=0,g=0,b=0,a=255}}})
	click:setShapeByClass("titulo", {shape = {x = centro.x, y = centro.y, width = 120, 
		color={r=255,g=255,b=255,a=255}}})

	click:setHoverByClass("menu", {hover = {color = {r = 120, g = 120, b = 120, a = 90}}})
	click:setTextByClass("menu", {text = {space = math.rad(2), file = "font/encode-sans.compressed-black.ttf", size=70, 
		color={r=0,g=0,b=0,a=255}}})
	click:setShapeByClass("menu", {shape = {x = centro.x, y = centro.y, width = 80, 
		color={r=255,g=255,b=255,a=255}}})
	click:setShadowByClass("menu", {shadow = {verticalDeslocation = -5, right = math.rad(0.3), left = math.rad(0.3),
		color = {r=70,g=70,b=70,a=40}}})

end

function menuScene:update(dt)
	love.graphics.setBackgroundColor(bgColor:value())
	--[[titulo.shape.y = centro.y
	btPlay.shape.y = centro.y
	btSett.shape.y = centro.y
	btSair.shape.y = centro.y
	btPlay.shape.startAng = math.rad(258+centro.offset)
	btPlay.shape.finalAng = math.rad(282+centro.offset)
	btSett.shape.startAng = math.rad(260+centro.offset)
	btSett.shape.finalAng = math.rad(280+centro.offset)
	btSair.shape.startAng = math.rad(262+centro.offset)
	btSair.shape.finalAng = math.rad(278+centro.offset)]]
	click:update(dt)
end

function menuScene:draw()
	love.graphics.setColor(Color.white:value())
    love.graphics.setLineWidth(15)
    love.graphics.circle("line", centro.x, centro.y, 1)
	click:draw()
end

return menuScene