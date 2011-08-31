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

local ship = SpaceShip()
local lastUpdate = 0
local fps
local turret = Turret(Point(love.graphics.getWidth() / 2, love.graphics.getHeight()), MissileFactory())

enemies = List()

function love.draw()
    for index, enemy in ipairs(enemies:getTable()) do
        enemy:draw()
    end

    ship:draw()
    turret:draw()

    Colors.BLACK:set()
    Fonts.DIAGNOSTICS:set()
    love.graphics.print("FPS: " .. fps, 2, 0)
end

function love.load()
    math.randomseed(os.time());
    math.random() math.random() math.random()

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

function love.update(dt)
    local seconds = os.time()

    if (seconds > lastUpdate) then
        fps = math.floor((1 / dt))
        lastUpdate = seconds
    end

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