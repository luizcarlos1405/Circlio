local Click = {}

local BASE = (...):match('(.-)[^%.]+$')

local fileDefault = BASE .. "/font/FrancoisOne-Regular.ttf"
local cursorHand = love.mouse.getSystemCursor("hand")
local flag = true
local hover = {false, false, 0}

local buttons = {}
local panels = {}

-- Create a rectangle button
function Click:newRectangleButton(param)
	local button = {}
	param = param or {}

	button.buttonType = "rectangle"
	button.class = param.class or false
	button.clickable = param.clickable or true
	button.visible = param.visible or true

	button.text = {}
	param.text = param.text or {}
	button.text.textString = param.text.textString or "button"
	button.text.font = font--love.graphics.newFont(param.text.file or fileDefault, param.text.size or 16)
	button.text.verticalAlign = param.text.verticalAlign or "center"
	button.text.horizontalAlign = param.text.horizontalAlign or "center"
	setColor(button.text, param.text)

	button.shape = {}
	param.shape = param.shape or {}
	button.shape.x = param.shape.x or 0
	button.shape.y = param.shape.y or 0
	button.shape.width = param.shape.width or 400
	button.shape.height = param.shape.height or 100
	button.shape.radius = param.shape.radius or 0
	button.shape.radius = math.min(button.shape.radius, button.shape.height/2)
	setColor(button.shape, param.shape)

	setBorder(button, param)

	setHover(button, param)

	button.shadow = {}
	param.shadow = param.shadow or {}
	button.shadow.top = param.shadow.top or 0
	button.shadow.right = param.shadow.right or 0
	button.shadow.down = param.shadow.down or 0
	button.shadow.left = param.shadow.left or 0
	setColor(button.shadow, param.shadow)

	button.func = param.func or function() end

	table.insert(buttons, button)
	return button
end

-- Create a arc button
function Click:newArcButton(param)
	local button = {}
	param = param or {}

	button.buttonType = "arc"
	button.class = param.class or false
	button.clickable = param.clickable or true
	button.visible = param.visible or true

	button.text = {}
	param.text = param.text or {}
	button.text.textString = param.text.textString or "button"
	button.text.space = param.text.space or math.rad(5)
	button.text.font = font or love.graphics.newFont(param.text.file or fileDefault, param.text.size or 16)
	--button.text.verticalAlign = param.text.verticalAlign or "center"
	--button.text.horizontalAlign = param.text.horizontalAlign or "center"
	setColor(button.text, param.text)
	button.text.tabText = {}
	for i=1,string.len(button.text.textString) do
		table.insert(button.text.tabText, love.graphics.newText(button.text.font, string.sub(button.text.textString, i, i)))
	end

	button.shape = {}
	param.shape = param.shape or {}
	button.shape.x = param.shape.x or 0
	button.shape.y = param.shape.y or 0
	button.shape.width = param.shape.width or 40
	button.shape.radius = param.shape.radius or 400
	button.shape.startAng = param.shape.startAng or math.rad(200) 
	button.shape.finalAng = param.shape.finalAng or math.rad(340)
	setColor(button.shape, param.shape)

	setBorder(button, param)

	setHover(button, param)

	button.shadow = {}
	param.shadow = param.shadow or {}
	button.shadow.verticalDeslocation = param.shadow.verticalDeslocation or 0
	button.shadow.right = param.shadow.right or 0
	button.shadow.left = param.shadow.left or 0
	setColor(button.shadow, param.shadow)

	button.func = param.func or function() end

	table.insert(buttons, button)
	return button
end

