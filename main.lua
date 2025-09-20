local deskCanvas
local deskScale = 8

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    local w,h = love.graphics.getDimensions()
    deskCanvas = love.graphics.newCanvas(math.floor(w/deskScale), math.floor(h/deskScale))
end

function love.draw()
    local g = love.graphics
    local w,h = g.getDimensions()
    local cw, ch = deskCanvas:getDimensions()

    local desk_perspective = math.floor(cw * 0.10)

    local desk = {
        desk_perspective,      ch - ch/2.5,  -- top-left
        cw - desk_perspective, ch - ch/2.5,  -- top-right
        cw,                    ch,         -- bottom-right
        0,                     ch          -- bottom-left
    }

    g.setCanvas(deskCanvas)
    g.clear(0,0,0,0)
    g.setColor(1,1,1)
    g.polygon("fill", desk)
    g.setColor(0.2,0.2,0.2)
    g.polygon("line", desk)
    g.setCanvas()

    g.setColor(1,1,1)
    g.draw(deskCanvas, 0, 0, 0, deskScale, deskScale)

    g.setColor(1,1,1)
end
