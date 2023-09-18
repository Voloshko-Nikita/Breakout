require 'scr.Dependencies'
paddle = Paddle()
function love.load()
    
    -- set the application title bar
    love.window.setTitle('Breakout')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    gFonts = {
    ["small"] = love.graphics.newFont("fonts/font.ttf", 8),
    ["medium"] = love.graphics.newFont("fonts/font.ttf", 16),
    ["large"] = love.graphics.newFont("fonts/font.ttf", 32)
    }

    gTexture = {
    ["background"] = love.graphics.newImage("graphics/background.png"),
    ["main"] = love.graphics.newImage("graphics/breakout.png"),
    ["hearts"] = love.graphics.newImage("graphics/hearts.png"),
    ["arrows"] = love.graphics.newImage("graphics/arrows.png"),
    }

    gFrames = {
        ['paddles'] = GenerateQuadsPaddle(gTexture['main']),
        ['balls'] = GenerateQuadsBalls(gTexture['main']),
        ['bricks'] = GenerateQuadsBricks(gTexture['main']),
        ['hearts'] = GenerateQuadsHearts(gTexture['hearts']),
        ['arrows'] = GenerateQuadsArrows(gTexture['arrows']),
    }

    gSounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
        ['confirm'] = love.audio.newSource('sounds/confirm.wav', 'static'),
        ['no-select'] = love.audio.newSource('sounds/no-select.wav', 'static'),
        ['brick-hit-1'] = love.audio.newSource('sounds/brick-hit-1.wav', 'static'),
        ['brick-hit-2'] = love.audio.newSource('sounds/brick-hit-2.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['victory'] = love.audio.newSource('sounds/victory.wav', 'static'),
        ['recover'] = love.audio.newSource('sounds/recover.wav', 'static'),
        ['high_score'] = love.audio.newSource('sounds/high_score.wav', 'static'),
        ['pause'] = love.audio.newSource('sounds/pause.wav', 'static'),

        ['music'] = love.audio.newSource('sounds/music.wav', 'stream'),
    }

    love.graphics.setFont(gFonts["small"])
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {vsync = true,resizable = true,fullscreeen = false
    })

    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['paddle'] = function() return PaddleState() end,
        ['service'] = function() return ServiceState() end,
        ['play'] = function() return PlayState() end,
        ['over'] = function() return GameOver() end,
    }
    gStateMachine:change('start')
    love.keyboard.keysPressed = {}
end

function love.update(dt)
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    if key == 'escape' then
        love.event.quit()
    end
end
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    end
    return false
end



function love.draw()
    local backgroundWidth = gTexture["background"]:getWidth()
    local backgroundHigh = gTexture["background"]:getHeight()
    push:apply("start")
    love.graphics.draw(gTexture["background"],0,0,0, VIRTUAL_WIDTH/(backgroundWidth-1), VIRTUAL_HEIGHT/(backgroundHigh-1))
    gStateMachine:render()
    push:apply("end")
end

