require 'middleclass'
require 'imageentity'
require 'images'
require 'streak'
require 'list'
require 'colors'

Missile = class('Missile', ImageEntity)

function Missile:initialize(point, target, speed)
    Missile.superclass.initialize(self, point, Images.MISSILE)

    self._target = target
    self._speed = speed 
    self._streaks = List:new()
    self._rotation = 0
end

function Missile:update()
    local dx = (self._target:getX() + self._target:getWidth() / 2) - (self:getX() + self:getWidth() / 2)
    local dy = self._target:getY() + self._target:getHeight() / 2 - self:getY()

    self._rotation = math.atan2(dy, dx)

    self._streaks:add(Streak(self:getLocation()))

    self:setLocation(self:getX() + math.cos(self._rotation) * self._speed,
                     self:getY() + math.sin(self._rotation) * self._speed)
    
    if (self:getY() <= self._target:getY() + self._target:getHeight()) then
        self:setAlive(false)
        self._target:setAlive(false)
    end
    
    self:updateEntities(self._streaks)
end

function Missile:draw()
    self:drawEntities(self._streaks)

    Colors.WHITE:set()
    love.graphics.draw(self:getImage(), self:getX(), self:getY(), self._rotation + math.pi / 2, 1, 1, self:getWidth() / 2)
end
