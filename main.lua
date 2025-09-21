local objects = {
    require("rtable"),
}

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    local w,h = love.graphics.getDimensions()
    fadeOut = love.graphics.newShader("fade-out.glsl")

    for i = 1, #objects do
        objects[i].preload(fadeOut)
    end
end

function love.draw()
    for i = 1, #objects do
        objects[i].render()
    end
end
