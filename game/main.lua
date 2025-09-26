require("utils")
local objects = {
    require("rtable"),
}

local blinkTimer
local lightPos = {0.5, 0.0}
local smoothSpeed = 2
local blinkDuration = 0
local lampOn = true

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    coneShader = love.graphics.newShader('gfx/cone.glsl')
    coneShader:send('lightPosition', lightPos)
    coneShader:send('coneAngle', 0.15)
    coneShader:send('softness', 0.07)
    coneShader:send('dropoff', 0.65)
    coneShader:send('lightColor', {1.0, 0.9, 0.6})
    coneShader:send('direction', {0, 1.0})

    math.randomseed(os.time())
    blinkTimer = math.random(4, 6)

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

function love.update(dt)
    local w, h = love.graphics.getDimensions()
    local mx, my = love.mouse.getPosition()

    local targetX = clamp(mx / w, 0.4, 0.6)
    local targetY = clamp(my / h, 0.0, 0.08)

    lightPos[1] = lightPos[1] + (targetX - lightPos[1]) * smoothSpeed * dt
    lightPos[2] = lightPos[2] + (targetY - lightPos[2]) * smoothSpeed * dt

    if blinkDuration > 0 then
        blinkDuration = blinkDuration - dt
        if blinkDuration <= 0 then
            lampOn = true
            blinkTimer = math.random(2, 6)
        end
    else
        blinkTimer = blinkTimer - dt
        if blinkTimer <= 0 then
            lampOn = false
            blinkDuration = math.random(0.1, 0.3)
        end
    end

    if not lampOn then
        coneShader:send('lightPosition', {2, 2})
    else
        coneShader:send('lightPosition', lightPos)
    end

    for i = 1, #objects do
        objects[i].update(dt)
    end
end