-- create a slideButton
function Click:newSlideButton(param)
	param = param or {}
	param.buttonType = "slide"

	local button = {}

	button.class = param.class or false
	button.buttonType = param.buttonType
	button.visible = param.visible or true
	button.clickable = param.clickable or true

	button.shape = {}
	param.shape = param.shape or {}
	button.shape.x = param.shape.x or 0
	button.shape.y = param.shape.y or 0
	button.shape.width = param.shape.width or 200
	button.shape.height = param.shape.height or 200
	button.shape.radius = param.shape.radius or 0
	setColor(button.shape, param.shape)

	button.borderShape = {}
	param.borderShape = param.borderShape or {}
	button.borderShape.width = param.borderShape.width or 2
	setColor(button.borderShape, param.borderShape)

	button.innerShape = {}
	param.innerShape = param.innerShape or {}
	button.innerShape.x = param.innerShape.x or 5
	button.innerShape.y = param.innerShape.y or 5
	button.innerShape.height = param.innerShape.height or 5
	button.innerShape.width = param.innerShape.width or 5
	button.innerShape.radius = param.innerShape.radius or 5
	setColor(button.innerShape, param.innerShape)

	button.borderInnerShape = {}
	param.borderInnerShape = param.borderInnerShape or {}
	button.borderInnerShape.width = param.borderInnerShape.width or 2
	setColor(button.borderInnerShape, param.borderInnerShape)

	button.slider = {}
	param.slider = param.slider or {}
	button.slider.width = param.slider.width or 10
	button.slider.height = param.slider.height or (button.shape.height - button.innerShape.y)
	button.slider.radius = param.slider.radius or 0
	setColor(button.slider, param.slider)
	button.slider.x = button.shape.x + button.innerShape.x - button.slider.width/1.1 + button.innerShape.width/2
	button.slider.y = button.shape.y + button.innerShape.y + (button.innerShape.height - button.slider.height)/2

	button.loader = {}
	param.loader = param.loader or {}
	setColor(button.loader, param.loader)

	button.shadow = {}
	param.shadow = param.shadow or {}
	button.shadow.top = param.shadow.top or 0
	button.shadow.right = param.shadow.right or 0
	button.shadow.down = param.shadow.down or 0
	button.shadow.left = param.shadow.left or 0
	setColor(button.shadow, param.shadow)

	table.insert(buttons, button)
	return button
end

function Click:newPanel(param)
	local panel = {}
	param = param or {}

	panel.class = param.class or false
	panel.visible = param.visible or false

	panel.shape = {}
	param.shape = param.shape or {}
	panel.shape.x = param.shape.x or 0
	panel.shape.y = param.shape.y or 0
	panel.shape.width = param.shape.width or 40
	panel.shape.height = param.shape.height or 100
	panel.shape.radius = math.min(param.shape.radius, panel.shape.height/2)
	setColor(panel.shape, param.shape)

	panel.text = {}
	param.text = param.text or {}
	panel.text.textString = param.text.textString or "panel"
	panel.text.font = love.graphics.newFont(param.text.file or fileDefault, param.text.size or 16)
	panel.text.x = param.text.x or 0
	panel.text.y = param.text.y or 0
	panel.text.limit = param.text.limit or panel.shape.width
	panel.text.align = param.text.align or "center"
	setColor(panel.text, param.text)

	setBorder(panel, param)

	panel.shadow = {}
	param.shadow = param.shadow or {}
	panel.shadow.top = param.shadow.top or 0
	panel.shadow.right = param.shadow.right or 0
	panel.shadow.down = param.shadow.down or 0
	panel.shadow.left = param.shadow.left or 0
	setColor(panel.shadow, param.shadow)

	panel.buttons = {}
	panel.buttons = param.buttons or {}
	for i=1,#panel.buttons do
		for j=1,#buttons do
			if panel.buttons[i] == buttons[j] then
				table.remove(buttons, j)
				break
			end
		end
	end

	table.insert(panels, panel)
	return panel
end

function Click:remove(button)
	for i=1,#buttons do
		if buttons[i] == button then
			table.remove(buttons, i)
			break
		end
	end
	for i=1,#panels do
		if panels[i] == button then
			table.remove(panels, i)
			break
		end
		for j=1,#panels[i].buttons do
			if panels[i].buttons[j] == button then
				table.remove(panels[i].buttons, j)
				break
			end
		end
	end
end

function Click:removeAll()
	buttons = {}
	panels = {}
end

function Click:setClickableByClass(class, clickable)
	for i=1,#buttons do
		if buttons[i].class == class then
			buttons[i].clickable = clickable
		end
	end
	for i=1,#panels do
		for j=1,#panels[i].buttons do
			if panels[i].buttons[j].class == class then
				panels[i].buttons[j].clickable = clickable
			end
		end
	end
end

