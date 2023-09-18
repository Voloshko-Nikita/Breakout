Paddle = class{}

function Paddle:init()
    --velosity
    self.dx = 0

    --size
    self.size = paddle_size or 1

    --skin
    self.skin = paddle_skin or 1

    --starting dimentions
    self.width = (self.size+1)*32
    self.height = 16

    self.x = (VIRTUAL_WIDTH/2 - (self.size+1)*16)
    self.y = (VIRTUAL_HEIGHT - 55)
end

function Paddle:update(dt)
    if change == false then
        if love.keyboard.isDown('left') then
            self.dx = -PADDLE_SPEED
        elseif love.keyboard.isDown('right') then
            self.dx = PADDLE_SPEED
        else
            self.dx = 0
        end
        -- Check Borders
        if self.dx < 0 then
            self.x = math.max(self.x + self.dx *dt, 0)
        end
        
        if self.dx > 0 then
            self.x = math.min(self.x + self.dx * dt, VIRTUAL_WIDTH - self.width)
        end
    end

    --size and colour
    if change == true then
        if love.keyboard.wasPressed('up') then
            if self.size < 3 then
                self.size = self.size + 1
                self.width = self.width + 32
                gSounds['paddle_hit']:play()
            else
                gSounds['no-select']:play()
            end
        elseif love.keyboard.wasPressed('down') then
            if self.size > 0 then
                self.size = self.size - 1
                self.width = self.width - 32
                gSounds['paddle_hit']:play()
            else
                gSounds['no-select']:play()
            end
        elseif love.keyboard.wasPressed('left') then
            if self.skin < 3 then
                self.skin = self.skin + 1
                gSounds['paddle_hit']:play()
            else
                gSounds['no-select']:play()
            end
        elseif love.keyboard.wasPressed('right') then
            if self.skin > 0 then
                self.skin = self.skin - 1
                gSounds['paddle_hit']:play()
            else
                gSounds['no-select']:play()
            end
        end
        paddle_size = self.size
        paddle_skin = self.skin
        self.x = (VIRTUAL_WIDTH/2 - (self.size+1)*16)
    end
end

function Paddle:render()
    love.graphics.draw(gTexture['main'],gFrames['paddles'][4*self.skin + self.size], self.x, self.y)
end

function Paddle:noChange()
    change = false
end