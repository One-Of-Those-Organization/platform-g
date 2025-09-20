local deskCanvas
local deskScale = 12
local deskMesh
local deskTexture
local deskPolygon

-- How many times to repeat texture across trapezoid
local repeatX, repeatY = 1, 1

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    local w,h = love.graphics.getDimensions()
    deskCanvas = love.graphics.newCanvas(math.floor(w/deskScale), math.floor(h/deskScale))

    -- Load texture (your wood grain image)
    deskTexture = love.graphics.newImage("desk_texture2.jpg")
    deskTexture:setWrap("repeat", "repeat")


    local cw, ch = deskCanvas:getDimensions()
    local desk_perspective = math.floor(cw * 0.10)

    -- trapezoid corners with repeated UVs
    -- local desk = {
    --     {desk_perspective,      ch - ch/2.5,  0,        0},        -- top-left
    --     {cw - desk_perspective, ch - ch/2.5,  repeatX,  0},        -- top-right
    --     {cw,                    ch,           repeatX,  repeatY},  -- bottom-right
    --     {0,                     ch,           0,        repeatY},  -- bottom-left
    -- }

    local desk = {
        { desk_perspective,      ch - ch/2.5, repeatX,  0 },        -- top-left
        { cw - desk_perspective, ch - ch/2.5, repeatX,  repeatY },  -- top-right
        { cw,                    ch,          0,        repeatY },  -- bottom-right
        { 0,                     ch,          0,        0 },        -- bottom-left
    }


    deskMesh = love.graphics.newMesh(desk, "fan", "static")
    deskMesh:setTexture(deskTexture)

    deskPolygon = {
        desk[1][1], desk[1][2], -- top-left
        desk[2][1], desk[2][2], -- top-right
        desk[3][1], desk[3][2], -- bottom-right
        desk[4][1], desk[4][2], -- bottom-left
    }
end

function love.draw()
    local g = love.graphics
    local cw, ch = deskCanvas:getDimensions()

    g.setCanvas(deskCanvas)
    g.clear(0,0,0,0)

    g.setColor(1,1,1)
    g.draw(deskMesh, cw/2, ch/2, 0, 1, 1, cw/2, ch/2)

    g.setLineWidth(1)
    g.setColor(0.1,0.1,0.1) -- black bezel/outline
    g.polygon("line", deskPolygon)

    g.setCanvas()

    g.setColor(1,1,1)
    g.draw(deskCanvas, 0, 0, 0, deskScale, deskScale)
end