function Click:setVisibleByClass(class, visible)
	for i=1,#buttons do
		if buttons[i].class == class then
			buttons[i].visible = visible
		end
	end
	for i=1,#panels do
		if panels[i].class == class then
			panels[i].visible = visible
		end
		for j=1,#panels[i].buttons do
			if panels[i].buttons[j].class == class then
				panels[i].buttons[j].visible = visible
			end
		end
	end
end

function Click:setTextByClass(class, param)
	param = param or {}
	class = class or ""
	text = param.text or {}
	text.color = text.color or {}

	for i=1,#buttons do
		if buttons[i].class == class then
			local r = buttons[i].text
			r.text = text.textString or r.text
			r.font = love.graphics.newFont((text.file or r.file), (text.size or r.size))
			r.space = text.space or r.space
			r.verticalAlign = text.verticalAlign or r.verticalAlign
			r.horizontalAlign = text.horizontalAlign or r.horizontalAlign
			r.color.r = text.color.r or r.color.r
			r.color.g = text.color.g or r.color.g
			r.color.b = text.color.b or r.color.b
			r.color.a = text.color.a or r.color.a
			r.tabText = {}
			for i=1,string.len(r.textString) do
				table.insert(r.tabText, love.graphics.newText(r.font, string.sub(r.textString, i, i)))
			end
		end
	end
	for i=1,#panels do
		if panels[i].class == class then
			-- TERMINAR
		end
		for j=1,#panels[i].buttons do
			local r = panels[i].buttons[j].text
			r.text = text.textString or r.text
			r.font = love.graphics.newFont(text.file or r.file, text.size or r.size)
			r.space = text.space or r.space
			r.verticalAlign = text.verticalAlign or r.verticalAlign
			r.horizontalAlign = text.horizontalAlign or r.horizontalAlign
			r.color.r = text.color.r or r.color.r
			r.color.g = text.color.g or r.color.g
			r.color.b = text.color.b or r.color.b
			r.color.a = text.color.a or r.color.a
		end
	end
end

function Click:setShapeByClass(class, param)
	param = param or {}
	class = class or ""
	shape = param.shape or {}
	shape.color = shape.color or {}
	
	for i=1,#buttons do
		if buttons[i].class == class then
			local r = buttons[i].shape
			r.x = shape.x or r.x
			r.y = shape.y or r.y
			r.width = shape.width or r.width
			r.height = shape.height or r.height
			r.radius = shape.radius or r.radius
			r.startAng = shape.startAng or r.startAng
			r.finalAng = shape.finalAng or r.finalAng
			r.color.r = shape.color.r or r.color.r
			r.color.g = shape.color.g or r.color.g
			r.color.b = shape.color.b or r.color.b
			r.color.a = shape.color.a or r.color.a
		end
	end
	for i=1,#panels do
		if panels[i].class == class then
			local r = panels[i].shape
			r.x = shape.x or r.x
			r.y = shape.y or r.y
			r.width = shape.width or r.width
			r.height = shape.height or r.height
			r.radius = shape.radius or r.radius
			r.color.r = shape.color.r or r.color.r
			r.color.g = shape.color.g or r.color.g
			r.color.b = shape.color.b or r.color.b
			r.color.a = shape.color.a or r.color.a
		end
		for j=1,#panels[i].buttons do
			local r = panels[i].buttons[j].shape
			r.x = shape.x or r.x
			r.y = shape.y or r.y
			r.width = shape.width or r.width
			r.height = shape.height or r.height
			r.radius = shape.radius or r.radius
			r.startAng = shape.startAng or r.startAng
			r.finalAng = shape.finalAng or r.finalAng
			r.color.r = shape.color.r or r.color.r
			r.color.g = shape.color.g or r.color.g
			r.color.b = shape.color.b or r.color.b
			r.color.a = shape.color.a or r.color.a
		end
	end
end

