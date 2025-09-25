local M = {}

function M.preload()
    local deskScale = 12
    local repeatX, repeatY = 1, 1
    local w,h = love.graphics.getDimensions()

    M.deskScale = deskScale

    M.deskCanvas = love.graphics.newCanvas(math.floor(w/deskScale), math.floor(h/deskScale))

    M.deskTexture = love.graphics.newImage("gfx/desk_texture.jpg")
    M.deskTexture:setWrap("repeat", "repeat")

    local cw, ch = M.deskCanvas:getDimensions()
    local desk_perspective = math.floor(cw * 0.15)

    local top_vertex = ch - ch / 2.5
    M.desk = {
        {desk_perspective,      top_vertex,  0,        0},
        {cw - desk_perspective, top_vertex,  repeatX,  0},
        {cw,                    ch,          repeatX,  repeatY},
        {0,                     ch,          0,        repeatY},
    }

    M.deskMesh = love.graphics.newMesh(M.desk, "fan", "static")
    M.deskMesh:setTexture(M.deskTexture)
end

function M.render()
    local g = love.graphics
    local cw, ch = M.deskCanvas:getDimensions()

    g.setCanvas(M.deskCanvas)
    g.clear(0,0,0,0)

    g.setColor(1,1,1)
    g.draw(M.deskMesh, cw/2, ch/2, 0, 1, 1, cw/2, ch/2)

    g.setCanvas()

    g.setColor(1,1,1)
    g.draw(M.deskCanvas, 0, 0, 0, M.deskScale, M.deskScale)
end

return M
