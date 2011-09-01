require 'middleclass'
require 'imageentity'
require 'point'
require 'images'
require 'bomb'
require 'list'
require 'point'

SpaceShip = class('SpaceShip', ImageEntity)

function SpaceShip:initialize()
    SpaceShip.superclass.initialize(self, Point(20, 20), Images.SPACESHIP)

    self._speed = 3;
    self._target = self:getNewTarget()
    self._minFramesPerBomb = 10
    self._framesSinceLastBomb = 0
end

function SpaceShip:draw()
    Colors.WHITE:set()
    love.graphics.draw(self:getImage(), self:getX(), self:getY())
end

function SpaceShip:getNewTarget()
    return Point(math.random(20, love.graphics.getWidth() - self:getWidth()), math.random(20, 250))
end

function SpaceShip:update()
    local location = self:getLocation()
    local distance = Utils.getDistance(location, self._target)

    if (distance <= 5) then
        self._target = self:getNewTarget()
    end

    self:setLocation(Utils.translatePoint(location, Utils.getAngle(location, self._target), self._speed))


    if (math.random() < .035 and self._framesSinceLastBomb >= self._minFramesPerBomb) then
        self._framesSinceLastBomb = 0
        enemies:add(Bomb(Point(self:getX() + self:getWidth() / 2, self:getY() + self:getHeight() / 2)))
    end

    self._framesSinceLastBomb = self._framesSinceLastBomb  + 1
end