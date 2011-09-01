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
require 'utils'
require 'fonts'
require 'interface'
require 'enemy'
require 'fpscounter'

local ship = SpaceShip()
local lastUpdate = 0
local fps
local turret = Turret(Point(love.graphics.getWidth() / 2, love.graphics.getHeight()), MissileFactory())

enemies = List()
missed = 0

function love.draw()
    for index, enemy in ipairs(enemies:getTable()) do
        enemy:draw()
    end

    ship:draw()
    turret:draw()

    FPSCounter:draw()

    local missedText = "Missed: " .. missed

    love.graphics.print(missedText, love.graphics.getWidth() - love.graphics.getFont():getWidth(missedText) - 5, 0)
end

function love.load()
    math.randomseed(os.time());
    math.random() math.random() math.random()

    Interface.implement(Bomb, Enemy)

    love.graphics.setBackgroundColor(255, 255, 255)
end

function love.keypressed(key, unicode)
    for index, enemy in ipairs(enemies:getTable()) do
        if enemy._char:lower() == key and not enemy._targeted then
            turret:fireMissile(enemy)
            enemy:highlight()
            break
        end
    end
end

function love.update(dt)
    FPSCounter:update(dt)

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