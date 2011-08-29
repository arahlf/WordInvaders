require 'middleclass'

Point = class('Point')

function Point:initialize(x, y)
    self._x = x
    self._y = y
end

function Point:getX()
    return self._x
end

function Point:getY()
    return self._y
end