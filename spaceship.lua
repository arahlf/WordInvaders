require 'middleclass'
require 'imageentity'
require 'point'
require 'images'
require 'bomb'
require 'list'
require 'point'

SpaceShip = class('SpaceShip', ImageEntity)

function SpaceShip:initialize()
    SpaceShip.superclass.initialize(self, Point(200, 20), Images.SPACESHIP)

    self._speed = 4;
    self._target = self:getNewTarget()
    self._minFramesPerBomb = 10
    self._framesSinceLastBomb = 0
    self._fired = false
end

function SpaceShip:draw()
    Colors.WHITE:set()
    love.graphics.draw(self:getImage(), self:getX(), self:getY())
end

function SpaceShip:getNewTarget()
    return Point(math.random(0, love.graphics.getWidth() - self:getWidth()), 0)
end

function SpaceShip:update()
    if (self:getX() == self._target:getX()) then
        self._target = self:getNewTarget()
    end

    local distance = self._target:getX() - self:getX()
    local sign = distance > 0 and 1 or -1

    self:moveX( (math.abs(distance) > self._speed and self._speed or math.abs(distance)) * sign )

    if (math.random() < .05 and self._framesSinceLastBomb >= self._minFramesPerBomb) then
        self._framesSinceLastBomb = 0
        self._fired = true
        enemies:add(Bomb(Point(self:getX() + self:getWidth() / 2, self:getY() + self:getHeight() / 2)))
    end

    self._framesSinceLastBomb = self._framesSinceLastBomb  + 1
end