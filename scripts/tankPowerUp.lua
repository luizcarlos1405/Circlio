tankPowerUp = Script({Tank})

-- Função especial de tiro para o update Spread Shot protótipo
local function spreadShotFire(t)end

-- Table de powerups e as funções que os definem
tankPowerUp.powerups = {
    Life = function(t, dt)
        -- Adiciona uma vida ao tank
        t.tank.life = t.tank.life + 1
        -- Som de narrador anunciando o powerup
        narrative.life:play()
    end,
    FastFire = function(t, dt)
        if not t.tank.powerups["FastFire"] then
            -- Guarda valor original/base do firerate e da função fire original
            t.tank.baseFireRate = t.tank.firerate
            -- Inicia powerup
            t.tank.fastfiretime = PU.fastfire.time
            t.tank.firerate = t.tank.firerate * PU.fastfire.mod
            t.tank.powerups["FastFire"] = true
            -- Som de narrador anunciando o powerup
            narrative.fastFire:play()
        elseif t.tank.fastfiretime > 0 then
            -- Atualiza o estado do powerup
            if dt then
                t.tank.fastfiretime = t.tank.fastfiretime - dt
            else
                t.tank.fastfiretime = PU.fastfire.time
                -- Som de narrador anunciando o powerup
                narrative.fastFire:play()
            end
        else
            -- Retorna para valores base e finaliza o powerup
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

            -- Som de narrador anunciando o powerup
            narrative.speedBoost:play()
        elseif t.tank.speedboosttime > 0 then
            -- Atualiza o estado do powerup
            if dt then
                t.tank.speedboosttime = t.tank.speedboosttime - dt
            else
                t.tank.speedboosttime = PU.speedboost.time
                -- Som de narrador anunciando o powerup
                narrative.speedBoost:play()
            end
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
            -- Reescreve função de tiro para atirar 3 bolinhas e guarda a original
            t.tank.baseFireFunction = t.tank.fire
            t.tank.fire = spreadShotFire

            -- Som de narrador anunciando o powerup
            narrative.spreadShot:play()
        elseif t.tank.spreadshottime > 0 then
            -- Atualiza o estado do powerup
            if dt then
                t.tank.spreadshottime = t.tank.spreadshottime - dt
            else
                -- Se já tiver o powerup reseta o tempo
                t.tank.spreadshottime = PU.spreadshot.time
                -- Som de narrador anunciando o powerup
                narrative.spreadShot:play()
            end
        else
            -- Retorna para o valor base e finaliza o powerup
            t.tank.powerups["SpreadShot"] = false
            -- Retorna à função de tiro original
            t.tank.fire = t.tank.baseFireFunction
        end
    end
}

tankPowerUp.indices = {}
for k,v in pairs(tankPowerUp.powerups) do
    table.insert(tankPowerUp.indices, k)
end

function tankPowerUp:update(t, dt)
    for k,v in pairs(t.tank.powerups) do
        if v then
            self.powerups[k](t, dt)
        end
    end
end

function tankPowerUp:setPowerUp(t, p)
    -- Roda powerup
    print(p)
    self.powerups[p](t)
    return true
end

-- Retorna a chave do powerup ou nil se o tank não tiver
function tankPowerUp:hasPowerUp(t, p)
    return t.tank.powerups[p]
end

function spreadShotFire(t)
    if not t:canFire() then return end

    --A fazer: Animar a volta do cooldown a zero, de acordo com o firerate
    t.lastFire = love.timer.getTime()
    t.isCharging = false

    local var = vector()
    local aux = 0

    if t.dir>0 then
        aux = 1
    elseif t.dir<0 then
        aux = -1
    end

    var.x = (aux * math.sin(t.pos - math.pi) * 100) --/ math.min(t.tank.holdtime + 1, 4)
    var.y = (aux * math.cos(t.pos - math.pi) * 100)

    local bulletSize = BS.bullet.size + t.holdtime*BS.bullet.size

    -- Bala do meio
    local bulletPos = gameCenter+vector(math.cos(t.pos)*(t.arena.arena.raio-35), math.sin(t.pos)*(t.arena.arena.raio-35))
    Treco(Position(bulletPos.x, bulletPos.y),
    Bullet({dir = vector.normalize(gameCenter-var-t.treco.pos),
    speed = 300 + (1.913^t.holdtime) * 100,
    size = bulletSize,
    source = t.treco}),
    Circoll(bulletSize))

    -- Bala sentido horario
    bulletPos = gameCenter+vector(math.cos(t.pos)*(t.arena.arena.raio-35), math.sin(t.pos)*(t.arena.arena.raio-35))
    Treco(Position(bulletPos.x, bulletPos.y),
    Bullet({dir = vector.rotate(vector.normalize(gameCenter-var-t.treco.pos), PU.spreadshot.mod),
    speed = 300 + (1.913^t.holdtime) * 100,
    size = bulletSize,
    source = t.treco}),
    Circoll(bulletSize))

    -- Bala sentido anti-horario
    bulletPos = gameCenter+vector(math.cos(t.pos)*(t.arena.arena.raio-35), math.sin(t.pos)*(t.arena.arena.raio-35))
    Treco(Position(bulletPos.x, bulletPos.y),
    Bullet({dir = vector.rotate(vector.normalize(gameCenter-var-t.treco.pos), -PU.spreadshot.mod),
    speed = 300 + (1.913^t.holdtime) * 100,
    size = bulletSize,
    source = t.treco}),
    Circoll(bulletSize))

    t.holdtime = 0

    -- Efeito sonoro de tiro também acionado na função original definida no tankMotor.lua
    effect.shoot:play()
end

-- function tankPowerUp:keypressed(t, key)
--     if key == 'l' then
--         self:setPowerUp(t, "Life")
--     end
--     if key == 'k' then
--         self:setPowerUp(t, "FastFire")
--     end
--     if key == 'j' then
--         self:setPowerUp(t, "SpreadShot")
--     end
--     if key == 'h' then
--         self:setPowerUp(t, "SpeedBoost")
--     end
-- end
