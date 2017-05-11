tankPowerUp = Script({Tank})

-- Table de powerups e as funções que os definem
tankPowerUp.powerups = {
    Life = function(t, dt)
        -- Adiciona uma vida ao tank
        t.tank.life = t.tank.life + 1
    end,
    FastFire = function(t, dt)
        print("AQUI")
        if not t.tank.powerups["FastFire"] then
            -- Guarda valor original/base do firerate
            t.tank.baseFireRate = t.tank.firerate
            -- Inicia powerup
            t.tank.fastfiretime = PU.fastfire.time
            t.tank.firerate = t.tank.firerate * PU.fastfire.mod
            t.tank.powerups["FastFire"] = true
        elseif t.tank.fastfiretime > 0 then
            -- Atualiza o estado do powerup
            t.tank.fastfiretime = t.tank.fastfiretime - dt
        else
            -- Retorna para o valor base e finaliza o powerup
            t.tank.firerate = t.tank.baseFireRate
            t.tank.powerups["FastFire"] = false
        end
    end,
    SpeedBoost = function(t,dt)
        if not t.tank.powerups["SpeedBoost"] then
            -- Guarda valor original/base do firerate
            t.tank.baseMaxSpeed = t.tank.maxSpeed
            -- Inicia powerup
            t.tank.speedboosttime = PU.speedboost.time
            t.tank.maxSpeed = t.tank.maxSpeed * PU.speedboost.mod
            t.tank.powerups["SpeedBoost"] = true
        elseif t.tank.speedboosttime > 0 then
            -- Atualiza o estado do powerup
            t.tank.speedboosttime = t.tank.speedboosttime - dt
        else
            -- Retorna para o valor base e finaliza o powerup
            t.tank.maxSpeed = t.tank.baseMaxSpeed
            t.tank.powerups["SpeedBoost"] = false
        end
    end,
    SpreadShot = function(t, dt)
        if not t.tank.powerups["SpreadShot"] then
            -- Inicia powerup
            t.tank.spreadshottime = PU.spreadshot.time
            t.tank.powerups["SpreadShot"] = true
        elseif t.tank.spreadshottime > 0 then
            -- Atualiza o estado do powerup
            t.tank.spreadshottime = t.tank.spreadshottime - dt
        else
            -- Retorna para o valor base e finaliza o powerup
            t.tank.powerups["SpreadShot"] = false
        end
        -- print(t.tank.spreadshottime)
    end
}

function tankPowerUp:update(t, dt)
    for k,v in pairs(t.tank.powerups) do
        if v then
            self.powerups[k](t, dt)
        end
    end
end

function tankPowerUp:setPowerUp(t, p)
    -- Se ele já tiver o powerup não colocar de novo
    if self:hasPowerUp(t, p) then
        return false
    end

    -- Roda powerup
    self.powerups[p](t)
    return true
end

-- Retorna a chave do powerup ou nil se o tank não tiver
function tankPowerUp:hasPowerUp(t, p)
    return t.tank.powerups[p]
end

function tankPowerUp:keypressed(t, key)
    if key == 'l' then
        self:setPowerUp(t, "Life")
    end
    if key == 'k' then
        self:setPowerUp(t, "FastFire")
    end
    if key == 'j' then
        self:setPowerUp(t, "SpreadShot")
    end
    if key == 'h' then
        self:setPowerUp(t, "SpeedBoost")
    end
end
