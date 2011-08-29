require 'middleclass'
require 'imageentity'
require 'images'

Bomb = class('Bomb', ImageEntity)

function Bomb:initialize(point)
    Bomb.superclass.initialize(self, point, Images.BOMB)

    self._speed = 2
    self._char = string.char(math.random(65, 90))
end

function Bomb:update()
    self:moveY(self._speed)

    if (self:getY() > love.graphics.getHeight() + self:getHeight()) then
        self:setAlive(false)
    end
end

function Bomb:draw()
    Colors.WHITE:set()
    love.graphics.draw(self:getImage(), self:getX(), self:getY())

    love.graphics.setColor(0, 0, 0)
    love.graphics.print(self._char, self:getX() + 7, self:getY() + 4)
end