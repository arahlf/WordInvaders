require 'gamestatemanager'
require 'game'
require 'intro'
require 'fonts'

function getClosetTurret(enemy)
    local distance
    local closestTurret

    for index, turret in ipairs(game.turrets) do
        local turretDistance = Utils.getDistance(turret:getLocation(), enemy:getLocation())
        if (distance == nil or turretDistance < distance) then
            distance = turretDistance
            closestTurret = turret
        end
    end

    return closestTurret
end

function love.load()
    love.graphics.setCaption('Word Invaders')

    math.randomseed(os.time());
    math.random() math.random() math.random()

    love.graphics.setBackgroundColor(255, 255, 255)

    GameStateManager:init()
    GameStateManager:switch(intro)
end

function love.keypressed(key, unicode)
    if (key == 'w' and love.keyboard.isDown('lctrl')) then
        love.event.push('q') -- quit the game
    end
end
