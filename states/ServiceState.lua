ServiceState = class{__includes=BaseState}

function ServiceState:enter(param)
    self.score = param.score
    self.hearts = param.hearts
    self.bricks = param.bricks

    self.paddle = Paddle()
    self.ball = Ball(3)
end

function ServiceState:update(dt)
    if self.hearts == 0 then
        gStateMachine:change('over', {score = self.score})
    end
    if love.keyboard.wasPressed('space') then
        gStateMachine:change('play',{
            hearts = self.hearts,
            score = self.score,
            bricks = self.bricks
        })
    end
end
function ServiceState:render()
    love.graphics.setFont(gFonts["small"])
    love.graphics.printf("serve", 3,40, VIRTUAL_WIDTH, "center") 
    local heartsX = VIRTUAL_WIDTH-60
    for i = 1, self.hearts do
        love.graphics.draw(gTexture['hearts'], gFrames["hearts"][0],heartsX, 5)
        heartsX = heartsX + 10
    end
    for i = 1, 3-self.hearts do
        love.graphics.draw(gTexture['hearts'], gFrames["hearts"][1],heartsX, 5)
        heartsX = heartsX + 10
    end
    self.paddle:render()
    self.ball:render()
end