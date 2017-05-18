KeyboardInputHandler = Script({Tank, KeyboardInput})
--[[
	KeyboardInputHandler
	Controla um tank com input do jogador pelo teclado
]]

function KeyboardInputHandler:init(t)
	t.kbInput.isCharging = false
end

function KeyboardInputHandler:update(t, dt)
    local dir = 0

    if love.keyboard.isDown(t.kbInput.left) then
        dir = 1
    end
    if love.keyboard.isDown(t.kbInput.right) then
        dir = dir - 1
    end

    t.tank:move(dir)

    if t.kbInput.isCharging and not love.keyboard.isDown(t.kbInput.shoot) then
    	t.tank:fire()
    	t.kbInput.isCharging = false
    end
end

function KeyboardInputHandler:keypressed(t, key)
	if key == t.kbInput.shoot then
		t.tank:chargeFire()
		t.kbInput.isCharging = true
	end
    if key == t.kbInput.dash then
        t.tank:dash()
    end
end