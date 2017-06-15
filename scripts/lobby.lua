Lobby = Script({Arena})

local names = {
	"Coxinha",
	"Risoles",
	"Fulano",
	"Ciclano"
}

local colors = {
	Color(194,0,136),
	Color(255,164,5),
	Color(255,168,187),
	Color(66,102,0),
	Color(255,0,16),
	Color(94,241,242),
	Color(0,153,143),
	Color(224,255,102),
	Color(116,10,255),
	Color(153,0,0),
	Color(255,255,128),
	Color(255,255,0),
	Color(240,163,255),
	Color(0,117,220),
	Color(153,63,0),
	Color(0,92,49),
	Color(43,206,72),
	Color(255,204,153),
	Color(128,128,128),
	Color(148,255,181),
	Color(143,124,0),
	Color(157,204,0),
	Color(255,80,5)
}


local kbControls = {"left", "right", "space", "lshift"}
local kbPlayer = false

local joyControls = 4
local joyPlayer = {
	false, false, false, false	--Suporte pra 4 controles
}

local botKey = "q"

local lastInput = love.timer.getTime()

local playerCont = 0
local botCont = 0

local tanks = {}

local countDown

local function nextColor()
	return colors[math.max(1,((playerCont+botCont)%#colors))]
end

local function refreshPositions()
	local spacing = math.pi/#tanks*2
	for i,v in ipairs(tanks) do
		v.tank.pos = spacing * (i-1)
	end
end

function Lobby:update(t, dt)
	if playerCont + botCont < 2 then
		lastInput = love.timer.getTime()
	end
	countDown = math.ceil(3 - (love.timer.getTime() - lastInput))
	if countDown<=0 then
		tCore.unregisterScript(Lobby)
		for i,v in ipairs(tanks) do
			v.tank.active = true
			v.tank:resetBullet()
		end
		t.arena.started = true
	end
end

function Lobby:draw(t)	
	love.graphics.print(countDown, t.pos.x, t.pos.y)
end

function Lobby:keypressed(t, k)
	if k == kbControls[3] and not kbPlayer then
		playerCont = playerCont + 1
		tanks[#tanks+1] = Treco(
			Position(vector(0, 0)), 
			Tank(names[playerCont], t, 0, nextColor()),
			KeyboardInput(kbControls[1], kbControls[2], kbControls[3], kbControls[4]),
			Circoll(20))
		refreshPositions()
		kbPlayer = true
		lastInput = love.timer.getTime()
	end	
	if k == botKey then
		botCont = botCont + 1
		tanks[#tanks+1] = Treco(
			Position(vector(0, 0)),
			Tank("Bot"..botCont, t, 0, nextColor()),
			Bot, Circoll(20))
		refreshPositions()
		lastInput = love.timer.getTime()
	end
end

function Lobby:joystickpressed(t, joy, b)
	joy = joy:getID()
	if b == joyControls and not joyPlayer[joy] then
		playerCont = playerCont + 1
		joyPlayer[joy] = true
		tanks[#tanks+1] = Treco(
			Position(vector(0, 0)), 
			Tank(names[playerCont], t, 0, nextColor()),
			JoystickInput(joy, joyControls),
			Circoll(20))
		refreshPositions()
		lastInput = love.timer.getTime()
	end
end