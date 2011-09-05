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
require 'tableextras'

local ship = SpaceShip()
local lastUpdate = 0
local fps
local paused = false

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

enemies:add(ship)

local focusedEnemy


-- TODO only highligh, but remove letters from enemies as they are targetted?
--      "bullet time" mode (shift)
--      tab to remove focus


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
    for key, turret in pairs(turrets) do
        turret:draw()
    end

    for index, enemy in ipairs(enemies:getTable()) do
        enemy:draw()
    end

    Colors.BLACK:set()
    Fonts.DIAGNOSTICS:set()
    love.graphics.print("FPS: " .. love.timer.getFPS(), 2, 0)

    local missedText = "Missed: " .. missed

    love.graphics.print(missedText, love.graphics.getWidth() - love.graphics.getFont():getWidth(missedText) - 5, 0)
end

function love.load()
    math.randomseed(os.time());
    math.random() math.random() math.random()

    love.graphics.setBackgroundColor(255, 255, 255)
end

function love.keypressed(key, unicode)
    if (key == 'w' and love.keyboard.isDown('lctrl')) then
        love.event.push('q') -- quit the game
    
    elseif (key == 'tab') then
        if (focusedEnemy ~= nil) then
            focusedEnemy:unfocus()
            focusedEnemy = nil
        end
    
    elseif (key == 'escape') then
        paused = not paused

    elseif (not paused) then
        if (focusedEnemy ~= nil) then
            if (focusedEnemy:getNextLetter() == key) then
                focusedEnemy:removeNextLetter()

                if (focusedEnemy:getWordLength() == 0) then
                    getClosetTurret(focusedEnemy):fireMissile(focusedEnemy)
                    table.insert(attacked, focusedEnemy)
                    focusedEnemy = nil
                    enemies:add(SpaceShip())
                end
            end
        else
            for index, enemy in ipairs(enemies:getTable()) do
                if enemy:getNextLetter() == key and not table.contains(attacked, enemy) then
                    enemy:removeNextLetter()

                    if (enemy:getWordLength() == 0) then
                        getClosetTurret(enemy):fireMissile(enemy)
                        table.insert(attacked, enemy)
                        enemy:focus()
                    else
                        enemy:focus()
                        focusedEnemy = enemy
                    end
                    break
                end
            end
        end
        
    end
end

function love.update(dt)
    if (not paused) then
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
    end
end