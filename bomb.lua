require 'middleclass'
require 'imageentity'
require 'images'
require 'threat'
require 'utils'
require 'interface'
require 'enemy'

Bomb = class('Bomb', ImageEntity)

function Bomb:initialize(point, target)
    Bomb.superclass.initialize(self, point, Images.BOMB)

    self._speed = 2
    self._target = target
    self._letter = string.char(math.random(97, 122))
end

function Bomb:update()
    self:setLocation(Utils.moveTowards(self:getLocation(), self._target:getLocation(), self._speed))

    if (Utils.getDistance(self:getLocation(), self._target:getLocation()) <= 50) then
        self:setAlive(false)
        game:removeEnemy(self)
        game.missed = game.missed + 1
    end
end

function Bomb:draw()
    Colors.WHITE:set()
    Fonts.DEFAULT:set()
    love.graphics.draw(self:getImage(), self:getX(), self:getY(), 0, 1, 1, self:getWidth() / 2, self:getHeight() / 2)

    if (self._letter ~= nil) then
        local font = love.graphics.getFont()

        love.graphics.setColor(0, 0, 0)
        love.graphics.print(self._letter, (self:getX() - font:getWidth(self._letter) / 2) -1, (self:getY() - font:getHeight(self._letter) / 2) - 1)
    end
end

function Bomb:focus()
end

function Bomb:unfocus()
end

function Bomb:getThreatLevel()
    return Threat.MAJOR
end

function Bomb:getWordLength()
    return self._letter ~= nil and 1 or 0
end

function Bomb:getNextLetter()
    return self._letter
end

function Bomb:removeNextLetter()
    self._letter = nil
end

Interface.implement(Bomb, Enemy)