require 'gamestate'
require 'fonts'

gameover = GameState()

function gameover:draw()
    Colors.BLACK:set()
    Fonts.HEADING:set()

    local font = love.graphics.getFont()
    local message = 'GAME OVER'
    local scoreText = 'Score: ' .. game.score
    local xPos = (love.graphics.getWidth() - font:getWidth(message)) / 2
    local yPos = (love.graphics.getHeight() - font:getHeight(message)) / 2

    love.graphics.print('GAME OVER', xPos, yPos - 25)

    xPos = (love.graphics.getWidth() - font:getWidth(scoreText)) / 2

    love.graphics.print(scoreText, xPos, yPos + 25)
end