KeyboardInputHandler = Script({Tank, KeyboardInput})
--[[
	KeyboardInputHandler
	Controla um tank com input do jogador pelo teclado
]]

function KeyboardInputHandler:update(t, dt)

	if (love.keyboard.isDown(t.kbInput.left)) then
		t.tank:move(1)
	elseif (love.keyboard.isDown(t.kbInput.right)) then
		t.tank:move(-1)
	else
		t.tank:move(0)
	end
end

function KeyboardInputHandler:keypressed(t, key)
	if key == t.kbInput.shoot then
		t.tank:chargeFire()
	end
end

function KeyboardInputHandler:keyreleased(t, key)
	if key == t.kbInput.shoot then
		t.tank:fire()
	end
end
