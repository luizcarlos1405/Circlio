joystickInputHandler = Script({Tank, JoystickInput})
--[[
	joystickInputHandler
	Controla um tank com input do jogador pelo joystick
]]

function joystickInputHandler:init(t)
    local js = love.joystick.getJoysticks()
    t.jsInput.joystick = js[t.jsInput.jsnumber]
	t.jsInput.isCharging = false
	t.jsInput.isVibrating = false

	event.listen("tank_damage", function(tank)
		if tank == t.tank then
			t.jsInput.joystick:setVibration(1, 1)
			t.jsInput.isVibrating = true
			timer.after(0.1, function()
				t.jsInput.joystick:setVibration()
				t.jsInput.isVibrating = false
			end)
		end
	end)
	event.listen("tank_die", function(tank)
		if tank == t.tank then
			t.jsInput.joystick:setVibration(1, 1)
			t.jsInput.isVibrating = true
			timer.after(1, function()
				t.jsInput.joystick:setVibration()
				t.jsInput.isVibrating = false
			end)
		end
	end)
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
    if not t.jsInput.isVibrating then
    	t.jsInput.joystick:setVibration(0,t.tank.holdtime/10)
    end
end

function joystickInputHandler:joystickpressed(t, joystick, button)
	if joystick == t.jsInput.joystick then
		if button == t.jsInput.shoot then
			t.tank:chargeFire()
	    	t.jsInput.isCharging = true
		end
		if button == t.jsInput.dash then
			t.tank:dash()
		end
	end
end

