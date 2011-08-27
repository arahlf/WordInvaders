require 'middleclass'

Streak = class('Streak')

function Streak:initialize(x, y)
    self.x = x
    self.y = y
    self.age = 0
end

function Streak:draw()
    if (self.age < 20) then
        self.age = self.age + 1
        local r, g, b, a = love.graphics.getColor()
        love.graphics.setColor(255, 148-148/20*self.age+20, 51, 255 - 255/20*self.age)
        love.graphics.circle("fill", self.x, self.y, self.age)
        love.graphics.setColor(r,g,b,a)
    end
end