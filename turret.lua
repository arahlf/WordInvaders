require 'middleclass'

Turret = class('Turret')

function Turret:initialize()
    self.image = love.graphics.newImage('resources/images/turret.png')
end

function Turret:draw()
    love.graphics.draw(self.image, love.graphics.getWidth() / 2 - (self.image:getWidth() /2), love.graphics.getHeight() - self.image:getHeight())
end