function Click:setBorderByClass(class, param)
	param = param or {}
	class = class or ""
	border = param.border or {}
	border.color = border.color or {}

	for i=1,#buttons do
		if buttons[i].class == class then
			local r = buttons[i].border
			r.width = border.width or r.width
			r.color.r = border.color.r or r.color.r
			r.color.g = border.color.g or r.color.g
			r.color.b = border.color.b or r.color.b
			r.color.a = border.color.a or r.color.a
		end
	end
	for i=1,#panels do
		if panels[i].class == class then
			local r = panels[i].border
			r.width = border.width or r.width
			r.color.r = border.color.r or r.color.r
			r.color.g = border.color.g or r.color.g
			r.color.b = border.color.b or r.color.b
			r.color.a = border.color.a or r.color.a
		end
		for i=1,#panels[i].buttons do
			if panels[i].buttons[j].class == class then
				local r = panels[i].buttons[j].border
				r.width = border.width or r.width
				r.color.r = border.color.r or r.color.r
				r.color.g = border.color.g or r.color.g
				r.color.b = border.color.b or r.color.b
				r.color.a = border.color.a or r.color.a
			end
		end
	end
end

function Click:setHoverByClass(class, param)
	param = param or {}
	class = class or ""
	hover = param.hover or {}
	hover.color = hover.color or {}

	for i=1,#buttons do
		if buttons[i].class == class then
			local r = buttons[i].hover
			r.color.r = hover.color.r or r.color.r
			r.color.g = hover.color.g or r.color.g
			r.color.b = hover.color.b or r.color.b
			r.color.a = hover.color.a or r.color.a
		end
	end
	for i=1,#panels do
		for j=1,#panels[i].buttons do
			if panels[i].buttons[j].class == class then
				local r = panels[i].buttons[j].hover
				r.color.r = hover.color.r or r.color.r
				r.color.g = hover.color.g or r.color.g
				r.color.b = hover.color.b or r.color.b
				r.color.a = hover.color.a or r.color.a
			end
		end
	end
end

function Click:setShadowByClass(class, param)
	param = param or {}
	class = class or ""
	shadow = param.shadow or {}
	shadow.color = shadow.color or {}

	for i=1,#buttons do
		if buttons[i].class == class then
			local r = buttons[i].shadow
			r.verticalDeslocation = shadow.verticalDeslocation or r.verticalDeslocation
			r.top = shadow.top or r.top
			r.down = shadow.down or r.down
			r.right = shadow.right or r.right
			r.left = shadow.left or r.left
			r.color.r = shadow.color.r or r.color.r
			r.color.g = shadow.color.g or r.color.g
			r.color.b = shadow.color.b or r.color.b
			r.color.a = shadow.color.a or r.color.a
		end
	end
	for i=1,#panels do
		if panels[i].class == class then
			local r = panels[i].shadow
			r.top = shadow.top or r.top
			r.down = shadow.down or r.down
			r.right = shadow.right or r.right
			r.left = shadow.left or r.left
			r.color.r = shadow.color.r or r.color.r
			r.color.g = shadow.color.g or r.color.g
			r.color.b = shadow.color.b or r.color.b
			r.color.a = shadow.color.a or r.color.a
		end
		for j=1,#panels[i].buttons do
			if panels[i].buttons[j].class == class then
				local r = panels[i].buttons[j].shadow
				r.verticalDeslocation = shadow.verticalDeslocation or r.verticalDeslocation
				r.top = shadow.top or r.top
				r.down = shadow.down or r.down
				r.right = shadow.right or r.right
				r.left = shadow.left or r.left
				r.color.r = shadow.color.r or r.color.r
				r.color.g = shadow.color.g or r.color.g
				r.color.b = shadow.color.b or r.color.b
				r.color.a = shadow.color.a or r.color.a
		end
	end
	end
end

function Click:setFuncByClass(class, param)
	param = param or {}
	class = class or ""
	func = param.func or function() end

	for i=1,#buttons do
		local r = buttons[i]
		if r.class == class then
			r.func = func or r.func
		end
	end
	for i=1,#panels do
		for j=1,#panels[i].buttons do
			local r = panels[i].buttons[j]
			if r.class == class then
				r.func = func or r.func
			end
		end
	end
end

function Click:getValue(button)
	for i=1,#buttons do
		r = buttons[i]
		if button == r and r.buttonType == "slide" then
			return ((r.slider.x + r.slider.width) - (r.innerShape.x + r.shape.x))/r.innerShape.width
		end
	end
	for i=1,#panels do
		for j=1,#panels[i].buttons do
			r = panels[i].buttons[j]
			if button == r and r.buttonType == "slide" then
				return ((r.slider.x + r.slider.width/1.1) - (r.innerShape.x + r.shape.x))/r.innerShape.width
			end
		end
	end
