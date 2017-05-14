joystickInputHandler = Script({Tank, JoystickInput})
--[[
	joystickInputHandler
	Controla um tank com input do jogador pelo teclado
]]

function joystickInputHandler:init(t)
    local js = love.joystick.getJoysticks()
    t.jsInput.joystick = js[t.jsInput.jsnumber]
end

function joystickInputHandler:update(t, dt)
    t.tank:move(-t.jsInput.joystick:getAxis(1))
end

function joystickInputHandler:joystickpressed(t, joystick, button)
	if button == t.jsInput.shoot then
		t.tank:chargeFire()
	end
end

function joystickInputHandler:joystickreleased(t, joystick, button)
	if button == t.jsInput.shoot then
		t.tank:fire()
	end
end
