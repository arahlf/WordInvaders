require 'middleclass'
require 'imageentity'
require 'images'
require 'streak'
require 'list'
require 'colors'
require 'utils'

Missile = class('Missile', ImageEntity)

function Missile:initialize(point, target, speed)
    Missile.superclass.initialize(self, point, Images.MISSILE)

    self._target = target
    self._acceleration = 0
    self._speed = speed
    self._streaks = List:new()
    self._rotation = math.rad(-90)
    self._launchDistance = 20
    self._startY = self:getY()
end

function Missile:update()
    self._streaks:add(Streak(Point(self:getX() - math.cos(self._rotation * 50), self:getY() - math.sin(self._rotation * 50))))

    if (self._acceleration <= 1) then
        self._acceleration = self._acceleration + .05
    end

    if (math.abs(self:getY() - self._startY) > self._launchDistance) then
        self._rotation = Utils.getAngle(self:getCenter(), self._target:getCenter())
    end

    self:setLocation(Utils.translatePoint(self:getLocation(), self._rotation, self._acceleration * self._speed))
    
    if (Utils.hitTest(self, self._target)) then
        self:setAlive(false)
        self._target:setAlive(false)
        game:removeEnemy(self._target)
    end
    
    self:updateEntities(self._streaks)
end

function Missile:draw()
    self:drawEntities(self._streaks)

    Colors.WHITE:set()
    love.graphics.draw(self:getImage(), self:getX(), self:getY(), self._rotation, 1, 1, self:getWidth() / 2, self:getHeight() / 2)
end
