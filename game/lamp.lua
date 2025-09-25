local M = {}

function M.preload()
    M.scale = 24
    M.texture = love.graphics.newImage("gfx/lamp.png")

    local w, h = love.graphics.getDimensions()
    M.canvas = love.graphics.newCanvas(math.floor(w / M.scale), math.floor(h / M.scale))
    M.canvas:setFilter("nearest", "nearest") -- prevent smoothing

    local cw, ch = M.canvas:getDimensions()
    local w, h = love.graphics.getDimensions()
    local tw, th = M.texture:getDimensions()

    M.rec = {
        x = w * .25,
        y = -160,
        w = M.scale /2,
        h = 12
    }
end

function M.render()
    local g = love.graphics
    local cw, ch = M.canvas:getDimensions()
    local w, h = g.getDimensions()
    local tw, th = M.texture:getDimensions()
    local scale = 1

    g.setCanvas(M.canvas)
        g.clear()
        g.draw(M.texture, 0, 0, 0, cw / tw, ch / th)
    g.setCanvas()

    g.draw(M.canvas, w * .25, -160, 0, M.scale /2, 12)
end

return M
