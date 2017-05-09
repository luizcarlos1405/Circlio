KeyboardInputHandler = Script({Tank, KeyboardInput})
--[[
	KeyboardInputHandler
	Controla um tank com input do jogador pelo teclado
]]

function KeyboardInputHandler:update(t, dt)
    local dir = 0

    if love.keyboard.isDown(t.kbInput.left) then
        dir = 1
    end
    if love.keyboard.isDown(t.kbInput.right) then
        dir = dir - 1
    end

    t.tank:move(dir)
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
