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
require 'tableextras'

local ship = SpaceShip()
local lastUpdate = 0
local fps

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
local third = width / 3

turrets = {
    Turret(Point(third - third / 2, height), MissileFactory()),
    Turret(Point(third * 2 - third / 2, height), MissileFactory()),
    Turret(Point(third * 3 - third / 2, height), MissileFactory())
}

enemies = List()
attacked = {}
missed = 0

function getClosetTurret(enemy)
    local distance
    local closestTurret

    for index, turret in ipairs(turrets) do
        local turretDistance = Utils.getDistance(turret:getLocation(), enemy:getLocation())
        if (distance == nil or turretDistance < distance) then
            distance = turretDistance
            closestTurret = turret
        end
    end

    return closestTurret
end

function love.draw()
    for index, enemy in ipairs(enemies:getTable()) do
        enemy:draw()
    end

    ship:draw()

    for key, turret in pairs(turrets) do
        turret:draw()
    end

    FPSCounter:draw()

    local missedText = "Missed: " .. missed

    love.graphics.print(missedText, love.graphics.getWidth() - love.graphics.getFont():getWidth(missedText) - 5, 0)
end

function love.load()
    math.randomseed(os.time());
    math.random() math.random() math.random()

    Interface.implement(Bomb, Enemy)

    love.graphics.setBackgroundColor(255, 255, 255)


    print(love.graphics.getWidth())
    print(third - third / 2)
    print(third * 2 - third / 2)
    print(third * 3 - third / 2)
end

function love.keypressed(key, unicode)
    for index, enemy in ipairs(enemies:getTable()) do
        if enemy._char:lower() == key and not table.contains(attacked, enemy) then
            getClosetTurret(enemy):fireMissile(enemy)
            table.insert(attacked, enemy)
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

    for key, turret in pairs(turrets) do
        turret:update()
    end

    ship:update()
end