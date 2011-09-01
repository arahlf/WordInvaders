require 'middleclass'
require 'point'

Entity = class("Entity")

function Entity:initialize(point)
    self._point = point
    self._alive = true
end

function Entity:update()
    error('Entity.update not implemented.')
end

function Entity:draw()
    error('Entity.draw not implemented.')
end

function Entity:getX()
    return self._point:getX()
end

function Entity:getY()
    return self._point:getY()
end

function Entity:getLocation()
    return self._point
end

function Entity:setLocation(x, y)
    self._point = tonumber(x) ~= nil and Point(x, y) or x -- crude overloading
end

function Entity:moveX(distance)
    self._point = Point(self:getX() + distance, self:getY())
end

function Entity:moveY(distance)
    self._point = Point(self:getX(), self:getY() + distance)
end

function Entity:getWidth()
    error('Entity.getWidth not implemented.')
end

function Entity:getHeight()
    error('Entity.getHeight not implemented.')
end

function Entity:setAlive(alive)
    self._alive = alive
end

function Entity:isAlive()
    return self._alive
end

function Entity:updateEntities(list)
    local iterator = list:iterator()

    while(iterator:hasNext()) do
        local item = iterator:next()

        if (item:isAlive()) then
            item:update()
        else
            iterator:remove()
        end
    end
end

function Entity:drawEntities(list)
    for index, item in ipairs(list:getTable()) do
        item:draw()
    end
end