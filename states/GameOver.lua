GameOver = class{__includes=BaseState}
function GameOver:enter(param)
    self.score = param.score
end

function GameOver:update(dt)
    if love.keyboard.wasPressed("space") then
        gStateMachine:change('start')
    end
end

function GameOver:render()
    love.graphics.setFont(gFonts["large"])
    love.graphics.printf("Game Over",0,VIRTUAL_HEIGHT/2-40,VIRTUAL_WIDTH,"center")    
    love.graphics.setFont(gFonts["medium"])
    local score = "your score: " .. tostring(self.score)
    love.graphics.printf(score,0,VIRTUAL_HEIGHT/2,VIRTUAL_WIDTH,"center") 
end