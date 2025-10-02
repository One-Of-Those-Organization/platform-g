require("utils")
gs = require("state")

local objects = {
    require("rtable"), -- this behave like z-index so be warry
}

local currentState = gs.state.Menu
local lc = require("conelight")

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    lc.preload()
    for i = 1, #objects do
        objects[i].preload()
    end
end

function love.draw()
    for i = 1, #objects do
        local ao = objects[i]
        for j = 1, #ao.activeAt do
            if ao ~= nil and currentState == ao.activeAt[j] then
                ao.prerender() -- for obj that have diff pipeline that need other shaders
                               -- before the lightcone shaders
                if ao.ConeLightEffect == true then
                    love.graphics.setShader(lc.coneShader)
                        ao.render()
                    love.graphics.setShader()
                else
                    ao.render()
                end
                break
            end
        end
    end
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
