require("utils")
gs = require("state")

local objects = {
    require("rtable"),
}

local currentState = gs.state.Menu
local lc = require("conelight")

function love.load()
    lc.preload()
    love.graphics.setDefaultFilter("nearest", "nearest")
    for i = 1, #objects do
        objects[i].preload()
    end
end

function love.draw()
    love.graphics.setShader(lc.coneShader)

    for i = 1, #objects do
        for j = 1, #objects[i].activeAt do
            if objects[i] ~= nil and currentState == objects[i].activeAt[j] then
                objects[i].render()
                break
            end
        end
    end

    love.graphics.setShader()
end

function love.update(dt)
    lc.update(dt)
    for i = 1, #objects do
        for j = 1, #objects[i].activeAt do
            if objects[i] ~= nil and currentState == objects[i].activeAt[j] then
                objects[i].update(dt)
                break
            end
        end
    end
end
