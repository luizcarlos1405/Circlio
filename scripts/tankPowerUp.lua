tankPowerUp = Script({Tank})

-- Table de powerups e as funções que os definem
tankPowerUp.powerups = {
    Life = function(t, dt)
        -- Adiciona uma vida ao tank
        t.tank.life = t.tank.life + 1
        -- Remove o powerup porque ele já foi gasto auqui
        table.remove(t.tank.powerups, tankPowerUp:hasPowerUp(t, "Life"))
    end,
    FastFire = function(t, dt)
        if not tankPowerUp:hasPowerUp(t, "FastFire") then
            -- Guarda valor original/base do firerate
            t.tank.baseFireRate = t.tank.firerate
            -- Inicia powerup
            t.tank.fastfiretime = PUTIME
            t.tank.firerate = PUFIRERATE
            table.insert(t.tank.powerups, "FastFire")
        elseif t.tank.fastfiretime > 0 then
            -- Atualiza o estado do powerup
            t.tank.fastfiretime = t.tank.fastfiretime - dt
        else
            -- Retorna para o valor base e finaliza o powerup
            t.tank.firerate = t.tank.baseFireRate
            tankPowerUp:unsetPowerUp(t, "FastFire")
        end
    end,
    SpeedBoost = function(t,dt)
        if not tankPowerUp:hasPowerUp(t, "SpeedBoost") then
            -- Guarda valor original/base do firerate
            t.tank.baseMaxSpeed = t.tank.maxSpeed
            -- Inicia powerup
            t.tank.speedboosttime = PUTIME
            t.tank.maxSpeed = MAXSPEED
            table.insert(t.tank.powerups, "SpeedBoost")
        elseif t.tank.speedboosttime > 0 then
            -- Atualiza o estado do powerup
            t.tank.speedboosttime = t.tank.speedboosttime - dt
        else
            -- Retorna para o valor base e finaliza o powerup
            t.tank.maxSpeed = t.tank.baseMaxSpeed
            tankPowerUp:unsetPowerUp(t, "SpeedBoost")
        end
    end,
    SpreadShot = function(t, dt)
        if not tankPowerUp:hasPowerUp(t, "SpreadShot") then
            -- Inicia powerup
            t.tank.spreadshottime = PUTIME
            table.insert(t.tank.powerups, "SpreadShot")
            -- Reescreve callback pra atirar mais duas bolinhas
            function t.tank.fired()
                local aux = 0
                local var = vector()
                if t.tank.dir>0 then
            		aux = 1
            	elseif t.tank.dir<0 then
            		aux = -1
            	end
                var.x = (aux * math.sin(t.tank.pos - math.pi) * 100) --/ math.min(t.tank.holdtime + 1, 4)
                var.y = (aux * math.cos(t.tank.pos - math.pi) * 100)
                Treco(Position(t.tank.treco.pos.x, t.tank.treco.pos.y), Bullet({dir = vector.rotate(vector.normalize(gameCenter-var-t.tank.treco.pos), -math.pi/20), speed = 100 + (1.913^t.tank.holdtime) * 100, source = t.tank.treco}), BoxCollider(14,14, vector(-7,-7)))
                Treco(Position(t.tank.treco.pos.x, t.tank.treco.pos.y), Bullet({dir = vector.rotate(vector.normalize(gameCenter-var-t.tank.treco.pos), math.pi/20), speed = 100 + (1.913^t.tank.holdtime) * 100, source = t.tank.treco}), BoxCollider(14,14, vector(-7,-7)))
            end
        elseif t.tank.spreadshottime > 0 then
            -- Atualiza o estado do powerup
            t.tank.spreadshottime = t.tank.spreadshottime - dt
        else
            -- Retorna para o valor base e finaliza o powerup
            tankPowerUp:unsetPowerUp(t, "SpreadShot")
            -- Reseta a callback
            function t.tank.fired()end
        end
    end
}

function tankPowerUp:update(t, dt)
    for _,p in pairs(t.tank.powerups) do
        self.powerups[p](t, dt)
    end
end

function tankPowerUp:setPowerUp(t, p)
    -- Se ele já tiver o powerup não colocar de novo
    if self:hasPowerUp(t, p) then
        return false
    end
    -- Coloca powerup na lista de powerups do tank
    print(p)
    self.powerups[p](t)
    return true
end

function tankPowerUp:unsetPowerUp(t, p)
    table.remove(t.tank.powerups, self:hasPowerUp(t, p))
    return true
end

-- Retorna a chave do powerup ou nil se o tank não tiver
function tankPowerUp:hasPowerUp(t, p)
    for k,v in pairs(t.tank.powerups) do
        if v == p then
            return k
        end
    end
    return nil
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
