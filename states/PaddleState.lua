PaddleState = class{__includes=BaseState}
change = true
function PaddleState:init()
    self.paddle = Paddle()
end

function PaddleState:update(dt)
    paddle:update(dt)
    if love.keyboard.wasPressed('space') then
        gStateMachine:change('service',{
            hearts = 3,
            score = 0,
            bricks = LevelMaker.createMap()
        })
        self.paddle.noChange()
    end
end
function PaddleState:render()
    love.graphics.setFont(gFonts["large"])
    love.graphics.draw(gTexture['arrows'], gFrames["arrows"][1],110, VIRTUAL_HEIGHT-60)
    love.graphics.draw(gTexture['arrows'], gFrames["arrows"][3],300, VIRTUAL_HEIGHT-60)
    love.graphics.printf("BREAKOUT", 3,VIRTUAL_HEIGHT/2-40, VIRTUAL_WIDTH, "center") 
    paddle:render()
end