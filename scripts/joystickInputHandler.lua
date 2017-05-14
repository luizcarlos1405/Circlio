joystickInputHandler = Script({Tank, JoystickInput})
--[[
	joystickInputHandler
	Controla um tank com input do jogador pelo joystick
]]

function joystickInputHandler:init(t)
    local js = love.joystick.getJoysticks()
    t.jsInput.joystick = js[t.jsInput.jsnumber]
	t.jsInput.isCharging = false
end

function joystickInputHandler:update(t, dt)
	local input = -t.jsInput.joystick:getAxis(1)
	-- lida com deadzone
	if math.abs(input) < 0.2 then
		input = 0
	end
    t.tank:move(input)


    if t.jsInput.isCharging and not t.jsInput.joystick:isDown(t.jsInput.shoot) then
    	t.tank:fire()
    	t.jsInput.isCharging = false
    end
end

function joystickInputHandler:joystickpressed(t, joystick, button)
    -- print(button)
	if button == t.jsInput.shoot and joystick == t.jsInput.joystick then
		t.tank:chargeFire()
    	t.jsInput.isCharging = true
	end
end

