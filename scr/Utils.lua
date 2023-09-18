
--Generate quads

function GenerateQuads(atlas, titleWidth, titleHeight)
    local sheetWidth = atlas:getWidth() / titleWidth
    local sheetHeight = atlas:getHeight() / titleHeight

    local counter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[counter] = 
            love.graphics.newQuad(x * titleWidth, y * titleHeight, titleWidth, titleHeight,
            atlas:getDimensions()
        )
        counter = counter + 1
        end
    end
    return spritesheet
end

function TblSlice(tbl,first,last,step)
    local sliced = {}

    for i = first or 1, last or #tbl, step or 1 do
        sliced[#sliced+1] = tbl[i]
    end
    return sliced
end

function GenerateQuadsPaddle(atlas)
    local counter = 0
    local paddleQuads = {}
    local x = 0
    local y = 64

    for i = 1, 4 do
        --small
        paddleQuads[counter] = love.graphics.newQuad(x, y, 32, 16, atlas:getDimensions())
        counter = counter + 1
        
        --medium
        paddleQuads[counter] = love.graphics.newQuad(x+32, y, 64, 16, atlas:getDimensions())
        counter = counter + 1
        
        --large
        paddleQuads[counter] = love.graphics.newQuad(x+96, y, 96, 16, atlas:getDimensions())
        counter = counter + 1

        
        --XL
        paddleQuads[counter] = love.graphics.newQuad(x, y+16, 128, 16, atlas:getDimensions())
            counter = counter + 1
        x = 0
        y = y + 32
    end
    return paddleQuads
end

function GenerateQuadsBricks(atlas)
    return TblSlice(GenerateQuads(atlas,32,16), 1, 21)

end

function GenerateQuadsBalls(atlas)
    local counter = 0
    local ballQuads = {}
    local x = 96
    local y = 48
    for i = 1, 7 do
        ballQuads[counter] = love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions())
        counter = counter + 1
        x = x + 8
        if i == 4 then
            x = 96
            y = 64
        end
    end
    return ballQuads    
end

function GenerateQuadsHearts(atlas)
    local counter = 0
    local heartQuads = {}
    local x = 0
    for i = 1, 2 do
        heartQuads[counter] = love.graphics.newQuad(x, 0, 10, 8, atlas:getDimensions())
        x = x + 10
        counter = counter + 1
    end  
    return heartQuads
end

function GenerateQuadsArrows(atlas)
    local counter = 0
    local arrows = {}
    local x = 0
    for i = 1, 2 do
        arrows[i] = love.graphics.newQuad(x, 0, x + 24, 24, atlas:getDimensions())
        x = x + 24
    end
    arrows[3] = love.graphics.newQuad(x-24, 0, x-24, 24, atlas:getDimensions())

    return arrows
end