end

-- CALL BACKS -------------------------------------
function Click:draw()
	drawButtons(buttons)
	drawPanels(panels)
end

function Click:update(dt)
	-- MUDA O CURSOR
	local inside
	inside = insideButton(buttons)
	for i=1,#panels do
		if panels[i].visible then
			inside = insideButton(panels[i].buttons, panels[i].shape.x, panels[i].shape.y, i)
		end
	end

	changeCursor(inside)
	-- Executa a função do botão
	if love.mouse.isDown(1) and cursorHand == love.mouse.getCursor() and flag and inside[2] ~= "slide" then
		flag = false
		if inside[4] > 0 then
			panels[inside[4]].buttons[inside[3]].func()
		else
			buttons[inside[3]].func()
		end
	end
	if not love.mouse.isDown(1) and not flag then
		flag = true
	end
	-- Verificando o slider
	if love.mouse.isDown(1) and cursorHand == love.mouse.getCursor() and inside[2] == "slide" then
		if inside[4] > 0 then
			local r = panels[inside[4]].buttons[inside[3]]
			local min = math.min((panels[inside[4]].shape.x + r.shape.x + r.innerShape.x + r.innerShape.width - r.slider.width), 
				(love.mouse.getX() - r.slider.width))

			r.slider.x = math.max(min - panels[inside[4]].shape.x, (r.shape.x + r.innerShape.x - r.slider.width/1.1))
		else
			local r = buttons[inside[3]]
			local min = math.min((love.mouse.getX() - r.slider.width/2), 
			(r.shape.x + r.innerShape.x + r.innerShape.width - r.slider.width/2))

			r.slider.x = math.max(min, (r.shape.x + r.innerShape.x - r.slider.width/2.1)) - r.slider.width/2
		end
	end
end

-- Aux Functions
function changeCursor(inside)
	if inside[1] then
		love.mouse.setCursor(cursorHand)
		hover = {inside[1], inside[2], inside[3]}
	else
		love.mouse.setCursor()
		hover = {false, false, 0}
	end
end

function insideButton(btns, originX, originY, panel)
	originX = originX or 0
	originY = originY or 0
	panel = panel or 0
	local x = love.mouse.getX()
	local y = love.mouse.getY()

	for i=1,#btns do
		-- Inside in rectangle
		if btns[i].clickable and btns[i].visible and btns[i].buttonType == "rectangle" then
			local r = btns[i].shape
			if x > (r.x + originX) and x < (r.x + originX) + r.width and y > (r.y + originY) and y < (r.y + originY) + r.height then
				if r.radius > 0 then
					if (x > (r.x + originX) + r.radius and x < (r.x + originX) + r.width - r.radius) 
						or (y > (r.y + originY) + r.radius and y < (r.y + originY) + r.height - r.radius) 
						or ((x - ((r.x + originX) + r.radius))^2 + (y - ((r.y + originY) + r.radius))^2)^(1/2) < r.radius 
						or ((x - ((r.x + originX) - r.radius + r.width))^2 + (y - ((r.y + originY) + r.radius))^2)^(1/2) < r.radius 
						or ((x - ((r.x + originX) + r.radius))^2 + (y - ((r.y + originY) + r.height - r.radius))^2)^(1/2) < r.radius 
						or ((x - ((r.x + originX) - r.radius + r.width))^2 + (y - ((r.y + originY) + r.height - r.radius))^2)^(1/2) < r.radius then
						return {true, "rectangle", i, panel}
					end
				else
					return {true, "rectangle", i, panel}
				end	
			end
		--inside arc
		elseif btns[i].clickable and btns[i].visible and btns[i].buttonType == "arc" then
			local r = btns[i].shape
			
			local radiusMax = r.radius + r.width/2
			local radiusMin = r.radius - r.width/2
			local distance = ((x - (r.x + originX))^2 + (y - (r.y + originY))^2)^(1/2)

			local angMax
			if y - (r.y + originY) > 0 then
				angMax = math.acos((x-(r.x + originX))/distance)
			else
				angMax = math.acos(((r.x + originX)-x)/distance) + math.rad(180)
			end
			
			local angMin 
			if y - (r.y + originY) > 0 then
				angMin = -math.acos(((r.x + originX)-x)/distance) - math.rad(180)
			else
				angMin = -math.acos((x-(r.x + originX))/distance)
			end

			if distance < radiusMax and distance > radiusMin 
				and (((angMax > r.startAng and angMax < r.finalAng) or (angMax < r.startAng and angMax > r.finalAng)) 
				or ((angMin < r.startAng and angMin > r.finalAng) or (angMin > r.startAng and angMin < r.finalAng))) then
				return {true, "arc", i, panel}
			end
		elseif btns[i].clickable and btns[i].visible and btns[i].buttonType == "slide" then
			local r = btns[i]
			if (x > (r.shape.x + originX) and x < (r.shape.x + originX + r.shape.width)
				and y > (r.shape.y + originY) and y < (r.shape.y + originY + r.shape.height))
				or (x > (originX + r.slider.x) and x < (originX + r.slider.x) + r.slider.width 
				and y > (originY + r.slider.y) and y < (originY + r.slider.y) + r.slider.height) then
				return {true, "slide", i, panel}
			end
		end
	end

	return {false}
