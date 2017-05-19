tankPowerUp = Script({Tank})

-- Função especial de tiro para o update Spread Shot protótipo
local function spreadShotFire(t)end
local bulletImage = love.graphics.newImage("assets/bullet1flame.png")

-- Table de powerups e as funções que os definem
tankPowerUp.powerups = {
    life = function(t, dt)
        -- Adiciona uma vida ao tank
        t.tank:damage(1)
    end,
    fastFire = function(t, dt)
        if not t.tank.powerups["fastFire"] then
            -- Guarda valor original/base do firerate e da função fire original
            t.tank.baseFireRate = t.tank.firerate
            -- Inicia powerup
            t.tank.fastfiretime = gconf.powerup.fastfire.time
            t.tank.firerate = t.tank.firerate * gconf.powerup.fastfire.mod
            t.tank.powerups["fastFire"] = true
        elseif t.tank.fastfiretime > 0 then
            -- Atualiza o estado do powerup
            if dt then
                t.tank.fastfiretime = t.tank.fastfiretime - dt
            else
                t.tank.fastfiretime = gconf.powerup.fastfire.time
            end
        else
            -- Retorna para valores base e finaliza o powerup
            t.tank.firerate = t.tank.baseFireRate
            t.tank.powerups["fastFire"] = false
        end
    end,
    speedBoost = function(t,dt)
        if not t.tank.powerups["speedBoost"] then
            -- Guarda valor original/base do firerate
            t.tank.baseMaxSpeed = t.tank.maxSpeed
            -- Inicia powerup
            t.tank.speedboosttime = gconf.powerup.speedboost.time
            t.tank.maxSpeed = t.tank.maxSpeed * gconf.powerup.speedboost.mod
            t.tank.powerups["speedBoost"] = true

        elseif t.tank.speedboosttime > 0 then
            -- Atualiza o estado do powerup
            if dt then
                t.tank.speedboosttime = t.tank.speedboosttime - dt
            else
                t.tank.speedboosttime = gconf.powerup.speedboost.time
            end
        else
            -- Retorna para o valor base e finaliza o powerup
            t.tank.maxSpeed = t.tank.baseMaxSpeed
            t.tank.powerups["speedBoost"] = false
        end
    end,
    spreadShot = function(t, dt)
        if not t.tank.powerups["spreadShot"] then
            -- Inicia powerup
            t.tank.spreadshottime = gconf.powerup.spreadshot.time
            t.tank.powerups["spreadShot"] = true
            -- Reescreve função de tiro para atirar 3 bolinhas e guarda a original
            t.tank.baseFireFunction = t.tank.fire
            t.tank.fire = spreadShotFire

        elseif t.tank.spreadshottime > 0 then
            -- Atualiza o estado do powerup
            if dt then
                t.tank.spreadshottime = t.tank.spreadshottime - dt
            else
                -- Se já tiver o powerup reseta o tempo
                t.tank.spreadshottime = gconf.powerup.spreadshot.time
            end
        else
            -- Retorna para o valor base e finaliza o powerup
            t.tank.powerups["spreadShot"] = false
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
    self.powerups[p](t)
    return true
end

-- Retorna a chave do powerup ou nil se o tank não tiver
function tankPowerUp:hasPowerUp(t, p)
    return t.tank.powerups[p]
end

function spreadShotFire(t)
    if not t:canFire() then return end

    t.lastFire = love.timer.getTime()
    t.isCharging = false

    -- Calcula tamanho da bala em relação ao tempo segurado
    local bulletSize = gconf.bullet.size + t.holdtime*gconf.bullet.size
    -- Posição da bullet de acordo com o player
    local bulletPos = gameCenter+vector(math.cos(t.pos)*(t.arena.arena.raio-35), math.sin(t.pos)*(t.arena.arena.raio-35))

    -- Bala do meio
    spawnBullet(t, bulletPos, bulletSize, vector.rotate(vector.normalize(gameCenter-t.treco.pos), -t.dir * gconf.bullet.inercia))

    -- Bala sentido horario
    spawnBullet(t, bulletPos, bulletSize, vector.rotate(vector.normalize(gameCenter-t.treco.pos), -t.dir * gconf.bullet.inercia - gconf.powerup.spreadshot.mod))

    -- Bala sentido anti-horario
    spawnBullet(t, bulletPos, bulletSize, vector.rotate(vector.normalize(gameCenter-t.treco.pos), -t.dir * gconf.bullet.inercia + gconf.powerup.spreadshot.mod))

    t.holdtime = 0

    event.trigger("tank_shoot", t, bulletSize)
end

function tankPowerUp:keypressed(t, key)
    if key == "0" then
        self:setPowerUp(t, "spreadShot")
        self:setPowerUp(t, "speedBoost")
        self:setPowerUp(t, "fastFire")
    end
end
