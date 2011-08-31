require 'middleclass'
require 'imageentity'
require 'images'

Bomb = class('Bomb', ImageEntity)

function Bomb:initialize(point)
    Bomb.superclass.initialize(self, point, Images.BOMB)

    self._speed = 1
    self._char = string.char(math.random(97, 122))
end

function Bomb:update()
    self:moveY(self._speed)

    if (self:getY() > love.graphics.getHeight() + self:getHeight()) then
        self:setAlive(false)
    end
end

function Bomb:draw()
    Colors.WHITE:set()
    Fonts.DEFAULT:set()
    love.graphics.draw(self:getImage(), self:getX(), self:getY(), 0, 1, 1, self:getWidth() / 2, self:getHeight() / 2)

    local font = love.graphics.getFont()

    love.graphics.setColor(0, 0, 0)
    love.graphics.print(self._char, self:getX() - font:getWidth(self._char) / 2, self:getY() - font:getHeight(self._char) / 2)
end