end

function drawButtons(btns, originX, originY)
	originX = originX or 0
	originY = originY or 0
	for i=1,#btns do
		--Rectanglebtns
		if btns[i].visible and btns[i].buttonType == "rectangle" then
			local r = btns[i]
			--shadow
			love.graphics.setColor(r.shadow.color.r, r.shadow.color.g, r.shadow.color.b, r.shadow.color.a)
			love.graphics.rectangle("fill", (r.shape.x - r.shadow.left + originX), (r.shape.y - r.shadow.top + originY), 
				(r.shape.width + r.shadow.left + r.shadow.right), (r.shape.height + r.shadow.top + r.shadow.down), r.shape.radius)
			-- Shape
			love.graphics.setColor(r.shape.color.r, r.shape.color.g, r.shape.color.b, r.shape.color.a)
			love.graphics.rectangle("fill", r.shape.x + originX, r.shape.y + originY, r.shape.width, r.shape.height, r.shape.radius)
			-- Hover
			if hover[1] and hover[2] == "rectangle" and hover[3] == i then
				love.graphics.setColor(r.hover.color.r, r.hover.color.g, r.hover.color.b, r.hover.color.a)
				love.graphics.rectangle("fill", r.shape.x + originX, r.shape.y + originY, r.shape.width, r.shape.height, r.shape.radius)
			end
			--Border
			love.graphics.setLineWidth(r.border.width)
			love.graphics.setColor(r.border.color.r, r.border.color.g, r.border.color.b, r.border.color.a)
			love.graphics.rectangle("line", r.shape.x + originX, r.shape.y + originY, r.shape.width, r.shape.height, r.shape.radius)
			--text
			love.graphics.setColor(r.text.color.r, r.text.color.g, r.text.color.b, r.text.color.a)
			local text = love.graphics.newText(r.text.font, r.text.textString)
			local x, y = 0, 0

			if r.text.horizontalAlign == "left" then
				x = r.shape.x + text:getWidth()/2 + r.border.width
			elseif r.text.horizontalAlign == "center" then
				x = r.shape.x + r.shape.width/2
			else
				x = r.shape.x + r.shape.width - text:getWidth()/2 - r.border.width
			end

			if r.text.verticalAlign == "top" then
				y = r.shape.y + text:getHeight()/2 + (r.border.width/2)
			elseif r.text.verticalAlign == "center" then
				y = r.shape.y + r.shape.height/2
			else
				y = r.shape.y + r.shape.height - text:getHeight()/2 - (r.border.width/2)
			end

			love.graphics.draw(text, x + originX, y + originY, 0, 1, 1, text:getWidth()/2, text:getHeight()/2)
		--Arc button
		elseif btns[i].visible and btns[i].buttonType == "arc" then
			local r = btns[i]

			--shadow
			love.graphics.setColor(r.shadow.color.r, r.shadow.color.g, r.shadow.color.b, r.shadow.color.a)
			love.graphics.setLineWidth(r.shape.width + math.abs(r.shadow.verticalDeslocation))
			love.graphics.arc("line", "open", r.shape.x + originX, r.shape.y + originY, r.shape.radius + r.shadow.verticalDeslocation, 
				r.shape.startAng - r.shadow.left, r.shape.finalAng + r.shadow.right)

			--Shape
			love.graphics.setColor(r.shape.color.r, r.shape.color.g, r.shape.color.b, r.shape.color.a)
			love.graphics.setLineWidth(r.shape.width)
			love.graphics.arc("line", "open", r.shape.x + originX, r.shape.y + originY, r.shape.radius, r.shape.startAng, r.shape.finalAng)	

			--Hover
			if hover[1] and hover[2] == "arc" and hover[3] == i then
				love.graphics.setColor(r.hover.color.r, r.hover.color.g, r.hover.color.b, r.hover.color.a)
				love.graphics.arc("line", "open", r.shape.x + originX, r.shape.y + originY, r.shape.radius, r.shape.startAng, r.shape.finalAng)	
			end

			--border
			love.graphics.setLineWidth(r.border.width)
			love.graphics.setColor(r.border.color.r, r.border.color.g, r.border.color.b, r.border.color.a)
			love.graphics.arc("line", "open", r.shape.x + originX, r.shape.y + originY, 
				r.shape.radius + r.shape.width/2, r.shape.startAng, r.shape.finalAng)	
			love.graphics.arc("line", "open", r.shape.x + originX, r.shape.y + originY, 
				r.shape.radius - r.shape.width/2, r.shape.startAng, r.shape.finalAng)
			love.graphics.line((r.shape.x + math.cos(r.shape.startAng)*(r.shape.radius - r.shape.width/2 - r.border.width/2)) + originX, 
				(r.shape.y + math.sin(r.shape.startAng)*(r.shape.radius - r.shape.width/2 - r.border.width/2)) + originY,
				r.shape.x + math.cos(r.shape.startAng)*(r.shape.radius + r.shape.width/2 + r.border.width/2) + originX, 
				r.shape.y + math.sin(r.shape.startAng)*(r.shape.radius + r.shape.width/2 + r.border.width/2) + originY)
			love.graphics.line(r.shape.x + math.cos(r.shape.finalAng)*(r.shape.radius - r.shape.width/2 - r.border.width/2) + originX, 
				r.shape.y + math.sin(r.shape.finalAng)*(r.shape.radius - r.shape.width/2 - r.border.width/2) + originY,
				r.shape.x + math.cos(r.shape.finalAng)*(r.shape.radius + r.shape.width/2 + r.border.width/2) + originX, 
				r.shape.y + math.sin(r.shape.finalAng)*(r.shape.radius + r.shape.width/2 + r.border.width/2) + originY)

			--text
			love.graphics.setColor(r.text.color.r, r.text.color.g, r.text.color.b, r.text.color.a)
			local center = (r.shape.startAng + r.shape.finalAng)/2
			local stringAng = r.text.space * string.len(r.text.textString)
			for i=1,#r.text.tabText do
				local text = r.text.tabText[i]
				love.graphics.draw(r.text.tabText[i], r.shape.x+(math.cos((center - stringAng/2 + r.text.space/2)+r.text.space*(i-1))*r.shape.radius) + originX, 
					r.shape.y+(math.sin((center - stringAng/2 + r.text.space/2)+r.text.space*(i-1))*r.shape.radius) + originY, 
					math.rad(90)+(center - stringAng/2 + r.text.space/2)+r.text.space*(i-1), 1, 1, text:getWidth()/2, text:getHeight()/2)
			end
		elseif btns[i].visible and btns[i].buttonType == "slide" then
			local r = btns[i]
			--shadow
			love.graphics.setColor(r.shadow.color.r, r.shadow.color.g, r.shadow.color.b, r.shadow.color.a)
			love.graphics.rectangle("fill", (r.shape.x - r.shadow.left + originX), (r.shape.y - r.shadow.top + originY), 
				(r.shape.width + r.shadow.left + r.shadow.right), (r.shape.height + r.shadow.top + r.shadow.down), r.shape.radius)
			--shape
			love.graphics.setColor(r.shape.color.r, r.shape.color.g, r.shape.color.b, r.shape.color.a)
			love.graphics.rectangle("fill", r.shape.x + originX, r.shape.y + originY, r.shape.width, r.shape.height, r.shape.radius)
			--borderShape
			love.graphics.setColor(r.borderShape.color.r, r.borderShape.color.g, r.borderShape.color.b, r.borderShape.color.a)
			love.graphics.rectangle("line", r.shape.x + originX, r.shape.y + originY, r.shape.width, r.shape.height, r.shape.radius)
			--innerShape
			love.graphics.setColor(r.innerShape.color.r, r.innerShape.color.g, r.innerShape.color.b, r.innerShape.color.a)
			love.graphics.rectangle("fill", r.shape.x + r.innerShape.x + originX, r.shape.y + r.innerShape.y + originY, 
				r.innerShape.width, r.innerShape.height, r.innerShape.radius)
			--loader
			love.graphics.setColor(r.loader.color.r, r.loader.color.g, r.loader.color.b, r.loader.color.a)
			love.graphics.rectangle("fill", r.shape.x + r.innerShape.x + originX, r.shape.y + r.innerShape.y + originY, 
				(r.slider.x + originX) -  (r.shape.x + r.innerShape.x + originX) + r.slider.width, r.innerShape.height, r.innerShape.radius)
			--borderInnerShape
			love.graphics.setColor(r.borderInnerShape.color.r, r.borderInnerShape.color.g, r.borderInnerShape.color.b, r.borderInnerShape.color.a)
			love.graphics.rectangle("line", r.shape.x + r.innerShape.x + originX, r.shape.y + r.innerShape.y + originY, 
				r.innerShape.width, r.innerShape.height, r.innerShape.radius)
			--slider
			love.graphics.setColor(r.slider.color.r, r.slider.color.g, r.slider.color.b, r.slider.color.a)
			love.graphics.rectangle("fill", r.slider.x + originX + r.slider.width/2, r.slider.y + originY, r.slider.width, 
				r.slider.height, r.slider.radius)

		end
	end
