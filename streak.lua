require 'middleclass'
require 'entity'

Streak = class('Streak', Entity)

function Streak:initialize(point)
    Streak.superclass.initialize(self, point)

    self._age = 0
    self._maxAge = 20
end

function Streak:update()
    if (self:isAlive() and self._age < self._maxAge) then
        self._age = self._age + 1
    else
        self:setAlive(false)
    end
end

function Streak:draw()
    if (self:isAlive()) then
        love.graphics.setColor(255, 148-148/self._maxAge*self._age+20, 51, 255 - 255/self._maxAge*self._age)
        love.graphics.circle("fill", self:getX(), self:getY(), self._age)
    end
end