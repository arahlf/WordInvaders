require 'gamestatemanager'
require 'game'
require 'intro'
require 'gameover'
require 'fonts'

function love.load()
    love.graphics.setCaption('Word Invaders')

    math.randomseed(os.time());
    math.random() math.random() math.random()

    love.graphics.setBackgroundColor(255, 255, 255)

    GameStateManager:init()
    GameStateManager:switch(intro)
end

function love.keypressed(key, unicode)
    if (key == 'w' and love.keyboard.isDown('lctrl')) then
        love.event.push('q') -- quit the game
    end
end
