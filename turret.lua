require 'middleclass'
require 'imageentity'
require 'missilefactory'
require 'images'
require 'list'
require 'point'

Turret = class('Turret', ImageEntity)

function Turret:initialize(point)
    Turret.superclass.initialize(self, point, Images.TURRET)

    self._missiles = List:new()
    self._missileFactory = MissileFactory(Point(self:getX(), self:getY() - self:getHeight()))
end

function Turret:fireMissile(target)
    self._missiles:add(self._missileFactory:create(target))
end

function Turret:update()
    local iterator = self._missiles:iterator()

    while(iterator:hasNext()) do
        local missile = iterator:next()

        if (missile:isAlive()) then
            missile:update()
        else
            iterator:remove()
        end
    end
end

function Turret:draw()
    for i, missile in ipairs(self._missiles:getTable()) do
        missile:draw()
    end

    Colors.WHITE:set()
    love.graphics.draw(self:getImage(), self:getX(), self:getY(), 0, 1, 1, self:getWidth() / 2, self:getHeight())
end