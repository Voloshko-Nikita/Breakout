Brick = class{}

function Brick:init(x,y)
    self.tier = 0
    self.colour = 1

    self.x = x 
    self.y = y
    self.width = 30
    self.height = 16
    self.inPlay = true
end

function Brick:hit()
    gSounds['brick-hit-2']:play()
    self.inPlay = false
end

function Brick:render()
    if self.inPlay then
        love.graphics.draw(gTexture['main'], gFrames['bricks'][self.colour + self.tier], self.x,self.y)
    end
    
end