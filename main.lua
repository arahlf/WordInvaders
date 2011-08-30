require 'middleclass'
require 'spaceship'
require 'missile'
require 'turret'
require 'bomb'
require 'images'
require 'list'
require 'missilefactory'
require 'entity'
require 'point'

local ship = SpaceShip()
local turret = Turret(Point(love.graphics.getWidth() / 2, love.graphics.getHeight()), MissileFactory())

enemies = List()

function love.draw()
    for index, enemy in ipairs(enemies:getTable()) do
        enemy:draw()
    end

    turret:draw()
    ship:draw()
end

function love.load()
    math.randomseed(os.time());

    font = love.graphics.newFont('resources/fonts/arialbd.ttf', 14)
    love.graphics.setFont(font)

    love.graphics.setBackgroundColor(255, 255, 255)
end

function love.keypressed(key, unicode)
    for index, enemy in ipairs(enemies:getTable()) do
        if enemy._char:lower() == key then
            turret:fireMissile(enemy)
            break
        end
    end
end

function love.update()
    local iterator = enemies:iterator()

    while(iterator:hasNext()) do
        local enemy = iterator:next()

        if (enemy:isAlive()) then
            enemy:update()
        else
            iterator:remove()
        end
    end

    turret:update()
    ship:update()
end