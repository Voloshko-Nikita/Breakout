Ball = class{}

function Ball:init(skin, dx, dy)
    self.x = VIRTUAL_WIDTH/2 - 4
    self.y = VIRTUAL_HEIGHT - 70

    self.width = 8
    self.height = 8

    self.skin = skin

    self.dx = dx
    self.dy = dy
end
function Ball:collide(paddle)
    if self.x > paddle.x + paddle.width or self.x + 8< paddle.x then
        return false
    end
    if self.y > paddle.y + paddle.height or self.y + 8 < paddle.y then
        return false
    end
    return true
end
function Ball:update(dt)
    self.x = self.x + self.dx * dt
    --self.dy = self.dy + 40 * dt
    self.y = self.y + self.dy * dt

    if self.x < 0 then
        self.x = 0
        self.dx = -self.dx
        gSounds['wall_hit']:play()
    end
    if self.x > VIRTUAL_WIDTH-8 then
        self.x = VIRTUAL_WIDTH-8
        self.dx = -self.dx
        gSounds['wall_hit']:play()
    end
    if self.y < 0 then
        self.y = 0
        self.dy = -self.dy
        gSounds['wall_hit']:play()
    end
end
function Ball:render()
    love.graphics.draw(gTexture['main'], gFrames['balls'][self.skin],self.x, self.y)
end