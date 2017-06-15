TankIA = Script({Bot})

function TankIA:init(t)
	t.bot.dir = 1
	t.bot.isCharging = false
end

function TankIA:update(t, dt)
    if not t.tank.active then return end

	if love.math.random()<0.01 then
		t.bot.dir = -t.bot.dir
	end

    if love.math.random()<0.001 then
        if t.tank:canDash() then
            t.tank:dash()
        end
    end

	if not t.bot.isCharging then
		if love.math.random()<0.2 then
			t.bot.isCharging = true
			t.tank:chargeFire()
		end
	else
		if love.math.random()<0.01 then
			t.bot.isCharging = false
			t.tank:fire()
		end
	end

	t.tank:move(t.bot.dir)
end
