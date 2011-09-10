require 'gamestate'
require 'gamestatemanager'
require 'game'
require 'colors'
require 'fonts'

intro = GameState()

local message = 'Press spacebar to continue.'

function intro:update(dt)

end

function intro:draw()
    Colors.BLACK:set()
    Fonts.INTRO:set()

    local font = love.graphics.getFont()
    local xPos = (love.graphics.getWidth() - font:getWidth(message)) / 2
    local yPos = (love.graphics.getHeight() - font:getHeight(message)) / 2

    love.graphics.print(message, xPos, yPos)
end

function intro:keypressed(key, unicode)
    if (key == ' ') then
        GameStateManager:switch(game)
    end
end