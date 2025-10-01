local M  = {}

function M.preload()
    M.lightPos = {0.5, 0.0}
    M.smoothSpeed = 2
    M.blinkDuration = 0
    M.lampOn = true

    M.coneShader = love.graphics.newShader('gfx/cone.glsl')
    M.coneShader:send('lightPosition', M.lightPos)
    M.coneShader:send('coneAngle', 0.15)
    M.coneShader:send('softness', 0.07)
    M.coneShader:send('dropoff', 0.65)
    M.coneShader:send('lightColor', {1.0, 0.9, 0.6})
    M.coneShader:send('direction', {0, 1.0})

    M.blinkTimer = math.random(4, 6)
end

function M.update(dt)
    local w, h = love.graphics.getDimensions()
    local mx, my = love.mouse.getPosition()

    local targetX = clamp(mx / w, 0.4, 0.6)
    local targetY = clamp(my / h, 0.0, 0.08)

    M.lightPos[1] = M.lightPos[1] + (targetX - M.lightPos[1]) * M.smoothSpeed * dt
    M.lightPos[2] = M.lightPos[2] + (targetY - M.lightPos[2]) * M.smoothSpeed * dt

    if M.blinkDuration > 0 then
        M.blinkDuration = M.blinkDuration - dt
        if M.blinkDuration <= 0 then
            M.lampOn = true
            M.blinkTimer = 4 + math.random() * 2  -- 4.0–6.0
        end
    else
        M.blinkTimer = M.blinkTimer - dt
        if M.blinkTimer <= 0 then
            M.lampOn = false
            M.blinkDuration = 0.1 + math.random() * 0.2 -- 0.1–0.3
        end
    end

    if not M.lampOn then
        M.coneShader:send('lightPosition', {2, 2})
    else
        M.coneShader:send('lightPosition', M.lightPos)
    end
end

return M
