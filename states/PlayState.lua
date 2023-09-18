PlayState = class{__includes=BaseState}

function PlayState:enter(param)
    self.score = param.score
    self.hearts = param.hearts
    self.bricks = param.bricks
    self.pause = false
    self.can_collide = true
    self.paddle = Paddle()
    self.ball = Ball(3,love.math.random(-200, 200),love.math.random(-40,-70))
end

function PlayState:update(dt)
    -- update positions based on velocity
    if self.pause==false then
        self.paddle:update(dt)
        self.ball:update(dt)
        if self.ball:collide(self.paddle) then
            self.fromCenter = (self.paddle.x + self.paddle.width/2) - self.ball.x
            if self.ball.dx > 0 and self.fromCenter > 0 then
                self.ball.dx = self.ball.dx
            elseif self.ball.dx < 0 and self.fromCenter < 0 then
                self.ball.dx = self.ball.dx
            else
                self.ball.dx = -self.fromCenter * 160 / self.paddle.width
            end
            if self.ball.x < self.paddle.x and self.ball.dx > 0 and self.ball.y + 8 < self.paddle.y+16 then
                self.ball.x = self.paddle.x - 8
                self.ball.y = self.paddle.y - 9
                self.ball.dy = - self.ball.dy * 1.01
                if self.ball.dx > 0 then
                    self.ball.dx = -self.ball.dx
                end
            elseif self.ball.x + 8  > self.paddle.x + self.paddle.width and self.ball.y + 8 < self.paddle.y+16 then
                self.ball.x = self.paddle.x + self.paddle.width
                self.ball.y = self.paddle.y - 9
                self.ball.dy = - self.ball.dy * 1.01
                if self.ball.dx < 0 then
                    self.ball.dx = -self.ball.dx
                end
          
            self.can_collide = false
            elseif self.ball.y < self.paddle.y then
                self.ball.y = self.paddle.y - 8
                self.ball.dy = - self.ball.dy * 1.01
            end
            
            
            gSounds['paddle_hit']:play()
        end
        if self.ball.y > VIRTUAL_HEIGHT then
            gStateMachine:change('service',{
                hearts = self.hearts - 1,
                score = self.score,
                bricks = self.bricks
            })
        end


        for k, brick in pairs(self.bricks) do
            if brick.inPlay and self.ball:collide(brick) then
                self.can_collide = true
                self.score = self.score + (brick.tier + 1) * 10
                brick:hit()
                -- top edge if no X collisions, always check
                if self.ball.y < brick.y  and self.ball.x+6 > brick.x and self.ball.x + 4 < brick.x + brick.width then           
                    -- flip y velocity and reset position outside of brick
                    self.ball.dy = -self.ball.dy
                    self.ball.y = brick.y - 8
                
                -- bottom edge if no X collisions or top collision, last possibility
                elseif self.ball.y + 2 > brick.y + 16 and self.ball.x+6 > brick.x and self.ball.x + 4 < brick.x + brick.width then
                    -- flip y velocity and reset position outside of brick
                    self.ball.dy = -self.ball.dy
                    self.ball.y = brick.y + 16

                --left side collision
                elseif self.ball.x+2 < brick.x and self.ball.dx > 0 and self.ball.y+8 > brick.y and self.ball.y < brick.y + 16 then
                    
                    -- flip x velocity and reset position outside of brick
                    self.ball.dx = -self.ball.dx
                    self.ball.x = brick.x - 8
                
                -- right edge; only check if we're moving left
                elseif self.ball.x + 6 > brick.x + brick.width and self.ball.dx < 0 and self.ball.y+8 > brick.y and self.ball.y < brick.y + 16 then
                    
                    -- flip x velocity and reset position outside of brick
                    self.ball.dx = -self.ball.dx
                    self.ball.x = brick.x + 32
                
                
                end
                self.ball.dy = self.ball.dy * 1.01
                break
            end
        end
        if love.keyboard.wasPressed('space') then
            self.pause = true
        end
    else
        if love.keyboard.wasPressed('space') then
            self.pause = false
        end
    end
end
function PlayState:render()
    love.graphics.setFont(gFonts["small"])
    love.graphics.print(tostring(self.score), 10, 10) 
    self.paddle:render()
    self.ball:render()
    for k, brick in pairs(self.bricks) do
        brick:render()
    end
    local heartsX = VIRTUAL_WIDTH-60
    for i = 1, self.hearts do
        love.graphics.draw(gTexture['hearts'], gFrames["hearts"][0],heartsX, 5)
        heartsX = heartsX + 10
    end
    for i = 1, 3-self.hearts do
        love.graphics.draw(gTexture['hearts'], gFrames["hearts"][1],heartsX, 5)
        heartsX = heartsX + 10
    end
end