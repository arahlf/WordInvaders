require 'middleclass'
require 'imageentity'
require 'point'
require 'images'
require 'bomb'
require 'list'
require 'point'
require 'fonts'
require 'threat'
require 'interface'
require 'enemy'

SpaceShip = class('SpaceShip', ImageEntity)

function SpaceShip:initialize()
    SpaceShip.superclass.initialize(self, Point(20, 20), Images.SPACESHIP)

    self._speed = 3;
    self._target = self:getNewTarget()
    self._minFramesPerBomb = 10
    self._lastDrop = os.time() - 1
    self._word = 'buddy'
end

function SpaceShip:draw()
    Colors.WHITE:set()
    Fonts.DEFAULT:set()
    love.graphics.draw(self:getImage(), self:getX(), self:getY())

    local font = love.graphics.getFont()
    local fontXOffset = (self:getWidth() - font:getWidth(self._word)) / 2

    Colors.BLACK:set()
    love.graphics.print(self._word, self:getX() + fontXOffset, self:getY() + 17)
end

function SpaceShip:getNewTarget()
    return Point(math.random(20, love.graphics.getWidth() - self:getWidth()), math.random(20, 100))
end

function SpaceShip:update()
    local location = self:getLocation()
    local distance = Utils.getDistance(location, self._target)

    if (distance <= 5) then
        self._target = self:getNewTarget()
    end

    self:setLocation(Utils.translatePoint(location, Utils.getAngle(location, self._target), self._speed))

    local time = os.time()

    if (time > self._lastDrop + 1) then
        self._lastDrop = time
        local bomb = Bomb(Point(self:getX() + self:getWidth() / 2, self:getY() + self:getHeight()), turrets[math.random(1, #turrets)])
        enemies:add(bomb)
    end
end

function SpaceShip:focus()
    self:setImage(Images.SPACESHIP_FOCUSED)
end

function SpaceShip:unfocus()
    self:setImage(Images.SPACESHIP)
end

function SpaceShip:getThreatLevel()
    return Threat.MINOR
end

function SpaceShip:getWordLength()
    if (self._word == nil) then
        return 0
    end

    return #self._word
end

function SpaceShip:getNextLetter()
    return self._word:sub(1, 1)
end

function SpaceShip:removeNextLetter()
    self._word = self._word:sub(2)
end

Interface.implement(SpaceShip, Enemy)