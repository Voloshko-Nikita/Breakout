LevelMaker = class{}



function LevelMaker:createMap()

    local rowNum = math.random(3,5)
    local colNum = math.random(7,13)
    local bricks = {}

    for y = 1, rowNum do
        for x = 1, colNum do
            b = Brick(
                    (x-1)*32
                    + 8
                    + (13 - colNum) * 16,
                    y*16)

            table.insert(bricks,b)
        end
    end 

    return bricks
end
