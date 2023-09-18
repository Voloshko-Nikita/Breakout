StartState = class{__includes=BaseState}
local highlighted = 1
local color = {
    ["blue"] = {0,1,1, 1},
    ["white"] = {1,1,1,1}
}

function StartState:init()
end

function StartState:update(dt)
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = highlighted == 1 and 2 or 1
        gSounds['paddle_hit']:play()
    end  
    if love.keyboard.wasPressed('space') then
        if highlighted == 1 then
            gStateMachine:change('paddle')
        end
    end
end

function StartState:render()
    love.graphics.setFont(gFonts["large"])
    love.graphics.printf("BREAKOUT", 3,VIRTUAL_HEIGHT/2-40, VIRTUAL_WIDTH, "center") 
    love.graphics.setFont(gFonts["small"])
    if highlighted == 1 then
        love.graphics.setColor(color["blue"])
    end
    love.graphics.printf("Start", 0, VIRTUAL_HEIGHT/12*9, VIRTUAL_WIDTH, "center") 
    love.graphics.setColor(color["white"])
    if highlighted == 2 then
        love.graphics.setColor(color["blue"])
    end
    love.graphics.printf("Highst Score", 0, VIRTUAL_HEIGHT/12*10, VIRTUAL_WIDTH, "center") 
    love.graphics.setColor(color["white"])
end