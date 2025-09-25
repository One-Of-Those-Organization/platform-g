local objects = {
    require("rtable"),
}

local lightPos = {0.5, 0.0}   -- start at center top
local smoothSpeed = 2         -- bigger = faster follow
local blinkTimer
local blinkDuration = 0
local lampOn = true

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    coneShader = love.graphics.newShader('gfx/cone.glsl')
    coneShader:send('lightPosition', lightPos)
    coneShader:send('coneAngle', 0.15)
    coneShader:send('softness', 0.08)
    coneShader:send('dropoff', 0.65)
    coneShader:send('lightColor', {1.0, 0.9, 0.6})
    coneShader:send('direction', {0, 1.0})

    math.randomseed(os.time())
    blinkTimer = math.random(4, 6)  -- wait 4–6 sec for first blink

    for i = 1, #objects do
        objects[i].preload()
    end
end

function love.draw()
    love.graphics.setShader(coneShader)

    for i = 1, #objects do
        objects[i].render()
    end

    love.graphics.setShader()
end

function clamp(val, min, max)
    return math.max(min, math.min(val, max))
end

function love.update(dt)
    local w, h = love.graphics.getDimensions()
    local mx, my = love.mouse.getPosition()

    -- target position (normalized to 0..1)
    local targetX = clamp(mx / w, 0.4, 0.6)
    local targetY = clamp(my / h, 0.0, 0.08)

    -- smooth interpolation
    lightPos[1] = lightPos[1] + (targetX - lightPos[1]) * smoothSpeed * dt
    lightPos[2] = lightPos[2] + (targetY - lightPos[2]) * smoothSpeed * dt

    -- handle blinking
    if blinkDuration > 0 then
        blinkDuration = blinkDuration - dt
        if blinkDuration <= 0 then
            lampOn = true
            blinkTimer = math.random(2, 6)  -- reset next blink
        end
    else
        blinkTimer = blinkTimer - dt
        if blinkTimer <= 0 then
            lampOn = false
            blinkDuration = 0.1             -- quick off for 0.1s
        end
    end

    -- send shader position
    if not lampOn then
        coneShader:send('lightPosition', {2, 2}) -- off-screen
    else
        coneShader:send('lightPosition', lightPos)
    end
end
