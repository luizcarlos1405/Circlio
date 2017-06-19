KeyboardInputHandler = Script({Tank, KeyboardInput})
--[[
	KeyboardInputHandler
	Controla um tank com input do jogador pelo teclado
]]

function KeyboardInputHandler:init(t)
	t.kbInput.isCharging = false
end

function KeyboardInputHandler:update(t, dt)
    if t.tank.freeze then return end

    local dir = 0

    if love.keyboard.isDown(t.kbInput.left) then
        dir = 1
    end
    if love.keyboard.isDown(t.kbInput.right) then
        dir = dir - 1
    end

    t.tank:move(dir)

    if love.keyboard.isDown(t.kbInput.shoot) and not t.kbInput.isCharging and t.tank:canFire() then
        t.tank:chargeFire()
        t.kbInput.isCharging = true
    end

    if love.keyboard.isDown(t.kbInput.dash) and t.tank:canDash() then
        t.tank:dash()
    end

    if t.kbInput.isCharging and not love.keyboard.isDown(t.kbInput.shoot) then
    	t.tank:fire()
    	t.kbInput.isCharging = false
    end

    -- Se estiver no fastFire atirar só de segurar o botão e não ficar carregando
    -- No tankPowerUp.lua ele da chardFire quando acaba o powerup pra ficar tudo certo
    -- Este código está "repetido" no joystickInputHandler
    if t.tank:canFire() and love.keyboard.isDown(t.kbInput.shoot) and t.tank.powerups["fastFire"] then
        t.tank:fire()
    end
end
