local objects = {
    require("rtable"),
    require("lamp"),
}

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    coneShader = love.graphics.newShader('gfx/cone.glsl')
    coneShader:send('lightPosition', {0.5, 0.0})   -- Light starts at top center
    coneShader:send('coneAngle', 0.3)              -- Narrow cone (about 60 degrees)
    coneShader:send('softness', 0.1)               -- Soft edges
    coneShader:send('dropoff', 0.8)                -- Light falloff
    coneShader:send('lightColor', {1.0, 0.9, 0.7}) -- Warm light color

    for i = 1, #objects do
        objects[i].preload()
    end
end

function love.draw()
    -- Start using the shader
    love.graphics.setShader(coneShader)

    -- Draw your objects
    for i = 1, #objects do
        objects[i].render()
    end

    -- Stop using the shader
    love.graphics.setShader()
end

-- Optional: Update light position based on mouse
function love.update(dt)
    local w, h = love.graphics.getDimensions()
    local mx, my = love.mouse.getPosition()
    coneShader:send('lightPosition', {mx/w, my/h})
end