end

function drawPanels(pnls)
	for i=1,#pnls do
		if pnls[i].visible then
			local r = pnls[i]

			--shadow
			love.graphics.setColor(r.shadow.color.r, r.shadow.color.g, r.shadow.color.b, r.shadow.color.a)
			love.graphics.rectangle("fill", (r.shape.x - r.shadow.left), (r.shape.y - r.shadow.top), 
				(r.shape.width + r.shadow.left + r.shadow.right), (r.shape.height + r.shadow.top + r.shadow.down), r.shape.radius)
			-- Shape
			love.graphics.setColor(r.shape.color.r, r.shape.color.g, r.shape.color.b, r.shape.color.a)
			love.graphics.rectangle("fill", r.shape.x, r.shape.y, r.shape.width, r.shape.height, r.shape.radius)
			--Border
			love.graphics.setLineWidth(r.border.width)
			love.graphics.setColor(r.border.color.r, r.border.color.g, r.border.color.b, r.border.color.a)
			love.graphics.rectangle("line", r.shape.x, r.shape.y, r.shape.width, r.shape.height, r.shape.radius)
			--text
			love.graphics.setColor(r.text.color.r, r.text.color.g, r.text.color.b, r.text.color.a)
			love.graphics.setFont(r.text.font)
			love.graphics.printf(r.text.textString, r.text.x + r.shape.x, r.text.y + r.shape.y, r.text.limit, r.text.align)

			drawButtons(r.buttons, r.shape.x, r.shape.y)

		end
	end
end

function setColor(btns, param)
	btns.color = {}
	param.color = param.color or {}
	btns.color.r = param.color.r or love.math.random(170, 220)
	btns.color.g = param.color.g or love.math.random(170, 220)
	btns.color.b = param.color.b or love.math.random(170, 220)
	btns.color.a = param.color.a or love.math.random(80, 255)
end
function setBorder(btns, param)
	btns.border = {}
	param.border = param.border or {}
	btns.border.width = param.border.width or 0
	setColor(btns.border, param.border)
end
function setHover(btns, param)
	btns.hover = {}
	param.hover = param.hover or {}
	setColor(btns.hover, param.hover)
end
---------------------------------------------------------------------------

return Click