require 'middleclass'
require 'streak'

local img = love.graphics.newImage('resources/images/missile.png')
local OFFSET_RADIANS = 2 * math.pi / 4


Missile = class('Missile')

function Missile:initialize(target)
    self.target = target
    self.x = love.graphics.getWidth() / 2 - (img:getWidth() / 2)
    self.y = love.graphics.getHeight() - img:getHeight()
    self.speed = 10
    self.radians = 0
    self.streaks = {}
end

local count = 0

function Missile:move()
    local dx = (self.target.x + self.target.img:getWidth() / 2) - (self.x + img:getWidth() / 2)
    local dy = self.target.y + self.target.img:getHeight() / 2 - self.y
    self.radians = math.atan2(dy, dx)

    table.insert(self.streaks, Streak:new(self.x + img:getWidth() / 2, self.y))

    self.x = self.x + math.cos(self.radians) * self.speed
    self.y = self.y + math.sin(self.radians) * self.speed
end

function Missile:isDestroyed()
    return self.y <= self.target.y + self.target.img:getHeight()
end

function Missile:draw()
    for index, streak in pairs(self.streaks) do
        streak:draw()
    end

    love.graphics.draw(img, self.x, self.y, self.radians + OFFSET_RADIANS)
end
